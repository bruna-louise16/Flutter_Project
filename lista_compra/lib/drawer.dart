import 'package:flutter/material.dart';
import 'package:galeria_imagem/provider_usuario.dart';
import 'package:galeria_imagem/usuario.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {

  @override
  Widget build(BuildContext context) {
    Usuario usr = Provider.of<UsuarioProvider>(context, listen: true).usuario;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.account_circle),
                  ),
                  ListTile(
                    title: Text(usr.nome!),
                    subtitle: Text(usr.email!),
                  )
                ],
              )
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, "/home");
            },
            leading: Icon(Icons.home),
            title: Text("Início"),
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, "/telaimagem");
            },
            leading: Icon(Icons.image),
            title: Text("Galeria"),
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, "/telausuario");
            },
            leading: Icon(Icons.account_box),
            title: Text("Usuário"),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, "/");
            },
            leading: Icon(Icons.logout),
            title: Text("Sair"),
          ),
        ],
      ),
    );
  }
}

