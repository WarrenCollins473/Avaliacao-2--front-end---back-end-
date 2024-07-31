class Livro {
  final int id;
  final String titulo;
  final String autor;
  final int curtidas;
  final String preco;
  final String genero;
  final String paginas;
  final String sinopse;
  final String imagem1;
  final String imagem2;

  Livro(
      {required this.id,
      required this.titulo,
      required this.autor,
      required this.curtidas,
      required this.preco,
      required this.paginas,
      required this.genero,
      required this.sinopse,
      required this.imagem1,
      required this.imagem2});
}
