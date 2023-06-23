import 'package:flutter/material.dart';
import 'package:galeria_imagem/drawer.dart';

class TelaUsuario extends StatefulWidget {
  const TelaUsuario({Key? key}) : super(key: key);

  @override
  State<TelaUsuario> createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuário"),
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          Text("Tela usuário"),
        ],
      ),
    );
  }
}
