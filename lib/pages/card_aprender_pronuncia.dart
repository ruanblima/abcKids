import 'package:flutter/material.dart';
import 'package:abc_kids/widgets/background_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'modulo_aprender_pronuncia.dart';
import 'package:abc_kids/widgets/linha_card.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class CardAprenderPronuncia extends StatefulWidget {
  @override
  _CardAprenderPronunciaState createState() => _CardAprenderPronunciaState();
}

class _CardAprenderPronunciaState extends State<CardAprenderPronuncia> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");
  static AudioCache audioExplicandoCard = new AudioCache(prefix: "audios/");
  static AudioCache audioParaEscolherIdioma = new AudioCache(prefix: "audios/");

  String modoTela = "";
  var shape1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape3 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));

  void _adicionarBorda() {
    setState(() {
      if(modoTela == "portugues"){
        shape1 = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(200.0),
          side: BorderSide(color: Colors.white));
          shape2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape3 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }else if(modoTela == "ingles"){
        shape2 = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(200.0),
          side: BorderSide(color: Colors.white));
          shape1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape3 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }else if(modoTela == "espanhol"){
        shape3 = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(200.0),
          side: BorderSide(color: Colors.white));
          shape1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    audioExplicandoCard
        .play("audios_explicacao/audioCardAprenderPronuncia.mp3");
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Padding(
            padding: EdgeInsets.only(top: 130, left: 250.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 120.0,
                width: 360.0,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      height: 100.0,
                      width: 340.0,
                      color: Color(0xff54c4b7),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 10.0),
                            child: Row(
                              children: <Widget>[
                                MaterialButton(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  shape: shape1,
                                  onPressed: () {
                                    audioBotao.play('som_botao.mp3');
                                    modoTela = "portugues";
                                    _adicionarBorda();
                                  },
                                  child: Image.asset(
                                    "images/brazil.png",
                                    height: 80.0,
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  shape: shape2,
                                  onPressed: () {
                                    audioBotao.play('som_botao.mp3');
                                    modoTela = "ingles";
                                    _adicionarBorda();
                                  },
                                  child: Image.asset(
                                    "images/eua.png",
                                    height: 80.0,
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  shape: shape3,
                                  onPressed: () {
                                    audioBotao.play('som_botao.mp3');
                                    modoTela = "espanhol";
                                    _adicionarBorda();
                                  },
                                  child: Image.asset(
                                    "images/spain.png",
                                    height: 80.0,
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
          ),
          LinhaCard(),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 100.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                child: Image.asset("images/aprenderAlfabeto.png",
                    fit: BoxFit.cover, height: 180.0, width: 180.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 75.0, top: 285.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: MaterialButton(
                  minWidth: 40.0,
                  height: 60.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  onPressed: () {
                    audioBotao.play('som_botao.mp3');
                    audioParaEscolherIdioma
                        .play("audios_explicacao/audioEscolherIdioma.mp3");
                  },
                  child: Icon(
                    FontAwesomeIcons.question,
                    size: 30.0,
                    color: Color(0xff54c4b7),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 355.0, top: 260.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                height: 40.0,
                width: 150.0,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Container(
                    child: FlatButton.icon(
                      color: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      onPressed: () {
                        if (modoTela == "") {
                          audioBotao.play('som_botao.mp3');
                          audioParaEscolherIdioma
                              .play("audios_explicacao/escolhaIdioma.mp3");
                        } else {
                          audioBotao.play('som_botao.mp3');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ModuloAprenderPronuncia(
                                        modoTela: modoTela,
                                      )));
                        }
                      },
                      label: Text(
                        "Jogar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "SnigletRegular"),
                      ),
                      textColor: Colors.white,
                      icon: Icon(FontAwesomeIcons.gamepad),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
