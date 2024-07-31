from flask import Flask, jsonify
from urllib.request import urlopen
import mysql.connector as mysql
import json

servico = Flask("livros")

SERVIDOR_BANCO = "banco"
USUARIO_BANCO = "root"
SENHA_BANCO = "admin"
NOME_BANCO = "livraria"

def get_conexao_com_bd():
    conexao = mysql.connect(host=SERVIDOR_BANCO, user=USUARIO_BANCO, password=SENHA_BANCO, database=NOME_BANCO)

    return conexao


URL_LIKES = "http://likes:5000/likes_por_livro/"

def get_quantidade_de_curtidas(id_do_livro):
    url = URL_LIKES + str(id_do_livro)
    resposta = urlopen(url)
    resposta = resposta.read()
    resposta = json.loads(resposta)

    return resposta["curtidas"]

@servico.get("/info")
def get_info():
    return jsonify(
        descricao = "gerenciamento de livros da livraria collins",
        versao = "1.0"
    )

@servico.get("/livros/<int:ultimo_livro>/<int:tamanho_da_pagina>")
def get_livros(ultimo_livro, tamanho_da_pagina):
    livros = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "SELECT `titulo`, `id`, `imagem2` " +
        "FROM `livros` " +
        "WHERE id > " + str(ultimo_livro) +
        " LIMIT " + str(tamanho_da_pagina))
    
    livros = cursor.fetchall()
    
    conexao.close()

    return jsonify(livros)

@servico.get("/livro/<int:id_do_livro>")
def find_livro(id_do_livro):
    livro = {}

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "SELECT `id`, `titulo`, `autor`, `preco`, `genero`, `paginas`, `sinopse`, `imagem1`, `imagem2` " +
        "FROM `livros` " +
        "WHERE `id` = " + str(id_do_livro)
    )
    livro = cursor.fetchone()
    if livro:
        livro["curtidas"] = get_quantidade_de_curtidas(id_do_livro)

    conexao.close()

    return jsonify(livro)


if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)