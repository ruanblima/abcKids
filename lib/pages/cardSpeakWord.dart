import 'package:flutter/material.dart';
import 'package:abc_kids/widgets/background_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abc_kids/pages/modulo_falar_palavra.dart';
import 'package:abc_kids/widgets/rowCard.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class CardSpeakWord extends StatefulWidget {
  @override
  _CardSpeakWordState createState() => _CardSpeakWordState();
}

class _CardSpeakWordState extends State<CardSpeakWord> {
  static AudioCache audioButton = new AudioCache(prefix: "audios/");
  static AudioCache audioExplainingCard = new AudioCache(prefix: "audios/");
  static AudioCache audioToChooseLevel = new AudioCache(prefix: "audios/");
  String level = "";

  double _maxValue(double s, double max) {
    if (s < max) {
      return s;
    } else {
      return max;
    }
  }

  var shape1 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape2 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape3 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape4 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape5 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));

  void _addEdge() {
    setState(() {
      if (level == "palavrasSimples") {
        shape1 = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(300.0),
            side: BorderSide(color: Colors.white));
        shape2 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape3 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape4 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape5 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      } else if (level == "palavrasSimples2") {
        shape2 = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(200.0),
            side: BorderSide(color: Colors.white));
        shape1 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape3 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape4 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape5 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      } else if (level == "palavrasOxitonas") {
        shape3 = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(200.0),
            side: BorderSide(color: Colors.white));
        shape1 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape2 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape4 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape5 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      } else if (level == "palavrasParoxitonas") {
        shape4 = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(200.0),
            side: BorderSide(color: Colors.white));
        shape1 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape2 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape3 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape5 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      } else if (level == "palavrasProparoxitonas") {
        shape5 = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(200.0),
            side: BorderSide(color: Colors.white));
        shape1 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape2 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape3 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
        shape4 =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    audioExplainingCard.play("audios_explicacao/audioCardFalarPalavra.mp3");
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
              //Row
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
                                child: Image.asset("images/falarPalavra.png",
                                    fit: BoxFit.cover,
                                    height: _maxValue(size.height * 0.5, 185),
                                    width: _maxValue(size.width * 0.282, 185)),
                              ),
                            ),
                          ],
                        ),
                        //Row
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Row(
                            children: <Widget>[
                              MaterialButton(
                                height: _maxValue(size.height * 0.167, 65),
                                minWidth: _maxValue(size.width * 0.0633, 45),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                onPressed: () {
                                  audioButton.play("som_botao.mp3");
                                  audioToChooseLevel.play(
                                      "audios_explicacao/audioEscolherNivel.mp3");
                                },
                                child: Icon(
                                  FontAwesomeIcons.question,
                                  size: _maxValue(size.width * 0.047, 35),
                                  color: Color(0xff54c4b7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //Column
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.015, right: size.width * 0.035),
                      child: Column(
                        children: <Widget>[
                          //Row
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.012),
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                    height: _maxValue(size.height * 0.566, 208),
                                    width: _maxValue(size.width * 0.564, 365),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Container(
                                          height: _maxValue(
                                              size.height * 0.28, 105),
                                          width: _maxValue(
                                              size.width * 0.532, 345),
                                          color: Color(0xff54c4b7),
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: size.height * 0.03,
                                                    left: size.width * 0.01),
                                                child: Row(
                                                  children: <Widget>[
                                                    MaterialButton(
                                                      shape: shape1,
                                                      onPressed: () {
                                                        audioButton.play(
                                                            'som_botao.mp3');
                                                        level =
                                                            "palavrasSimples";
                                                        _addEdge();
                                                      },
                                                      child: Image.asset(
                                                        "images/1.png",
                                                        height: _maxValue(
                                                            size.height * 0.223,
                                                            85),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      shape: shape2,
                                                      onPressed: () {
                                                        audioButton.play(
                                                            'som_botao.mp3');
                                                        level =
                                                            "palavrasSimples2";
                                                        _addEdge();
                                                      },
                                                      child: Image.asset(
                                                        "images/2.png",
                                                        height: _maxValue(
                                                            size.height * 0.223,
                                                            85),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      shape: shape3,
                                                      onPressed: () {
                                                        audioButton.play(
                                                            'som_botao.mp3');
                                                        level =
                                                            "palavrasOxitonas";
                                                        _addEdge();
                                                      },
                                                      child: Image.asset(
                                                        "images/3.png",
                                                        height: _maxValue(
                                                            size.height * 0.223,
                                                            85),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: size.height * 0.03,
                                                    left: size.width * 0.01),
                                                child: Row(
                                                  children: <Widget>[
                                                    MaterialButton(
                                                      shape: shape4,
                                                      onPressed: () {
                                                        audioButton.play(
                                                            'som_botao.mp3');
                                                        level =
                                                            "palavrasParoxitonas";
                                                        _addEdge();
                                                      },
                                                      child: Image.asset(
                                                        "images/4.png",
                                                        height: _maxValue(
                                                            size.height * 0.223,
                                                            85),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      shape: shape5,
                                                      onPressed: () {
                                                        audioButton.play(
                                                            'som_botao.mp3');
                                                        level =
                                                            "palavrasProparoxitonas";
                                                        _addEdge();
                                                      },
                                                      child: Image.asset(
                                                        "images/5.png",
                                                        height: _maxValue(
                                                            size.height * 0.223,
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
                          ),

                          //Row
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.017),
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
                                            audioButton.play("som_botao.mp3");
                                            if (level == "") {
                                              audioToChooseLevel.play(
                                                  'audios_explicacao/escolhaNivel.mp3');
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ModuloFalarPalavra(
                                                              contador: 0,
                                                              level: level)));
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
