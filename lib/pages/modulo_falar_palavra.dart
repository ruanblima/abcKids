import 'dart:async';

import 'package:abc_kids/widgets/carregando.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:abc_kids/widgets/background_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abc_kids/pages/card_falar_palavra.dart';
import 'package:abc_kids/pages/home_page.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:speech_recognition/speech_recognition.dart';

const languages = const [
  const Language('Francais', 'fr_FR'),
  const Language('English', 'en_US'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class ModuloFalarPalavra extends StatefulWidget {
  final int contador;
  final String nivel;

  ModuloFalarPalavra({Key key, @required this.contador, this.nivel})
      : super(key: key);
  @override
  _ModuloFalarPalavraState createState() =>
      _ModuloFalarPalavraState(contador, nivel);
}

class _ModuloFalarPalavraState extends State<ModuloFalarPalavra> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");
  static AudioCache audioExplicandoModulo = new AudioCache(prefix: "audios/");
  static AudioCache audioResposta = new AudioCache(prefix: "audios/");

  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  // SpeechRecognition _speechRecognition;
  // bool _isAvailable = false;
  // bool _isListening = false;

  String resultText = "";
  String palavraBuscada = "";

  int contador;
  String nivel;
  _ModuloFalarPalavraState(this.contador, this.nivel);

  void _atualizarPalavra(int contadorResposta, String nivelResposta) {
    setState(() {
      contador = contadorResposta;
      nivel = nivelResposta;
    });
  }

  void _apagarPalavra() {
    setState(() {
      resultText = "";
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

  @override
  void initState() {
    super.initState();
    activateSpeechRecognizer();
    //initSpeechRecognizer();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  // void initSpeechRecognizer() {
  //   _speechRecognition = SpeechRecognition();

  //   _speechRecognition.setAvailabilityHandler(
  //     (bool result) => setState(() => _isAvailable = result),
  //   );

  //   _speechRecognition.setRecognitionStartedHandler(
  //     () => setState(() => _isListening = true),
  //   );

  //   _speechRecognition.setRecognitionResultHandler(
  //     (String speech) => setState(() => resultText = speech),
  //   );

  //   _speechRecognition.setRecognitionCompleteHandler(
  //     () => setState(() => _isListening = false),
  //   );

  //   _speechRecognition.activate().then(
  //         (result) => setState(() => _isAvailable = result),
  //       );
  // }

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
                            Navigator.pop(context, CardFalarPalavra());
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
                          padding: EdgeInsets.only(left: 130.0),
                          child: MaterialButton(
                            minWidth: 50.0,
                            height: 50.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: Image.asset(
                              "images/logoRedonda.png",
                              height: 80.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 125.0),
                          child: FlatButton.icon(
                            color: Color(0xff54c4b7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                              contador++;
                              if (contador <= 9) {
                                _atualizarPalavra(contador, nivel);
                              } else if (contador > 9) {
                                Navigator.pop(context, CardFalarPalavra());
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
                    padding: EdgeInsets.only(left: 40.0, top: 280.0),
                    child: Row(
                      children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.only(),
                        //   child: MaterialButton(
                        //     minWidth: 30.0,
                        //     height: 60.0,
                        //     color: Colors.white,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(100.0)),
                        //     onPressed: () {
                        //       audioBotao.play('som_botao.mp3');
                        //     },
                        //     child: Icon(
                        //       FontAwesomeIcons.volumeUp,
                        //       color: Color(0xff54c4b7),
                        //       size: 30.0,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 40.0),
                          child: MaterialButton(
                            minWidth: 30,
                            height: 60.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                              audioExplicandoModulo.play(
                                  "audios_explicacao/audioModuloFalarPalavra.mp3");
                            },
                            child: Icon(FontAwesomeIcons.question,
                                color: Color(0xff54c4b7), size: 30.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 90.0),
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
                                    height: 160.0,
                                    width: 160.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 150.0, left: 210.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Container(
                              height: 80.0,
                              width: 320.0,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(left: 70.0, top: 10.0),
                                child: Scaffold(
                                  body: Text(
                                    resultText,
                                    style: TextStyle(
                                        color: Color(0xff54c4b7),
                                        fontSize: 50.0,
                                        fontFamily: "SnigletRegular"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: MaterialButton(
                            minWidth: 30,
                            height: 80.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            onPressed:
                                _speechRecognitionAvailable && !_isListening
                                    ? () => start()
                                    : null,
                            child: Icon(FontAwesomeIcons.microphone,
                                color: Color(0xff54c4b7), size: 50.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 240.0, left: 220.0),
                    child: Row(
                      children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.only(),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     child: Container(
                        //       height: 40.0,
                        //       width: 175.0,
                        //       color: Colors.white,
                        //       child: Padding(
                        //         padding: EdgeInsets.all(3.0),
                        //         child: Container(
                        //           child: FlatButton.icon(
                        //             color: Color(0xff54c4b7),
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(15.0)),
                        //             onPressed: () {
                        //               audioBotao.play('som_botao.mp3');
                        //               _apagarPalavra();
                        //             },
                        //             label: Text(
                        //               "APAGAR",
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 23.0,
                        //                   fontFamily: "SnigletRegular"),
                        //             ),
                        //             icon: Icon(FontAwesomeIcons.eraser,
                        //                 color: Colors.white, size: 23.0),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 60.0),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      audioBotao.play('som_botao.mp3');
                                      if (resultText == palavraBuscada) {
                                        contador++;
                                        if (contador <= 9) {
                                          _alertVoceAcertou();
                                          audioResposta.play(
                                              "audios_explicacao/voceAcertouVamosParaaProximaPalavra.mp3");
                                          _atualizarPalavra(contador, nivel);
                                          _apagarPalavra();
                                        } else if (contador > 9) {
                                          Navigator.pop(
                                              context, CardFalarPalavra());
                                          audioResposta.play(
                                              'audios_explicacao/voceTerminouEsteNivelEscolhaoProximoNivelParaJogar.mp3');
                                          _alertVoceTerminouEsteNivel();
                                        }
                                      } else if (resultText != palavraBuscada) {
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
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  void start() => _speech
      .listen(locale: selectedLang.code)
      .then((result) => print('_MyAppState.start => result $result'));

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() => _speech.stop().then((result) {
        setState(() => _isListening = result);
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) => setState(() => resultText = text);

  void onRecognitionComplete() => setState(() => _isListening = false);

  void errorHandler() => activateSpeechRecognizer();
}
