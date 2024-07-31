// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_livraria_1/utils/autenticador.dart';

final URL_SERVICOS = Uri.parse("http://10.0.2.2");

final URL_LIVROS = "${URL_SERVICOS.toString()}:5001/livros";
final URL_LIVRO = "${URL_SERVICOS.toString()}:5001/livro";

final URL_COMENTARIOS = "${URL_SERVICOS.toString()}:5002/comentarios";
final URL_ADICIONAR_COMENTARIO = "${URL_SERVICOS.toString()}:5002/adicionar";
final URL_REMOVER_COMENTARIO = "${URL_SERVICOS.toString()}:5002/remover";

final URL_CURTIU = "${URL_SERVICOS.toString()}:5003/curtiu";
final URL_CURTIR = "${URL_SERVICOS.toString()}:5003/curtir";
final URL_DESCURTIR = "${URL_SERVICOS.toString()}:5003/descurtir";

final URL_ARQUIVOS = "${URL_SERVICOS.toString()}:5005";

class ServicoLivro {
  Future<List<dynamic>> getLivros(
      int ultimo_livro, int tamanho_da_pagina) async {
    final resposta = await http.get(
        Uri.parse("${URL_LIVROS.toString()}/$ultimo_livro/$tamanho_da_pagina"));
    final livros = jsonDecode(resposta.body);

    return livros;
  }

  Future<dynamic> getLivro(int id_livro) async {
    final resposta =
        await http.get(Uri.parse("${URL_LIVRO.toString()}/$id_livro"));
    final livro = jsonDecode(resposta.body);

    return livro;
  }
}

class ServicoCurtidas {
  Future<bool> curtiu(String conta, int id_livro) async {
    final resposta = await http
        .get(Uri.parse("${URL_CURTIU.toString()}/$conta/$id_livro"));
    final resultado = jsonDecode(resposta.body);

    return resultado["curtiu"] as bool;
  }

  Future<dynamic> curtir(String conta, int id_livro) async {
    final resposta = await http
        .post(Uri.parse("${URL_CURTIR.toString()}/$conta/$id_livro"));

    return jsonDecode(resposta.body);
  }

  Future<dynamic> descurtir(String conta, int id_livro) async {
    final resposta = await http.post(
        Uri.parse("${URL_DESCURTIR.toString()}/$conta/$id_livro"));

    return jsonDecode(resposta.body);
  }
}

class ServicoComentarios {
  Future<List<dynamic>> getComentarios(int id_livro) async {
    final resposta =
        await http.get(Uri.parse("${URL_COMENTARIOS.toString()}/$id_livro"));
    final comentarios = jsonDecode(resposta.body);

    return comentarios;
  }

  Future<dynamic> adicionar(
      int idProduto, Usuario usuario, String comentario) async {
    final resposta = await http.post(Uri.parse(
        "${URL_ADICIONAR_COMENTARIO.toString()}/$idProduto/${usuario.nome}/${usuario.email}/$comentario"));

    return jsonDecode(resposta.body);
  }

  Future<dynamic> remover(int idComentario) async {
    final resposta = await http.delete(
        Uri.parse("${URL_REMOVER_COMENTARIO.toString()}/$idComentario"));

    return jsonDecode(resposta.body);
  }
}

String caminhoArquivo(String arquivo) {
  return "${URL_ARQUIVOS.toString()}/$arquivo";
}
