from flask import Flask, jsonify
import mysql.connector as mysql

servico = Flask("likes")

SERVIDOR_BANCO = "banco"
USUARIO_BANCO = "root"
SENHA_BANCO = "admin"
NOME_BANCO = "livraria"

def get_conexao_com_bd():
    conexao = mysql.connect(host=SERVIDOR_BANCO, user=USUARIO_BANCO, password=SENHA_BANCO, database=NOME_BANCO)

    return conexao

@servico.get("/info")
def get_info():
    return jsonify(
        descricao = "gerenciamento de curtidas da livraria collins",
        versao = "1.0"
    )

@servico.get("/likes_por_livro/<int:id_do_livro>")
def likes_por_livro(id_do_livro):
    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute("SELECT count(*) as quantidade " +  
                    "FROM likes " +
                    "WHERE likes.id_livro = " + str(id_do_livro))
    likes = cursor.fetchone()

    conexao.close()

    return jsonify(curtidas = likes["quantidade"])

@servico.get("/curtiu/<string:conta>/<int:id_do_livro>")
def curtiu(conta, id_do_livro):
    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute("SELECT count(*) as quantidade " +  
        "FROM likes " +
        "WHERE likes.id_livro = " + str(id_do_livro) + " AND likes.conta = '" + conta + "'"
    )
    likes = cursor.fetchone()

    conexao.close()

    return jsonify(curtiu = likes["quantidade"] > 0)

@servico.post("/curtir/<string:conta>/<int:id_do_livro>")
def curtir(conta, id_do_livro):
    resultado = jsonify(situacao = "ok", erro = "")

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor()
    try:
        cursor.execute(f"INSERT INTO likes(id_livro, conta) VALUES ({str(id_do_livro)}, '{conta}')")
        conexao.commit()
    except:
        conexao.rollback()
        resultado = jsonify(situacao = "erro", erro = "erro curtindo o livro")

    conexao.close()

    return resultado

@servico.post("/descurtir/<string:conta>/<int:id_do_livro>")
def descurtir(conta, id_do_livro):
    resultado = jsonify(situacao = "ok", erro = "")

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor()
    try:
        cursor.execute(f"DELETE FROM likes WHERE id_livro = {str(id_do_livro)} AND conta = '{conta}'")
        conexao.commit()
    except:
        conexao.rollback()
        resultado = jsonify(situacao = "erro", erro = "erro descurtindo o livro")

    conexao.close()

    return resultado


if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)