import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_livraria_1/apis/servicos.dart';
import 'package:flutter_livraria_1/models/feed.dart';
import 'package:flutter_livraria_1/screens/detalhes.dart';

class LivroItem extends StatelessWidget {
  final Feed feedLivro;
  const LivroItem({super.key, required this.feedLivro});

  void _selectLivro(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Detalhes(livroid: feedLivro.id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _selectLivro(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                caminhoArquivo(feedLivro.imagem),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 150,
                  alignment: Alignment.center,
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      feedLivro.titulo,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
