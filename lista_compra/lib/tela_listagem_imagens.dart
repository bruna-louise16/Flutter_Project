import 'package:flutter/material.dart';
import 'banco.dart';
import 'drawer.dart';
import 'imagem.dart';
import 'imagem_detalhe.dart';

class ListagemImagens extends StatefulWidget {
  final Banco? bd;

  ListagemImagens({Key? key, this.bd}) : super(key: key);

  @override
  State<ListagemImagens> createState() => _ListagemImagensState();
}

class _ListagemImagensState extends State<ListagemImagens> {
  List<Imagem> imagens = [];

  @override
  void initState() {
    super.initState();
    inicializarBanco();
    carregarImagens();
  }

  Future<void> inicializarBanco() async {
    await widget.bd!.criarBanco();
  }

  Future<void> carregarImagens() async {
    imagens = await widget.bd!.listarImagens();
    setState(() {
      imagens;
    });
  }

  Future<void> atualizarFavoritos(Imagem img) async {
    img.favorito = img.favorito == 1 ? 0 : 1;
    await widget.bd!.atualizarImagem(img);
    setState(() {
      imagens = List.from(imagens); // Atualizar a lista de imagens para refletir a alteração
    });
  }

  Future<void> removerImagem(int id) async {
    await widget.bd!.removerImagem(id);
    await carregarImagens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Imagem"),
      ),
      drawer: DrawerMenu(),
      body: imagens.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: imagens.length,
        itemBuilder: (context, index) {
          final imagem = imagens[index];
          return ListTile(
            title: Text(imagem.titulo),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imagem.url),
            ),
            trailing: IconButton(
              icon: Icon(
                imagem.favorito == 1 ? Icons.star : Icons.star_border,
                color: Colors.blue,
              ),
              onPressed: () {
                atualizarFavoritos(imagem);
              },
            ),
            onTap: () async {
              final id = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImagemDetalhe(
                    img: imagem,
                    bd: widget.bd,
                  ),
                ),
              );
              if (id != null) {
                removerImagem(id);
              }
            },
          );
        },
      ),
    );
  }
}
