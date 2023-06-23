import 'package:flutter/material.dart';
import 'package:galeria_imagem/provider_usuario.dart';
import 'package:galeria_imagem/tela_imagem.dart';
import 'package:galeria_imagem/tela_login.dart';
import 'package:galeria_imagem/tela_usuario.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'banco.dart';
import 'imagem.dart';

void main() async {
  Banco bd = Banco();
  await bd.criarBanco();
  print("Banco criado!!");

  // Verificar se as imagens já foram inseridas antes de inserir novamente
  List<Imagem> imagens = await bd.listarImagens();
  if (imagens.isEmpty) {
    await bd.inserirImagem(Imagem(
      url: "https://cdn0.tudoreceitas.com/pt/posts/1/4/2/lasanha_de_frango_241_orig.jpg",
      titulo: "Lasanha",
      descricao: "Lasanha de frango 13 reais",
      favorito: 0,
    ));
    await bd.inserirImagem(Imagem(
      url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUZEBdzr-ztZwUzZTcd3dkqrECyjc6GK-VHQ&usqp=CAU",
      titulo: "Cachorro quente",
      descricao: "Cachorro quente",
      favorito: 0,
    ));
    await bd.inserirImagem(Imagem(
      url: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Mama_instant_noodle_block.jpg/300px-Mama_instant_noodle_block.jpg",
      titulo: "Miojo",
      descricao: "Miojo cru",
      favorito: 0,
    ));
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
      ],
      child: MaterialApp(
        //home: TelaLogin(bd: bd,),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => TelaLogin(bd: bd,),
          "/home": (context) => Home(bd: bd,),
          "/telausuario": (context) => TelaUsuario(),
          "/telaimagem": (context) => TelaImagem(bd: bd,),
        },
      ),
    ),
  );
}
