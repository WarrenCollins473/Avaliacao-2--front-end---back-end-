import 'package:flutter/material.dart';
import 'package:flutter_livraria_1/apis/servicos.dart';
import 'package:flutter_livraria_1/components/livro_item.dart';
import 'package:flutter_livraria_1/models/feed.dart';
import 'package:flutter_livraria_1/utils/autenticador.dart';
import 'package:flutter_livraria_1/utils/estado.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class FeedLivros extends StatefulWidget {
  const FeedLivros({super.key});

  @override
  State<FeedLivros> createState() => _FeedLivrosState();
}

class _FeedLivrosState extends State<FeedLivros> {
  late ServicoLivro _servicoLivro;
  late List<Feed> _Feedlivros = [];
  bool _carregando = false;
  final ScrollController _scrollController = ScrollController();
  final int _tamanhoPagina = 8;
  int _ultimoLivro = 0;

  @override
  void initState() {
    super.initState();

    ToastContext().init(context);

    _scrollController.addListener(_scrollListener);
    _servicoLivro = ServicoLivro();

    _carregarLivros();
  }

  Future<void> _carregarLivros() async {
    setState(() {
      _carregando = true;
    });

    _servicoLivro.getLivros(_ultimoLivro, _tamanhoPagina).then((livros) => {
          setState(() {
            _listarLivros(livros);
            _carregando = false;
            _ultimoLivro = _Feedlivros.last.id;
          })
        });
  }

  void _listarLivros(List<dynamic> livros) {
    livros.forEach((item) {
      bool contem = _Feedlivros.any((livro) => livro.id == item["id"]);
      if (!contem) {
        _Feedlivros.add(Feed(
            id: item['id'], titulo: item['titulo'], imagem: item['imagem2']));
      }
    });
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _carregando = true;

        if (_carregando) {
          _carregarLivros();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EstadoApp>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Collins's Books"),
        actions: [
          provider.usuario != null
              ? IconButton(
                  onPressed: () {
                    Autenticador.logout().then((_) {
                      setState(() {
                        provider.onLogout();
                      });
                      Toast.show("Você não está mais conectado",
                          duration: Toast.lengthLong, gravity: Toast.bottom);
                    });
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ))
              : IconButton(
                  onPressed: () {
                    Autenticador.login().then((usuario) {
                      setState(() {
                        provider.onLogin(usuario);
                      });

                      Toast.show("Você foi conectado com sucesso",
                          duration: Toast.lengthLong, gravity: Toast.bottom);
                    });
                  },
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: RefreshIndicator(
          onRefresh: _carregarLivros,
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1 / 1.5),
            itemCount: _Feedlivros.length,
            itemBuilder: (_, index) {
              return LivroItem(feedLivro: _Feedlivros[index]);
            },
          ),
        ),
      ),
    );
  }
}
