import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_livraria_1/apis/servicos.dart';
import 'package:flutter_livraria_1/components/image_placehoder.dart';
import 'package:flutter_livraria_1/models/comentario.dart';
import 'package:flutter_livraria_1/models/livro.dart';
import 'package:flutter_livraria_1/utils/estado.dart';
import 'package:intl/intl.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Detalhes extends StatefulWidget {
  final int livroid;
  const Detalhes({super.key, required this.livroid});

  @override
  State<Detalhes> createState() => _DetalhesState();
}

late List<Widget> paginas;

class _DetalhesState extends State<Detalhes> {
  late ServicoLivro _servicoLivro;
  late ServicoComentarios _servicoComentarios;
  late ServicoCurtidas _servicoCurtidas;

  late PageController _controladorSlides;
  late int _slideSelecionado;

  late List<Comentario> _comentarios = [];
  late Livro _livro;

  bool _curtiu = false;
  bool _temComentarios = false;
  bool _carregando = false;

  late TextEditingController _controladorNovoComentario;

  @override
  void initState() {
    super.initState();

    _servicoLivro = ServicoLivro();
    _servicoComentarios = ServicoComentarios();
    _servicoCurtidas = ServicoCurtidas();

    setState(() {
      _carregando = true;
    });

    _carregarLivro();
    _iniciarSlides();

    _controladorNovoComentario = TextEditingController();
  }

  void _iniciarSlides() {
    _slideSelecionado = 0;
    _controladorSlides = PageController(initialPage: _slideSelecionado);
  }

  void _carregarLivro() {
    _servicoLivro
        .getLivro(widget.livroid)
        .then((item) => setState(() {
              _livro = Livro(
                  id: item['id'],
                  titulo: item['titulo'],
                  autor: item['autor'],
                  curtidas: item['curtidas'],
                  preco: item['preco'],
                  paginas: item['paginas'],
                  genero: item['genero'],
                  sinopse: item['sinopse'],
                  imagem1: item['imagem1'],
                  imagem2: item['imagem2']);
            }))
        .then((_) => _carregarComentarios())
        .then((_) => {_getCurtiu()});
  }

  void _carregarComentarios() {
    _servicoComentarios.getComentarios(widget.livroid).then((comentarios) => {
          setState(() {
            _comentarios = [];
            comentarios.forEach((item) {
              _comentarios.add(Comentario(
                  id: item['id'],
                  nome: item['nome'],
                  conta: item['conta'],
                  data: item['data'],
                  comentario: item['comentario']));
            });

            _temComentarios = _comentarios.isNotEmpty;
          })
        });
  }

