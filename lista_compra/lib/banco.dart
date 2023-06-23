import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'imagem.dart';
import 'usuario.dart';

class Banco {
  Future<Database>? database;

  Future<void> criarBanco() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'bancoimagem.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE imagem(id INTEGER PRIMARY KEY, url TEXT, titulo TEXT, descricao TEXT, favorito INTEGER DEFAULT 0, id_usuario INTEGER)');
        await db.execute(
            'CREATE TABLE usuario(id INTEGER PRIMARY KEY, nome TEXT, email TEXT, avatar TEXT, login TEXT, senha TEXT)');
        await db.rawInsert(
            'INSERT INTO usuario (nome, email, login, senha) VALUES (?, ?, ?, ?)',
            ['Bruna e Luis', 'Brulu@gmail.com', 'brulu', '123456']);
      },
      version: 1,
    );
  }

  Future<void> inserirImagem(Imagem img) async {
    final db = await database;

    await db!.insert("imagem", img.toMap());
  }

  Future<List<Imagem>> listarImagens() async {
    final db = await database;

    final List<Map<String, dynamic>> map = await db!.query('imagem');

    return List.generate(map.length, (index) {
      return Imagem(
        id: map[index]['id'],
        url: map[index]['url'],
        titulo: map[index]['titulo'],
        descricao: map[index]['descricao'],
        favorito: map[index]['favorito'],
      );
    });
  }

  Future<void> removerImagem(int id) async {
    final db = await database;

    await db!.delete("imagem", where: "id = ?", whereArgs: [id]);
  }

  Future<void> atualizarImagem(Imagem img) async {
    final db = await database;

    await db!.update("imagem", img.toMap(), where: "id = ?", whereArgs: [img.id]);
  }

  Future<List<Imagem>> buscarImagensFavoritas() async {
    final db = await database;
    final List<Map<String, dynamic>> map =
    await db!.query("imagem", where: "favorito = ?", whereArgs: [1]);
    return List.generate(map.length, (index) {
      return Imagem(
        id: map[index]['id'],
        url: map[index]['url'],
        titulo: map[index]['titulo'],
        descricao: map[index]['descricao'],
        favorito: map[index]['favorito'],
      );
    });
  }

  Future<Imagem> obterImagem(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
    await db!.query("imagem", where: "id = ?", whereArgs: [id]);

    Imagem? img;
    if (maps.isNotEmpty) {
      img = Imagem(
        id: maps.first['id'],
        url: maps.first['url'],
        titulo: maps.first['titulo'],
        descricao: maps.first['descricao'],
        favorito: maps.first['favorito'],

      );
    }
    return img!;
  }

  Future<Usuario?> autenticacao(login, senha) async {
    final db = await database;

    List<Map<String, dynamic>> map = await db!.query("usuario",
        where: "login = ? and senha = ?", whereArgs: [login, senha]);

    if (map.isNotEmpty) {
      return Usuario(
        id: map[0]['id'],
        nome: map[0]['nome'],
        email: map[0]['email'],
        login: map[0]['login'],
        senha: map[0]['senha'],
        avatar: map[0]['avatar'],
      );
    } else {
      return null;
    }
  }
}
