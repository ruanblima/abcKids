import 'package:abc_kids/blocs/digitar_palavra_bloc.dart';
import 'package:abc_kids/widgets/carregando.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abc_kids/pages/card_digitar_palavra.dart';
import 'package:abc_kids/widgets/background_image.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class ModuloDigitarPalavra extends StatefulWidget {
  final int contador;
  final String nivel;

  ModuloDigitarPalavra({Key key, @required this.contador, this.nivel})
      : super(key: key);
  @override
  _ModuloDigitarPalavraState createState() =>
      _ModuloDigitarPalavraState(contador, nivel);
}

class _ModuloDigitarPalavraState extends State<ModuloDigitarPalavra> {
  DigitarPalavraBloc bloc = DigitarPalavraBloc();

  static AudioCache audioBotao = new AudioCache(prefix: "audios/");
  static AudioCache audioExplicandoModulo = new AudioCache(prefix: "audios/");
  static AudioCache audioLetra = new AudioCache(prefix: "audios/");
  static AudioCache audioResposta = new AudioCache(prefix: "audios/");

  String palavraBuscada = "";

  int contador;
  String nivel;
  _ModuloDigitarPalavraState(this.contador, this.nivel);

  void _atualizarPalavra(int contadorResposta, String nivelResposta) {
    setState(() {
      contador = contadorResposta;
      nivel = nivelResposta;
    });
  }

