import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:whatsapp_clone/modelo/conversa.dart';
import 'package:whatsapp_clone/modelo/mensagem.dart';
import 'package:whatsapp_clone/modelo/usuario.dart';
class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  // Create table
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Usuario(idUser INTEGER PRIMARY KEY , nome TEXT, numero TEXT,  imagem VARCHAR);");
    await db.execute(
        "CREATE TABLE Conversa(idConversa INTEGER PRIMARY KEY, nome TEXT, imagem VARCHAR, idUserRemetente INTEGER, FOREING KEY(idUserRemetente) REFERENCES Usuario(idUserRemetente) );");
    await db.execute(
      "CREATE TABLE Mensagem(idMsg INTEGER  PRIMARY KEY, idUserEmissor INTEGER, idConversa INTEGER, FOREIGN KEY(idUserEmissor) REFERENCES Usuario(idUserEmissor), FOREIGN KEY(idConversa) REFERENCES Conversa(idConversa), data DATETIME);");
    }

//insertion
  Future<int> saveUser(Usuario user) async {
    var dbClient = await db;
    int usuario = await dbClient.rawInsert("INSERT INTO Usuario (nome, numero, imagem) VALUES(?,?,?,?)",[user.nome,user.numero,user.img, user.conversas]);
    return usuario;
  }

  Future<int> saveConversa(Conversa conv) async {
    var dbClient = await db;
    int conversa = await dbClient.rawInsert("INSERT INTO Conversa (nome, imagem, idUserRemetente) VALUES(?,?,?)",[conv.nomeConversa,conv.img, conv.usuario]);
    return conversa;
  }

  Future<int> saveMsg(Mensagem msg) async {
    var dbClient = await db;
    int mensagem = await dbClient.rawInsert("INSERT INTO Mensagem (idUserEmissor,data) VALUES(?,?)",[msg.emissor,msg.data]);
    return mensagem;
  }

  //Busca

  Future<dynamic> getUser(String numero) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("Usuario",
    columns: ["nome", 'numero', 'idUser', 'imagem'],
    where: "numero =?",
    whereArgs: ["$numero"]
    );
    List<Conversa> list = getConversa(idUser);

    Usuario user =new Usuario(test[0]["imagem"],test[0]["nome"], test[0]["numero"],)
  }

  Future<Conversa> getConversa(int idUser) async{
    var dbConversa = await db;
    dynamic test = await dbConversa.query("Conversa",
    columns:[""]);
  }

  Future<dynamic> getRest(String name) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("Restaurant",
    columns: ['idRest, name, password , numPedidos , image , description , email, address, num'],
    where: "name =?",
    whereArgs: ["$name"]
    );
    print(test);

    try{
        //Restaurant temp = Restaurant.map(test[0]);
        print('Rest --->');
        //return temp;
      
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<List<dynamic>> getPratos(int idRest) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("Pratos",
    columns: ["preco", 'descricao','name'],
    where: "idRest =?",
    whereArgs: ["$idRest"]
    );
    print(test);

    try{
        List<dynamic> cardapio = new List<dynamic>();
        for(var a in test){
          ///Prato usual = new Prato(idRest,a['name'], a['preco'], a['descricao']) ;
          //cardapio.add(usual);
        }
        return cardapio;
      
    }catch(e){
      print(e.toString());
    }
    return null;
  }
 
}

