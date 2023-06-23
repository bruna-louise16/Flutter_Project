class Usuario{
  int? id;
  String? nome;
  String? email;
  String? login;
  String? senha;
  String? avatar;

  Usuario({this.id, this.nome, this.email, required this.login, required this.senha, this.avatar});
}