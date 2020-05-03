import 'package:flutter/material.dart';
import 'package:abc_kids/widgets/backgroundImage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'modulo_aprender_pronuncia.dart';
import 'package:abc_kids/widgets/rowCard.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class CardLearnPronunciation extends StatefulWidget {
  @override
  _CardLearnPronunciationState createState() => _CardLearnPronunciationState();
}

class _CardLearnPronunciationState extends State<CardLearnPronunciation> {
  static AudioCache audioButton = new AudioCache(prefix: "audios/");
  static AudioCache audioExplainingCard = new AudioCache(prefix: "audios/");
  static AudioCache audioToChooseLanguage = new AudioCache(prefix: "audios/");

  double _maxValue(double s, double max) {
    if (s < max) {
      return s;
    } else {
      return max;
    }
  }

  String modeScreen = "";
  var shape1 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape2 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape3 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));

  void _addEdge() {
    setState(() {
      if (modeScreen == "portugues") {
        shape1 = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(200.0),
            side: BorderSide(color: Colors.white));
        shape2 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape3 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      } else if (modeScreen == "ingles") {
        shape2 = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(200.0),
            side: BorderSide(color: Colors.white));
        shape1 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape3 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      } else if (modeScreen == "espanhol") {
        shape3 = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(200.0),
            side: BorderSide(color: Colors.white));
        shape1 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape2 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    audioExplainingCard
        .play("audios_explicacao/audioCardAprenderPronuncia.mp3");
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Column(
            children: <Widget>[
              RowCard(),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.015, right: size.width * 0.035),
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
                                child: Image.asset(
                                    "images/aprenderAlfabeto.png",
                                    fit: BoxFit.cover,
                                    height: _maxValue(size.height * 0.5, 185),
                                    width: _maxValue(size.width * 0.282, 185)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.03),
                              child: MaterialButton(
                                height: _maxValue(size.height * 0.167, 65),
                                minWidth: _maxValue(size.width * 0.0633, 45),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                onPressed: () {
                                  audioButton.play('som_botao.mp3');
                                  audioToChooseLanguage.play(
                                      "audios_explicacao/audioEscolherIdioma.mp3");
                                },
                                child: Icon(
                                  FontAwesomeIcons.question,
                                  size: _maxValue(size.width * 0.047, 35),
                                  color: Color(0xff54c4b7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.015, right: size.width * 0.035),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Container(
                                  height: _maxValue(size.height * 0.5, 125),
                                  width: _maxValue(size.width * 0.563, 365),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Container(
                                        height:
                                            _maxValue(size.height * 0.28, 105),
                                        width:
                                            _maxValue(size.width * 0.532, 345),
                                        color: Color(0xff54c4b7),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15.0, left: 10.0),
                                              child: Row(
                                                children: <Widget>[
                                                  MaterialButton(
                                                    shape: shape1,
                                                    onPressed: () {
                                                      audioButton.play(
                                                          'som_botao.mp3');
                                                      modeScreen = "portugues";
                                                      _addEdge();
                                                    },
                                                    child: Image.asset(
                                                        "images/brazil.png",
                                                        width: _maxValue(
                                                            size.width * 0.126,
                                                            85)),
                                                  ),
                                                  MaterialButton(
                                                    shape: shape2,
                                                    onPressed: () {
                                                      audioButton.play(
                                                          'som_botao.mp3');
                                                      modeScreen = "ingles";
                                                      _addEdge();
                                                    },
                                                    child: Image.asset(
                                                      "images/eua.png",
                                                      width: _maxValue(
                                                          size.width * 0.126,
                                                          85),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    shape: shape3,
                                                    onPressed: () {
                                                      audioButton.play(
                                                          'som_botao.mp3');
                                                      modeScreen = "espanhol";
                                                      _addEdge();
                                                    },
                                                    child: Image.asset(
                                                      "images/spain.png",
                                                      width: _maxValue(
                                                          size.width * 0.126,
                                                          85),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.035),
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    height: _maxValue(size.height * 0.112, 45),
                                    width: _maxValue(size.width * 0.235, 155),
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
                                            if (modeScreen == "") {
                                              audioButton.play('som_botao.mp3');
                                              audioToChooseLanguage.play(
                                                  "audios_explicacao/escolhaIdioma.mp3");
                                            } else {
                                              audioButton.play('som_botao.mp3');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ModuloAprenderPronuncia(
                                                            modeScreen:
                                                                modeScreen,
                                                          )));
                                            }
                                          },
                                          label: Text(
                                            "Jogar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: _maxValue(
                                                    size.width * 0.04, 28),
                                                fontFamily: "SnigletRegular"),
                                          ),
                                          textColor: Colors.white,
                                          icon: Icon(
                                            FontAwesomeIcons.gamepad,
                                            color: Colors.white,
                                            size: _maxValue(
                                                size.width * 0.05, 35),
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
}
