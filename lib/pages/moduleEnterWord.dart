import 'dart:async';

import 'package:abc_kids/blocs/digitar_palavra_bloc.dart';
import 'package:abc_kids/pages/cardEnterWord.dart';
import 'package:abc_kids/widgets/loading.dart';
import 'package:abc_kids/widgets/musicBackground.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abc_kids/widgets/backgroundImage.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class ModuleEnterWord extends StatefulWidget {
  final int counter;
  final String level;

  ModuleEnterWord({Key key, @required this.counter, this.level})
      : super(key: key);
  @override
  _ModuleEnterWordState createState() => _ModuleEnterWordState(counter, level);
}

class _ModuleEnterWordState extends State<ModuleEnterWord> {
  DigitarPalavraBloc bloc = DigitarPalavraBloc();

  static AudioCache audioButton = new AudioCache(prefix: "audios/");
  static AudioCache audioExplainingModule = new AudioCache(prefix: "audios/");
  static AudioCache audioLetra = new AudioCache(prefix: "audios/");
  static AudioCache audioAnswer = new AudioCache(prefix: "audios/");

  String searchedWord = "";

  int counter;
  String level;
  _ModuleEnterWordState(this.counter, this.level);

  double _maxValue(double s, double max) {
    if (s < max) {
      return s;
    } else {
      return max;
    }
  }

  void _updateWord(int counterResposta, String nivelResposta) {
    setState(() {
      counter = counterResposta;
      level = nivelResposta;
    });
  }

