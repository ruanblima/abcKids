import 'dart:async';

import 'package:abc_kids/pages/cardSpeakWord.dart';
import 'package:abc_kids/widgets/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:abc_kids/widgets/backgroundImage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abc_kids/pages/homePage.dart';
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

class ModuleSpeakWord extends StatefulWidget {
  final int counter;
  final String level;

  ModuleSpeakWord({Key key, @required this.counter, this.level})
      : super(key: key);
  @override
  _ModuleSpeakWordState createState() => _ModuleSpeakWordState(counter, level);
}

class _ModuleSpeakWordState extends State<ModuleSpeakWord> {
  static AudioCache audioButton = new AudioCache(prefix: "audios/");
  static AudioCache audioExplainingModule = new AudioCache(prefix: "audios/");
  static AudioCache audioAnswer = new AudioCache(prefix: "audios/");

  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  Language selectedLang = languages.first;
  String resultText = "";
  String speakSought = "";

  int counter;
  String level;
  _ModuleSpeakWordState(this.counter, this.level);

  void _updateSpeak(int counterAnswer, String nivelAnswer) {
    setState(() {
      counter = counterAnswer;
      level = nivelAnswer;
    });
  }

  void _deleteSpeak() {
    setState(() {
      resultText = "";
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

  double _maxValue(double s, double max) {
    if (s < max) {
      return s;
    } else {
      return max;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;

    return StreamBuilder(
        stream: Firestore.instance.collection(level).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Loading(),
            );
          } else {
            speakSought = snapshot.data.documents[counter]["nome"];
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
                            top: size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              color: Color(0xff54c4b7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () {
                                audioButton.play('som_botao.mp3');
                                Navigator.pop(context, CardSpeakWord());
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
                            GestureDetector(
                              onTap: () {
                                audioButton.play('som_botao.mp3');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              },
                              child: Image.asset(
                                "images/logoRedonda.png",
                                width: _maxValue(size.width * 0.135, 89),
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
                                  _updateSpeak(counter, level);
                                } else if (counter > 9) {
                                  Navigator.pop(context, CardSpeakWord());
                                  audioAnswer.play(
                                      'audios_explicacao/voceTerminouEsteNivelEscolhaoProximoNivelParaJogar.mp3');
                                  _alertYouFinishedThisLevel();
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
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.015,
                            right: size.width * 0.035),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
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
                                                        size.height * 0.447,
                                                        165),
                                                    width: _maxValue(
                                                        size.width * 0.25,
                                                        165)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Row
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.02),
                                  child: Row(
                                    children: <Widget>[
                                      MaterialButton(
                                        height:
                                            _maxValue(size.height * 0.167, 65),
                                        minWidth:
                                            _maxValue(size.width * 0.0633, 45),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100.0)),
                                        onPressed: () {
                                          audioButton.play('som_botao.mp3');
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.volumeUp,
                                          size:
                                              _maxValue(size.width * 0.047, 35),
                                          color: Color(0xff54c4b7),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.015),
                                        child: MaterialButton(
                                          height: _maxValue(
                                              size.height * 0.167, 65),
                                          minWidth: _maxValue(
                                              size.width * 0.0633, 45),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          onPressed: () {
                                            audioButton.play('som_botao.mp3');
                                            audioExplainingModule.play(
                                                "audios_explicacao/audioModuloFalarPalavra.mp3");
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.question,
                                            size: _maxValue(
                                                size.width * 0.047, 35),
                                            color: Color(0xff54c4b7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //Column
                            Padding(
                              padding:
                                  EdgeInsets.only(left: size.width * 0.015),
                              child: Column(
                                children: <Widget>[
                                  //Row
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Container(
                                            height: _maxValue(
                                                size.height * 0.223, 85),
                                            width: _maxValue(
                                                size.width * 0.5, 325),
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.only(),
                                              child: Scaffold(
                                                body: Text(
                                                  resultText,
                                                  style: TextStyle(
                                                      color: Color(0xff54c4b7),
                                                      fontSize: _maxValue(
                                                          size.width * 0.079,
                                                          55),
                                                      fontFamily:
                                                          "SnigletRegular"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: MaterialButton(
                                          minWidth: 10,
                                          height: _maxValue(
                                              size.height * 0.224, 85),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          onPressed:
                                              _speechRecognitionAvailable &&
                                                      !_isListening
                                                  ? () => start()
                                                  : null,
                                          child: Icon(
                                              FontAwesomeIcons.microphone,
                                              color: Color(0xff54c4b7),
                                              size: _maxValue(
                                                  size.width * 0.079, 55)),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //Row
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.035,
                                        right: size.width * 0.14),
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
                                                  color: Colors.lightGreen,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  onPressed: () {
                                                    audioButton
                                                        .play('som_botao.mp3');
                                                    if (resultText ==
                                                        speakSought) {
                                                      counter++;
                                                      if (counter <= 9) {
                                                        _alertYouHit();
                                                        audioAnswer.play(
                                                            "audios_explicacao/voceAcertouVamosParaaProximaPalavra.mp3");
                                                        _updateSpeak(
                                                            counter, level);
                                                        _deleteSpeak();
                                                      } else if (counter > 9) {
                                                        Navigator.pop(context,
                                                            CardSpeakWord());
                                                        audioAnswer.play(
                                                            'audios_explicacao/voceTerminouEsteNivelEscolhaoProximoNivelParaJogar.mp3');
                                                        _alertYouFinishedThisLevel();
                                                      }
                                                    } else if (resultText !=
                                                        speakSought) {
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
