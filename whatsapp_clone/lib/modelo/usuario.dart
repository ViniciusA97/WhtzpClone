
import 'package:whatsapp_clone/modelo/conversa.dart';

class Usuario{
  String _numero;
  String _nome;
  String _img;
  List<Conversa> _conversas;
  int _idUsuario;
  int get idUsuario => _idUsuario;

  List get conversas => _conversas;
  String get numero => _numero;
  String get nome => _nome;
  String get img => _img;

  Usuario(this._img, this._nome, this._numero, this._conversas, this._idUsuario);
}