  void _alertYouFinishedThisLevel() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
            new FlatButton.icon(
              color: Color(0xff54c4b7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                audioButton.play('som_botao.mp3');
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

  void _alertYouHit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
            new FlatButton.icon(
              color: Color(0xff54c4b7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                audioButton.play('som_botao.mp3');
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

  void _alertYouMissed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
            new FlatButton.icon(
              color: Color(0xff54c4b7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                audioButton.play('som_botao.mp3');
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

  void _deleteWord() {
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;

    print("aqui: ${size.width * 0.032}");
    return StreamBuilder(
        stream: Firestore.instance.collection(level).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Loading(),
            );
          } else {
            searchedWord = snapshot.data.documents[counter]["nome"];
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  BackgroundImage(),
                  Column(
                    children: <Widget>[
                      //Row Header
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.015,
                            right: size.width * 0.035,
                            top: size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              color: Color(0xff54c4b7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () {
                                audioButton.play('som_botao.mp3');
                                MusicBackground.incrementVolume();
                                Navigator.pop(context, CardEnterWord());
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.angleLeft,
                                    color: Colors.white,
                                    size: _maxValue(size.width * 0.05, 35),
                                  ),
                                  AutoSizeText(
                                    "Voltar",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            _maxValue(size.width * 0.04, 28),
                                        fontFamily: "SnigletRegular"),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            MaterialButton(
                              height: _maxValue(size.height * 0.22, 81),
                              minWidth: _maxValue(size.width * 0.001, 0.67),
                              color: Color(0xff54c4b7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)),
                              onPressed: () {
                                audioButton.play('som_botao.mp3');
                                audioExplainingModule.play(
                                    "audios_explicacao/audioModuloDigitarPalavra.mp3");
                              },
                              child: Icon(
                                FontAwesomeIcons.question,
                                size: _maxValue(size.width * 0.08, 52.2),
                                color: Colors.white,
                              ),
                            ),
                            FlatButton(
                              color: Color(0xff54c4b7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () {
                                audioButton.play('som_botao.mp3');
                                counter++;
                                if (counter <= 9) {
                                  _updateWord(counter, level);
                                  _deleteWord();
                                  print(bloc.getPalavra);
                                } else if (counter > 9) {
                                  Navigator.pop(context, CardEnterWord());
                                  audioAnswer.play(
                                      'audios_explicacao/voceTerminouEsteNivelEscolhaoProximoNivelParaJogar.mp3');
                                  _alertYouFinishedThisLevel();
                                  var timer = Timer(Duration(seconds: 5),
                                      () => MusicBackground.incrementVolume());
                                }
                              },
                              child: Row(
                                children: <Widget>[
                                  AutoSizeText(
                                    "Pular",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            _maxValue(size.width * 0.04, 28),
                                        fontFamily: "SnigletRegular"),
                                    maxLines: 1,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.angleRight,
                                    color: Colors.white,
                                    size: _maxValue(size.width * 0.05, 35),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Row
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: <Widget>[
                            //Column
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Container(
                                            color: Color(0xff54c4b7),
                                            child: Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Image.network(
                                                  (snapshot.data
                                                          .documents[counter]
                                                      ["url"]),
                                                  fit: BoxFit.cover,
                                                  height: _maxValue(
                                                      size.height * 0.308, 115),
                                                  width: _maxValue(
                                                      size.width * 0.173, 115)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Column
                            Padding(
                              padding: EdgeInsets.only(left: 7),
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Container(
                                      height:
                                          _maxValue(size.height * 0.223, 85),
                                      width: _maxValue(size.width * 0.462, 300),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 15.0),
                                        child: Scaffold(
                                          body: StreamBuilder(
                                            stream: bloc.outPalavra,
                                            initialData: "Digite a palavra",
                                            builder: (context, snapshot) {
                                              return Text(
                                                "${snapshot.data}",
                                                style: TextStyle(
                                                    color: Color(0xff54c4b7),
                                                    fontSize: _maxValue(
                                                        size.width * 0.064, 45),
                                                    fontFamily:
                                                        "SnigletRegular"),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Column
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Container(
                                          height: _maxValue(
                                              size.height * 0.112, 45),
                                          width:
                                              _maxValue(size.width * 0.29, 190),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Container(
                                              child: FlatButton.icon(
                                                color: Colors.lightGreen,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                onPressed: () {
                                                  audioButton
                                                      .play('som_botao.mp3');
                                                  if (bloc.getPalavra ==
                                                      searchedWord) {
                                                    counter++;
                                                    if (counter <= 9) {
                                                      _alertYouHit();
                                                      audioAnswer.play(
                                                          "audios_explicacao/voceAcertouVamosParaaProximaPalavra.mp3");
                                                      _updateWord(
                                                          counter, level);
                                                      _deleteWord();
                                                    } else if (counter > 9) {
                                                      Navigator.pop(context,
                                                          CardEnterWord());
                                                      audioAnswer.play(
                                                          'audios_explicacao/voceTerminouEsteNivelEscolhaoProximoNivelParaJogar.mp3');
                                                      _alertYouFinishedThisLevel();
                                                    }
                                                  } else if (bloc.getPalavra !=
                                                      searchedWord) {
                                                    _alertYouMissed();
                                                    audioAnswer.play(
                                                        "audios_explicacao/voceErrouAPalavraTenteNovamente.mp3");
                                                  }
                                                },
                                                label: Text(
                                                  "CONFIRMAR",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: _maxValue(
                                                          size.width * 0.036,
                                                          28),
                                                      fontFamily:
                                                          "SnigletRegular"),
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
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Container(
                                            height: _maxValue(
                                                size.height * 0.112, 45),
                                            width: _maxValue(
                                                size.width * 0.29, 190),
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(3.0),
                                              child: Container(
                                                child: FlatButton.icon(
                                                  color: Color(0xff54c4b7),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  onPressed: () {
                                                    audioButton
                                                        .play('som_botao.mp3');
                                                    bloc.inApagarLetra
                                                        .add(true);
                                                  },
                                                  label: Text(
                                                    "APAGAR",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: _maxValue(
                                                            size.width * 0.036,
                                                            28),
                                                        fontFamily:
                                                            "SnigletRegular"),
                                                  ),
                                                  icon: Icon(
                                                      FontAwesomeIcons.eraser,
                                                      color: Colors.white,
                                                      size: _maxValue(
                                                          size.width * 0.036,
                                                          28)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Row
                      Padding(
                        padding: EdgeInsets.only(),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                //Row
                                Padding(
                                  padding: EdgeInsets.only(left: 45.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/ã.mp3");
                                            bloc.inDigitarLetra.add("ã");
                                          },
                                          child: Text(
                                            'Ã',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/õ.mp3");
                                            bloc.inDigitarLetra.add("õ");
                                          },
                                          child: Text(
                                            'Õ',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/á.mp3");
                                            bloc.inDigitarLetra.add("á");
                                          },
                                          child: Text(
                                            'Á',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/é.mp3");
                                            bloc.inDigitarLetra.add("é");
                                          },
                                          child: Text(
                                            'É',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/í.mp3");
                                            bloc.inDigitarLetra.add("í");
                                          },
                                          child: Text(
                                            'Í',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/ó.mp3");
                                            bloc.inDigitarLetra.add("ó");
                                          },
                                          child: Text(
                                            'Ó',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/ú.mp3");
                                            bloc.inDigitarLetra.add("ú");
                                          },
                                          child: Text(
                                            'Ú',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/â.mp3");
                                            bloc.inDigitarLetra.add("â");
                                          },
                                          child: Text(
                                            'Â',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/ê.mp3");
                                            bloc.inDigitarLetra.add("ê");
                                          },
                                          child: Text(
                                            'Ê',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/ô.mp3");
                                            bloc.inDigitarLetra.add("ô");
                                          },
                                          child: Text(
                                            'Ô',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra
                                                .play("vogais_acento/à.mp3");
                                            bloc.inDigitarLetra.add("à");
                                          },
                                          child: Text(
                                            'À',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
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
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/a.mp3");
                                            bloc.inDigitarLetra.add("a");
                                          },
                                          child: Text(
                                            'A',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/b.mp3");
                                            bloc.inDigitarLetra.add("b");
                                          },
                                          child: Text(
                                            'B',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/c.mp3");
                                            bloc.inDigitarLetra.add("c");
                                          },
                                          child: Text(
                                            'C',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/d.mp3");
                                            bloc.inDigitarLetra.add("d");
                                          },
                                          child: Text(
                                            'D',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/e.mp3");
                                            bloc.inDigitarLetra.add("e");
                                          },
                                          child: Text(
                                            'E',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/f.mp3");
                                            bloc.inDigitarLetra.add("f");
                                          },
                                          child: Text(
                                            'F',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/g.mp3");
                                            bloc.inDigitarLetra.add("g");
                                          },
                                          child: Text(
                                            'G',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/h.mp3");
                                            bloc.inDigitarLetra.add("h");
                                          },
                                          child: Text(
                                            'H',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/i.mp3");
                                            bloc.inDigitarLetra.add("i");
                                          },
                                          child: Text(
                                            'I',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/j.mp3");
                                            bloc.inDigitarLetra.add("j");
                                          },
                                          child: Text(
                                            'J',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/k.mp3");
                                            bloc.inDigitarLetra.add("k");
                                          },
                                          child: Text(
                                            'K',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/l.mp3");
                                            bloc.inDigitarLetra.add("l");
                                          },
                                          child: Text(
                                            'L',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/m.mp3");
                                            bloc.inDigitarLetra.add("m");
                                          },
                                          child: Text(
                                            'M',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
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
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/n.mp3");
                                            bloc.inDigitarLetra.add("n");
                                          },
                                          child: Text(
                                            'N',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/o.mp3");
                                            bloc.inDigitarLetra.add("o");
                                          },
                                          child: Text(
                                            'O',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/p.mp3");
                                            bloc.inDigitarLetra.add("p");
                                          },
                                          child: Text(
                                            'P',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/q.mp3");
                                            bloc.inDigitarLetra.add("q");
                                          },
                                          child: Text(
                                            'Q',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/r.mp3");
                                            bloc.inDigitarLetra.add("r");
                                          },
                                          child: Text(
                                            'R',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/s.mp3");
                                            bloc.inDigitarLetra.add("s");
                                          },
                                          child: Text(
                                            'S',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/t.mp3");
                                            bloc.inDigitarLetra.add("t");
                                          },
                                          child: Text(
                                            'T',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/u.mp3");
                                            bloc.inDigitarLetra.add("u");
                                          },
                                          child: Text(
                                            'U',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/v.mp3");
                                            bloc.inDigitarLetra.add("v");
                                          },
                                          child: Text(
                                            'V',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/w.mp3");
                                            bloc.inDigitarLetra.add("w");
                                          },
                                          child: Text(
                                            'W',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/x.mp3");
                                            bloc.inDigitarLetra.add("x");
                                          },
                                          child: Text(
                                            'X',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");
                                            audioLetra.play(
                                                "alfabeto_portugues/y.mp3");
                                            bloc.inDigitarLetra.add("y");
                                          },
                                          child: Text(
                                            'Y',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: MaterialButton(
                                          minWidth: 10.0,
                                          height: _maxValue(
                                              size.height * 0.0696, 30),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          onPressed: () {
                                            audioButton.play("som_botao.mp3");

                                            audioLetra.play(
                                                "alfabeto_portugues/z.mp3");
                                            bloc.inDigitarLetra.add("z");
                                          },
                                          child: Text(
                                            'Z',
                                            style: TextStyle(
                                                color: Color(0xff20b2aa),
                                                fontSize: _maxValue(
                                                    size.width * 0.0399, 30),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
