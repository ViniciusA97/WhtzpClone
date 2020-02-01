import 'package:whatsapp_clone/modelo/usuario.dart';

import 'conversa.dart';

class Mensagem{
  DateTime _data;
  String _msg;
  Usuario _emissor;
  List<Conversa> _conversa;
  
  List get idConversa => _conversa;
  String get msg => _msg;
  DateTime get data => _data;
  Usuario get emissor => _emissor;

  Mensagem(this._data, this._msg);
}