  void _adicionarComentario(EstadoApp provider) {
    String conteudo = _controladorNovoComentario.text.trim();

    if (conteudo.isNotEmpty) {
      _servicoComentarios
          .adicionar(widget.livroid, provider.usuario!, conteudo)
          .then((_) => {
                setState(() {
                  _comentarios = [];
                  _carregarComentarios();
                  _temComentarios = true;
                })
              });

      _controladorNovoComentario.clear();
    } else {
      Toast.show("Digite um comentário",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    }
  }

  void _removerComentario(int idComentario) {
    _servicoComentarios.remover(idComentario).then((resultado) {
      if (resultado["situacao"] == "ok") {
        Toast.show("comentário removido com sucesso",
            duration: Toast.lengthLong, gravity: Toast.bottom);
        _comentarios = [];
        _carregarComentarios();
      }
    });
  }

  void _curtir(String conta) {
    _servicoCurtidas.curtir(conta, widget.livroid).then((_) => setState(() {
          _carregarLivro();
          _curtiu = true;
        }));
  }

  void _descurtir(String conta) {
    _servicoCurtidas.descurtir(conta, widget.livroid).then((_) => setState(() {
          _carregarLivro();
          _curtiu = false;
        }));
  }

  void _getCurtiu() {
    if (context.read<EstadoApp>().usuario != null) {
      String conta = context.read<EstadoApp>().usuario!.email!;
      _servicoCurtidas
          .curtiu(conta, widget.livroid)
          .then((value) => setState(() {
                _curtiu = value;
                _carregando = false;
              }));
    } else {
      _carregando = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EstadoApp>(context);

    return _carregando
        ? Scaffold(
            backgroundColor: const Color.fromARGB(255, 231, 230, 230),
            appBar: AppBar(
              title: const Text("Carregando..."),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: const Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              title: Text(_livro.titulo),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            child: PageView.builder(
                              itemCount: 2,
                              controller: _controladorSlides,
                              onPageChanged: (slide) {
                                setState(() {
                                  _slideSelecionado = slide;
                                });
                              },
                              itemBuilder: (context, index) {
                                return ImagePlacehoder(
                                    image: index == 0
                                        ? _livro.imagem1
                                        : _livro.imagem2);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: PageViewDotIndicator(
                              currentItem: _slideSelecionado,
                              count: 2,
                              unselectedColor: Colors.black26,
                              selectedColor: Theme.of(context).primaryColor,
                              duration: const Duration(milliseconds: 200),
                              boxShape: BoxShape.circle,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                _livro.titulo,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _livro.autor,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                _livro.genero,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.auto_stories_outlined),
                                  const SizedBox(width: 6),
                                  Text("${_livro.paginas} páginas"),
                                ],
                              ),
                              Text(
                                "R\$ ${_livro.preco}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const Divider(
                                color: Color.fromARGB(255, 231, 230, 230),
                                thickness: 1,
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      provider.usuario != null
                                          ? IconButton(
                                              onPressed: () {
                                                if (_curtiu) {
                                                  _descurtir(
                                                      provider.usuario!.email!);
                                                } else {
                                                  _curtir(
                                                      provider.usuario!.email!);
                                                }
                                              },
                                              icon: Icon(_curtiu
                                                  ? Icons.favorite
                                                  : Icons.favorite_border),
                                              color: _curtiu
                                                  ? Colors.red
                                                  : Colors.grey,
                                              iconSize: 20)
                                          : const SizedBox(width: 45),
                                      Text("${_livro.curtidas} Curtidas",
                                          style: const TextStyle(fontSize: 15))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 20),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Text(
                              "Sinopse",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              color: Color.fromARGB(255, 231, 230, 230),
                              thickness: 1,
                              height: 10,
                            ),
                            Text(
                              _livro.sinopse,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Comentários",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 231, 230, 230),
                            thickness: 1,
                            height: 10,
                          ),
                          provider.usuario != null
                              ? Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: TextField(
                                    controller: _controladorNovoComentario,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black87, width: 0.0),
                                      ),
                                      border: const OutlineInputBorder(),
                                      hintStyle: const TextStyle(fontSize: 14),
                                      hintText: 'Digite aqui seu comentário...',
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _adicionarComentario(provider);
                                        },
                                        child: const Icon(Icons.send,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                              height: 400,
                              child: _temComentarios
                                  ? ListView.builder(
                                      itemCount: _comentarios.length,
                                      itemBuilder: (context, index) {
                                        String dataFormatada =
                                            DateFormat('dd/MM/yyyy HH:mm')
                                                .format(DateTime.parse(
                                                    _comentarios[index].data));
                                        bool usuarioLogadoComentou =
                                            provider.usuario != null &&
                                                provider.usuario!.email ==
                                                    _comentarios[index].conta;
                                        return Dismissible(
                                          key: Key(_comentarios[index]
                                              .id
                                              .toString()),
                                          direction: usuarioLogadoComentou
                                              ? DismissDirection.endToStart
                                              : DismissDirection.none,
                                          onDismissed: (direction) {
                                            if (direction ==
                                                DismissDirection.endToStart) {
                                              Comentario comentarioExcluido =
                                                  _comentarios[index];
                                              setState(() {
                                                _comentarios.removeAt(index);
                                                _temComentarios =
                                                    _comentarios.isNotEmpty;
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext contexto) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Deseja apagar o comentário?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                _comentarios.insert(
                                                                    index,
                                                                    comentarioExcluido);
                                                                _temComentarios =
                                                                    true;
                                                              });

                                                              Navigator.of(
                                                                      contexto)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "NÃO")),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                _removerComentario(
                                                                    comentarioExcluido
                                                                        .id);
                                                              });

                                                              Navigator.of(
                                                                      contexto)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "SIM"))
                                                      ],
                                                    );
                                                  });
                                            }
                                          },
                                          background: Container(
                                            alignment: Alignment.centerRight,
                                            color: Colors.red,
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(Icons.delete,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          child: Card(
                                            color: usuarioLogadoComentou
                                                ? const Color.fromARGB(
                                                    255, 109, 125, 199)
                                                : Colors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(_comentarios[index]
                                                      .comentario),
                                                  Row(
                                                    children: [
                                                      Text(_comentarios[index]
                                                          .nome),
                                                      const SizedBox(width: 6),
                                                      Text(dataFormatada)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.error,
                                                size: 32, color: Colors.grey),
                                            Text("não existem comentários",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.grey))
                                          ]),
                                    ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