  void _alertVoceTerminouEsteNivel() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Parabéns!",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 25.0,
                  fontFamily: "SnigletRegular")),
          content: new Text("Você terminou este nível, vamos para o próximo.",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 20.0,
                  fontFamily: "SnigletRegular")),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton.icon(
              color: Color(0xff54c4b7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                audioBotao.play('som_botao.mp3');
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.solidWindowClose,
                color: Colors.white,
              ),
              label: Text(
                'Fechar',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: "SnigletRegular"),
              ),
            ),
          ],
        );
      },
    );
  }

  void _alertVoceAcertou() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Parabéns!",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 25.0,
                  fontFamily: "SnigletRegular")),
          content: new Text("Você acertou, vamos para a próxima palavra.",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 20.0,
                  fontFamily: "SnigletRegular")),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton.icon(
              color: Color(0xff54c4b7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                audioBotao.play('som_botao.mp3');
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.solidWindowClose,
                color: Colors.white,
              ),
              label: Text(
                'Fechar',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: "SnigletRegular"),
              ),
            ),
          ],
        );
      },
    );
  }

  void _alertVoceErrou() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Não foi dessa vez!",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 25.0,
                  fontFamily: "SnigletRegular")),
          content: new Text("Você errou, vamos tentar mais uma vez.",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 20.0,
                  fontFamily: "SnigletRegular")),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton.icon(
              color: Color(0xff54c4b7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                audioBotao.play('som_botao.mp3');
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.solidWindowClose,
                color: Colors.white,
              ),
              label: Text(
                'Fechar',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: "SnigletRegular"),
              ),
            ),
          ],
        );
      },
    );
  }

  void _apagarPalavra() {
    setState(() {
      bloc.inApagarPalavra.add(true);
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection(nivel).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Carregando(),
            );
          } else {
            palavraBuscada = snapshot.data.documents[contador]["nome"];
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  BackgroundImage(),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 8.0),
                    child: Row(
                      children: <Widget>[
                        FlatButton.icon(
                          color: Color(0xff54c4b7),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioBotao.play('som_botao.mp3');
                            Navigator.pop(context, CardDigitarPalavra());
                          },
                          icon: Icon(
                            FontAwesomeIcons.chevronCircleLeft,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Voltar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 150.0),
                          child: MaterialButton(
                            minWidth: 80.0,
                            height: 80.0,
                            color: Color(0xff54c4b7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                              audioExplicandoModulo.play(
                                  "audios_explicacao/audioModuloDigitarPalavra.mp3");
                            },
                            child: Icon(
                              FontAwesomeIcons.question,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 140.0),
                          child: FlatButton.icon(
                            color: Color(0xff54c4b7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                              contador++;
                              if (contador <= 9) {
                                _atualizarPalavra(contador, nivel);
                                _apagarPalavra();
                                print(bloc.getPalavra);
                              } else if (contador > 9) {
                                Navigator.pop(context, CardDigitarPalavra());
                                audioResposta.play(
                                    'audios_explicacao/voceTerminouEsteNivelEscolhaoProximoNivelParaJogar.mp3');
                                _alertVoceTerminouEsteNivel();
                              }
                            },
                            icon: Icon(
                              FontAwesomeIcons.chevronCircleRight,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Pular',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 80.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              color: Color(0xff54c4b7),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image.network(
                                    (snapshot.data.documents[contador]["url"]),
                                    fit: BoxFit.cover,
                                    height: 110.0,
                                    width: 110.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 455.0, top: 165.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        height: 40.0,
                        width: 175.0,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Container(
                            child: FlatButton.icon(
                              color: Color(0xff54c4b7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () {
                                audioBotao.play('som_botao.mp3');
                                bloc.inApagarLetra.add(true);
                              },
                              label: Text(
                                "APAGAR",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                    fontFamily: "SnigletRegular"),
                              ),
                              icon: Icon(FontAwesomeIcons.eraser,
                                  color: Colors.white, size: 23.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 110.0, left: 155.0, right: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        height: 80.0,
                        width: 295.0,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 15.0),
                          child: Scaffold(
                            body: StreamBuilder(
                              stream: bloc.outPalavra,
                              initialData: "Digite a palavra",
                              builder: (context, snapshot) {
                                return Text(
                                  "${snapshot.data}",
                                  style: TextStyle(
                                      color: Color(0xff54c4b7),
                                      fontSize: 40.0,
                                      fontFamily: "SnigletRegular"),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 455.0, top: 110.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        height: 40.0,
                        width: 175.0,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Container(
                            child: FlatButton.icon(
                              color: Colors.lightGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () {
                                audioBotao.play('som_botao.mp3');
                                if (bloc.getPalavra == palavraBuscada) {
                                  contador++;
                                  if (contador <= 9) {
                                    _alertVoceAcertou();
                                    audioResposta.play(
                                        "audios_explicacao/voceAcertouVamosParaaProximaPalavra.mp3");
                                    _atualizarPalavra(contador, nivel);
                                    _apagarPalavra();
                                  } else if (contador > 9) {
                                    Navigator.pop(
                                        context, CardDigitarPalavra());
                                    audioResposta.play(
                                        'audios_explicacao/voceTerminouEsteNivelEscolhaoProximoNivelParaJogar.mp3');
                                    _alertVoceTerminouEsteNivel();
                                  }
                                } else if (bloc.getPalavra != palavraBuscada) {
                                  _alertVoceErrou();
                                  audioResposta.play(
                                      "audios_explicacao/voceErrouAPalavraTenteNovamente.mp3");
                                }
                              },
                              label: Text(
                                "CONFIRMA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                    fontFamily: "SnigletRegular"),
                              ),
                              icon: Icon(
                                FontAwesomeIcons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 210.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 45.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/ã.mp3");
                                      bloc.inDigitarLetra.add("ã");
                                    },
                                    child: Text(
                                      'Ã',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/õ.mp3");
                                      bloc.inDigitarLetra.add("õ");
                                    },
                                    child: Text(
                                      'Õ',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/á.mp3");
                                      bloc.inDigitarLetra.add("á");
                                    },
                                    child: Text(
                                      'Á',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/é.mp3");
                                      bloc.inDigitarLetra.add("é");
                                    },
                                    child: Text(
                                      'É',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/í.mp3");
                                      bloc.inDigitarLetra.add("í");
                                    },
                                    child: Text(
                                      'Í',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/ó.mp3");
                                      bloc.inDigitarLetra.add("ó");
                                    },
                                    child: Text(
                                      'Ó',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/ú.mp3");
                                      bloc.inDigitarLetra.add("ú");
                                    },
                                    child: Text(
                                      'Ú',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/â.mp3");
                                      bloc.inDigitarLetra.add("â");
                                    },
                                    child: Text(
                                      'Â',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/ê.mp3");
                                      bloc.inDigitarLetra.add("ê");
                                    },
                                    child: Text(
                                      'Ê',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/ô.mp3");
                                      bloc.inDigitarLetra.add("ô");
                                    },
                                    child: Text(
                                      'Ô',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra.play("vogais_acento/à.mp3");
                                      bloc.inDigitarLetra.add("à");
                                    },
                                    child: Text(
                                      'À',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 20.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/a.mp3");
                                      bloc.inDigitarLetra.add("a");
                                    },
                                    child: Text(
                                      'A',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/b.mp3");
                                      bloc.inDigitarLetra.add("b");
                                    },
                                    child: Text(
                                      'B',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/c.mp3");
                                      bloc.inDigitarLetra.add("c");
                                    },
                                    child: Text(
                                      'C',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/d.mp3");
                                      bloc.inDigitarLetra.add("d");
                                    },
                                    child: Text(
                                      'D',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/e.mp3");
                                      bloc.inDigitarLetra.add("e");
                                    },
                                    child: Text(
                                      'E',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/f.mp3");
                                      bloc.inDigitarLetra.add("f");
                                    },
                                    child: Text(
                                      'F',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/g.mp3");
                                      bloc.inDigitarLetra.add("g");
                                    },
                                    child: Text(
                                      'G',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/h.mp3");
                                      bloc.inDigitarLetra.add("h");
                                    },
                                    child: Text(
                                      'H',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/i.mp3");
                                      bloc.inDigitarLetra.add("i");
                                    },
                                    child: Text(
                                      'I',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/j.mp3");
                                      bloc.inDigitarLetra.add("j");
                                    },
                                    child: Text(
                                      'J',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/k.mp3");
                                      bloc.inDigitarLetra.add("k");
                                    },
                                    child: Text(
                                      'K',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/l.mp3");
                                      bloc.inDigitarLetra.add("l");
                                    },
                                    child: Text(
                                      'L',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/m.mp3");
                                      bloc.inDigitarLetra.add("m");
                                    },
                                    child: Text(
                                      'M',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 20.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/n.mp3");
                                      bloc.inDigitarLetra.add("n");
                                    },
                                    child: Text(
                                      'N',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/o.mp3");
                                      bloc.inDigitarLetra.add("o");
                                    },
                                    child: Text(
                                      'O',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/p.mp3");
                                      bloc.inDigitarLetra.add("p");
                                    },
                                    child: Text(
                                      'P',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/q.mp3");
                                      bloc.inDigitarLetra.add("q");
                                    },
                                    child: Text(
                                      'Q',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/r.mp3");
                                      bloc.inDigitarLetra.add("r");
                                    },
                                    child: Text(
                                      'R',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/s.mp3");
                                      bloc.inDigitarLetra.add("s");
                                    },
                                    child: Text(
                                      'S',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/t.mp3");
                                      bloc.inDigitarLetra.add("t");
                                    },
                                    child: Text(
                                      'T',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/u.mp3");
                                      bloc.inDigitarLetra.add("u");
                                    },
                                    child: Text(
                                      'U',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/v.mp3");
                                      bloc.inDigitarLetra.add("v");
                                    },
                                    child: Text(
                                      'V',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/w.mp3");
                                      bloc.inDigitarLetra.add("w");
                                    },
                                    child: Text(
                                      'W',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 1.0),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/x.mp3");
                                      bloc.inDigitarLetra.add("x");
                                    },
                                    child: Text(
                                      'X',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");
                                      audioLetra
                                          .play("alfabeto_portugues/y.mp3");
                                      bloc.inDigitarLetra.add("y");
                                    },
                                    child: Text(
                                      'Y',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: MaterialButton(
                                    minWidth: 10.0,
                                    height: 25.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play("som_botao.mp3");

                                      audioLetra
                                          .play("alfabeto_portugues/z.mp3");
                                      bloc.inDigitarLetra.add("z");
                                    },
                                    child: Text(
                                      'Z',
                                      style: TextStyle(
                                          color: Color(0xff20b2aa),
                                          fontSize: 25.0,
                                          fontFamily: "SnigletRegular"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
