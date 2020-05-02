import 'package:abc_kids/pages/cardLearnPronunciation.dart';
import 'package:abc_kids/pages/homePage.dart';
import 'package:abc_kids/widgets/musica_fundo.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abc_kids/widgets/background_image.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class ModuloAprenderPronuncia extends StatefulWidget {
  final String modeScreen;

  ModuloAprenderPronuncia({Key key, @required this.modeScreen})
      : super(key: key);
  @override
  _ModuloAprenderPronunciaState createState() =>
      _ModuloAprenderPronunciaState(modeScreen);
}

class _ModuloAprenderPronunciaState extends State<ModuloAprenderPronuncia> {
  static AudioCache audioButton = new AudioCache(prefix: "audios/");
  static AudioCache audioLetra = new AudioCache(prefix: "audios/");

  double _maxValue(double s, double max) {
    if (s < max) {
      return s;
    } else {
      return max;
    }
  }

  String modeScreen;
  _ModuloAprenderPronunciaState(this.modeScreen);

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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8.0),
              child: Row(
                children: <Widget>[
                  FlatButton.icon(
                    color: Color(0xff54c4b7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    onPressed: () {
                      audioButton.play('som_botao.mp3');
                      Navigator.pop(context, CardLearnPronunciation());
                    },
                    label: AutoSizeText(
                      "Voltar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: _maxValue(size.width * 0.04, 28),
                          fontFamily: "SnigletRegular"),
                      maxLines: 1,
                    ),
                    textColor: Colors.white,
                    icon: Icon(
                      FontAwesomeIcons.angleLeft,
                      color: Colors.white,
                      size: _maxValue(size.width * 0.05, 35),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: MaterialButton(
                      minWidth: 55.0,
                      height: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        audioButton.play('som_botao.mp3');
                        modeScreen = "portugues";
                      },
                      child: Image.asset(
                        "images/brazil.png",
                        height: 70.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: MaterialButton(
                      minWidth: 55.0,
                      height: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        audioButton.play('som_botao.mp3');
                        modeScreen = "ingles";
                      },
                      child: Image.asset(
                        "images/eua.png",
                        height: 70.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: MaterialButton(
                      minWidth: 55.0,
                      height: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        audioButton.play('som_botao.mp3');
                        modeScreen = "espanhol";
                      },
                      child: Image.asset(
                        "images/spain.png",
                        height: 70.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: MaterialButton(
                        minWidth: 50.0,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        onPressed: () {
                          audioButton.play('som_botao.mp3');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Image.asset(
                          "images/logoRedonda.png",
                          height: 80.0,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 60.0, right: 30.0, top: 130.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            MusicaFundo.diminuirVolume();
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/a.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/a.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/a.mp3");
                            }
                            // musicaFundo.loopMusicaFundo();
                          },
                          child: Text(
                            'A',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/b.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/b.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/b.mp3");
                            }
                          },
                          child: Text(
                            'B',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/c.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/c.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/c.mp3");
                            }
                          },
                          child: Text(
                            'C',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/d.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/d.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/d.mp3");
                            }
                          },
                          child: Text(
                            'D',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/e.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/e.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/e.mp3");
                            }
                          },
                          child: Text(
                            'E',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/f.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/f.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/f.mp3");
                            }
                          },
                          child: Text(
                            'F',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/g.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/g.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/g.mp3");
                            }
                          },
                          child: Text(
                            'G',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0, right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/h.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/h.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/h.mp3");
                              }
                            },
                            child: Text(
                              'H',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/i.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/i.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/i.mp3");
                              }
                            },
                            child: Text(
                              'I',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/j.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/j.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/j.mp3");
                              }
                            },
                            child: Text(
                              'J',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/k.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/k.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/k.mp3");
                              }
                            },
                            child: Text(
                              'K',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/l.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/l.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/l.mp3");
                              }
                            },
                            child: Text(
                              'L',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 50.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/m.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/m.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/m.mp3");
                              }
                            },
                            child: Text(
                              'M',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0, right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/n.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/n.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/n.mp3");
                              }
                            },
                            child: Text(
                              'N',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/o.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/o.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/o.mp3");
                              }
                            },
                            child: Text(
                              'O',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/p.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/p.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/p.mp3");
                              }
                            },
                            child: Text(
                              'P',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/q.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/q.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/q.mp3");
                              }
                            },
                            child: Text(
                              'Q',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/r.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/r.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/r.mp3");
                              }
                            },
                            child: Text(
                              'R',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 5.0),
                          child: MaterialButton(
                            minWidth: 55.0,
                            height: 50.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              audioButton.play("som_botao.mp3");
                              if (modeScreen == "portugues") {
                                audioLetra.play("alfabeto_portugues/s.mp3");
                              } else if (modeScreen == "ingles") {
                                audioLetra.play("alfabeto_ingles/s.mp3");
                              } else if (modeScreen == "espanhol") {
                                audioLetra.play("alfabeto_espanhol/s.mp3");
                              }
                            },
                            child: Text(
                              'S',
                              style: TextStyle(
                                  color: Color(0xff20b2aa),
                                  fontSize: 35.0,
                                  fontFamily: "SnigletRegular"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/t.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/t.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/t.mp3");
                            }
                          },
                          child: Text(
                            'T',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/u.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/u.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/u.mp3");
                            }
                          },
                          child: Text(
                            'U',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/v.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/v.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/v.mp3");
                            }
                          },
                          child: Text(
                            'V',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/w.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/w.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/w.mp3");
                            }
                          },
                          child: Text(
                            'W',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/x.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/x.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/x.mp3");
                            }
                          },
                          child: Text(
                            'X',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/y.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/y.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/y.mp3");
                            }
                          },
                          child: Text(
                            'Y',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: () {
                            audioButton.play("som_botao.mp3");
                            if (modeScreen == "portugues") {
                              audioLetra.play("alfabeto_portugues/z.mp3");
                            } else if (modeScreen == "ingles") {
                              audioLetra.play("alfabeto_ingles/z.mp3");
                            } else if (modeScreen == "espanhol") {
                              audioLetra.play("alfabeto_espanhol/z.mp3");
                            }
                          },
                          child: Text(
                            'Z',
                            style: TextStyle(
                                color: Color(0xff20b2aa),
                                fontSize: 35.0,
                                fontFamily: "SnigletRegular"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
