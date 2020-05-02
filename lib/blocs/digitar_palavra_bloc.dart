import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

class DigitarPalavraBloc implements BlocBase{

  String _palavra = "";

  final _digitarController = StreamController<String>();
  Sink get inDigitarLetra => _digitarController.sink;

  final _mostraController = StreamController<String>();
  Stream get outPalavra => _mostraController.stream;

  final _apagarController = StreamController<bool>();
  Sink get inApagarLetra => _apagarController.sink;

  final _apagarPalavraController = StreamController<bool>();
  Sink get inApagarPalavra => _apagarPalavraController.sink;

  String get getPalavra => _palavra;

  DigitarPalavraBloc(){
    _digitarController.stream.listen(palavraBuilder);
    _apagarController.stream.listen(apagarLetra);
    _apagarPalavraController.stream.listen(apagarPalavra);

  }

  void palavraBuilder(String letra){
    _palavra += letra;
    _mostraController.sink.add(_palavra);
  }

  void apagarLetra(bool apagar){
    if(!_palavra.isEmpty && apagar){
      _palavra = _palavra.substring(0,_palavra.length - 1);
      _mostraController.sink.add(_palavra);
    }
  }

  void apagarPalavra(bool apagar){
    _palavra = "";
    _mostraController.sink.add(_palavra);
  }


  @override
  void dispose() {
    _digitarController.close();
    _mostraController.close();
    _apagarController.close();
    _apagarPalavraController.close();
  }
}