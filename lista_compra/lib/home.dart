import 'package:flutter/material.dart';
import 'package:galeria_imagem/drawer.dart';
import 'package:galeria_imagem/tela_grid_imagens.dart';
import 'package:galeria_imagem/tela_imagem.dart';
import 'package:galeria_imagem/tela_listagem_imagens.dart';
import 'package:galeria_imagem/tela_favoritos.dart';

import 'banco.dart';

class Home extends StatefulWidget {
  Banco? bd;

  Home({Key? key, this.bd}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int barraNavegacaoIndex = 0;
  var telaImagem;
  var telaListagemImagens;
  var telaGridImagens;
  var telaFavoritos;

  List<Widget>? telas;

  @override
  Widget build(BuildContext context) {

    telaImagem = TelaImagem(bd: widget.bd,);
    telaListagemImagens = ListagemImagens(bd: widget.bd,);
    telaGridImagens = GridImagens();
    telaFavoritos = TelaFavoritos(bd: widget.bd,);

    telas = [telaImagem, telaListagemImagens, telaGridImagens, telaFavoritos];

    return Scaffold(
      drawer: DrawerMenu(),
      body: Center(
        child: telas!.elementAt(barraNavegacaoIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: "Imagem",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Listagem",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_4x4),
            label: "Grid",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: "Favoritos",
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: barraNavegacaoIndex,
        selectedItemColor: Colors.black,
        onTap: (index){
          setState(() {
            barraNavegacaoIndex = index;
          });
        },
      ),
    );
  }
}
