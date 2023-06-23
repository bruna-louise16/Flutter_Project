import 'package:flutter/material.dart';
import 'banco.dart';
import 'drawer.dart';
import 'imagem.dart';

class TelaFavoritos extends StatefulWidget {
  Banco? bd;

  TelaFavoritos({Key? key, this.bd}) : super(key: key);

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  List<Imagem> limg = [];

  Future<void> carregarImagensFavoritas() async {
    limg = await widget.bd!.buscarImagensFavoritas();
    setState(() {
      limg;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarImagensFavoritas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      drawer: DrawerMenu(),
      body: limg.isEmpty
          ? Center(child: Text("Nenhum favorito encontrado."))
          : ListView.builder(
        itemCount: limg.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(limg[index].titulo),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(limg[index].url),
            ),
          );
        },
      ),
    );
  }
}
