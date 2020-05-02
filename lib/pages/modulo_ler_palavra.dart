import 'package:abc_kids/pages/cardReadWord.dart';
import 'package:abc_kids/widgets/carregando.dart';
import 'package:flutter/material.dart';
import 'package:abc_kids/widgets/background_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abc_kids/pages/homePage.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class ModuloLerPalavra extends StatefulWidget {
  final int contador;
  final String level;

  ModuloLerPalavra({Key key, @required this.contador, this.level})
      : super(key: key);
  @override
  _ModuloLerPalavraState createState() =>
      _ModuloLerPalavraState(contador, level);
}

class _ModuloLerPalavraState extends State<ModuloLerPalavra> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");
  static AudioCache audioExplicandoModulo = new AudioCache(prefix: "audios/");
  static AudioCache audioResposta = new AudioCache(prefix: "audios/");

  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  Language selectedLang = languages.first;

  String resultText = "";
  String palavraBuscada = "";

  int contador;
  String level;
  _ModuloLerPalavraState(this.contador, this.level);

  void _atualizarPalavra(int contadorResposta, String nivelResposta) {
    setState(() {
      contador = contadorResposta;
      level = nivelResposta;
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection(level).snapshots(),
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
                            Navigator.pop(context, CardReadWord());
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
                                _atualizarPalavra(contador, level);
                                _apagarPalavra();
                              } else if (contador > 9) {
                                Navigator.pop(context, CardReadWord());
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
                    padding:
                        EdgeInsets.only(top: 110.0, left: 90.0, right: 10.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Container(
                              height: 80.0,
                              width: 340.0,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(left: 80.0, top: 10.0),
                                child: Scaffold(
                                  body: Text(
                                    (snapshot.data.documents[contador]["nome"]),
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
                          padding: EdgeInsets.only(top: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Container(
                              height: 80.0,
                              width: 340.0,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(left: 80.0, top: 10.0),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 485.0, top: 110.0),
                    child: MaterialButton(
                      minWidth: 30,
                      height: 80.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      onPressed: _speechRecognitionAvailable && !_isListening
                          ? () => start()
                          : null,
                      child: Icon(FontAwesomeIcons.microphone,
                          color: Color(0xff54c4b7), size: 50.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 80.0, top: 290.0),
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
                        //             onPressed: _isListening ? () => cancel() : null,
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
                          padding: EdgeInsets.only(left: 95.0),
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
                                          _atualizarPalavra(contador, level);
                                          _apagarPalavra();
                                        } else if (contador > 9) {
                                          Navigator.pop(
                                              context, CardReadWord());
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
                  Padding(
                    padding: EdgeInsets.only(top: 210.0, left: 460.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(),
                          child: MaterialButton(
                            minWidth: 30.0,
                            height: 60.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                            },
                            child: Icon(
                              FontAwesomeIcons.volumeUp,
                              color: Color(0xff54c4b7),
                              size: 30.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: MaterialButton(
                            minWidth: 30,
                            height: 60.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                              audioExplicandoModulo.play(
                                  "audios_explicacao/audioModuloLerPalavra.mp3");
                            },
                            child: Icon(FontAwesomeIcons.question,
                                color: Color(0xff54c4b7), size: 30.0),
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
