import 'package:flutter/material.dart';
import 'package:flutter_livraria_1/apis/servicos.dart';

class ImagePlacehoder extends StatelessWidget {
  final String image;
  const ImagePlacehoder({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      caminhoArquivo(image),
      fit: BoxFit.contain,
    );
  }
}
