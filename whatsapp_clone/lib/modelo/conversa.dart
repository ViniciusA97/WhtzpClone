import 'package:whatsapp_clone/modelo/usuario.dart';
import 'mensagem.dart';

class Conversa{
    List<Mensagem> _mensagem;
    List<Usuario> _usuario;
    String _img;
     String _nomeConversa;

   String get nomeConversa => _nomeConversa;
    String get img => _img;
    List get mensagem => _mensagem;
    List get usuario => _usuario;

  Conversa(this._mensagem, this._usuario);
}

