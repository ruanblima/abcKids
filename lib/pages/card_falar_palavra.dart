import 'package:flutter/material.dart';
import 'package:abc_kids/widgets/background_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abc_kids/pages/modulo_falar_palavra.dart';
import 'package:abc_kids/widgets/linha_card.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class CardFalarPalavra extends StatefulWidget {
  @override
  _CardFalarPalavraState createState() => _CardFalarPalavraState();
}

class _CardFalarPalavraState extends State<CardFalarPalavra> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");
  static AudioCache audioExplicandoCard = new AudioCache(prefix: "audios/");
  static AudioCache audioParaEscolherNivel = new AudioCache(prefix: "audios/");
  String nivel = "";

  var shape1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape3 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape4 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
  var shape5 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));

  void _adicionarBorda() {
    setState(() {
      if(nivel == "palavrasSimples"){
        shape1 = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(300.0),
          side: BorderSide(color: Colors.white));
          shape2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape3 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape4 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape5 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }else if(nivel == "palavrasSimples2"){
        shape2 = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(200.0),
          side: BorderSide(color: Colors.white));
          shape1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape3 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape4 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape5 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }else if(nivel == "palavrasOxitonas"){
        shape3 = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(200.0),
          side: BorderSide(color: Colors.white));
          shape1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape4 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape5 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }else if(nivel == "palavrasParoxitonas"){
        shape4 = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(200.0),
          side: BorderSide(color: Colors.white));
          shape1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape3 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape5 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }else if(nivel == "palavrasProparoxitonas"){
        shape5 = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(200.0),
          side: BorderSide(color: Colors.white));
          shape1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape3 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
          shape4 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    audioExplicandoCard.play("audios_explicacao/audioCardFalarPalavra.mp3");
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
            padding: EdgeInsets.only(top: 100, left: 250.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 203.0,
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
                                    nivel = "palavrasSimples";
                                    _adicionarBorda();
                                  },
                                  child: Image.asset(
                                    "images/1.png",
                                    height: 80.0,
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  shape: shape2,
                                  onPressed: () {
                                    audioBotao.play('som_botao.mp3');
                                    nivel = "palavrasSimples2";
                                    _adicionarBorda();
                                  },
                                  child: Image.asset(
                                    "images/2.png",
                                    height: 80.0,
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  shape: shape3,
                                  onPressed: () {
                                    audioBotao.play('som_botao.mp3');
                                    nivel = "palavrasOxitonas";
                                    _adicionarBorda();
                                  },
                                  child: Image.asset(
                                    "images/3.png",
                                    height: 80.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 10.0),
                            child: Row(
                              children: <Widget>[
                                MaterialButton(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  shape: shape4,
                                  onPressed: () {
                                    audioBotao.play('som_botao.mp3');
                                    nivel = "palavrasParoxitonas";
                                    _adicionarBorda();
                                  },
                                  child: Image.asset(
                                    "images/4.png",
                                    height: 80.0,
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  shape: shape5,
                                  onPressed: () {
                                    audioBotao.play('som_botao.mp3');
                                    nivel = "palavrasProparoxitonas";
                                    _adicionarBorda();
                                  },
                                  child: Image.asset(
                                    "images/5.png",
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
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, top: 100.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  child: Image.asset("images/falarPalavra.png",
                      fit: BoxFit.cover, height: 180.0, width: 180.0),
                ),
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
                    audioBotao.play("som_botao.mp3");
                    audioParaEscolherNivel
                        .play("audios_explicacao/audioEscolherNivel.mp3");
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
            padding: EdgeInsets.only(left: 355.0, top: 310.0),
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
                        audioBotao.play("som_botao.mp3");
                        if(nivel == ""){
                          audioParaEscolherNivel.play('audios_explicacao/escolhaNivel.mp3');
                        }else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ModuloFalarPalavra(contador: 0, nivel: nivel)));
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
