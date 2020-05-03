import 'dart:async';

import 'package:abc_kids/widgets/musicBackground.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audio_cache.dart';

class RowHome extends StatefulWidget {
  @override
  _RowHomeState createState() => _RowHomeState();
}

class _RowHomeState extends State<RowHome> {
  static AudioCache audioButton = new AudioCache(prefix: "audios/");
  static AudioCache audioExplainingInitialScreen =
      new AudioCache(prefix: "audios/");

  var iconAudio;

  double _maxValue(double s, double max) {
    if (s < max) {
      return s;
    } else {
      return max;
    }
  }

  void _alertExplainingAbcKids() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("O que é o jogo Abc Kids",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 25.0,
                  fontFamily: "SnigletRegular")),
          content: new Text(
              "O jogo Abc Kids, é um jogo que foi desenvolvivido e que têm o objetivo de" +
                  " auxilixar no processo de alfabetização. O jogo está em sua versão 1.0, e" +
                  " esta versão, busca saber a resposta do público sobre o aplicativo." +
                  " Essa versão também busca identificar possíveis melhorias do jogo com a ajuda" +
                  " dos seus usuários." +
                  " \n" +
                  "Desenvolvedor: Ruan Robson de Brito Lima",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 18.0,
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
    _iconStart();
  }

  _iconStart() {
    setState(() {
      if (MusicBackground.isStop == false) {
        iconAudio = Icon(
          FontAwesomeIcons.volumeUp,
          color: Colors.white,
          size: 47,
        );
      } else {
        iconAudio = Icon(
          FontAwesomeIcons.volumeMute,
          color: Colors.white,
          size: 47,
        );
      }
    });
  }

  _iconAudio(size) {
    setState(() {
      if (MusicBackground.isStop == false) {
        iconAudio = Icon(
          FontAwesomeIcons.volumeUp,
          color: Colors.white,
          size: _maxValue(size.width * 0.08, 52.2),
        );
      } else {
        iconAudio = Icon(
          FontAwesomeIcons.volumeMute,
          color: Colors.white,
          size: _maxValue(size.width * 0.08, 52.2),
        );
      }
    });
  }

  _incrementVolume() {
    MusicBackground.incrementVolume();
  }

  Future<Timer> loadData() async {
    MusicBackground.decrementVolume();
    return new Timer(Duration(seconds: 5), _incrementVolume());
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;

    return Container(
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.035,
            right: size.width * 0.035,
            top: size.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MaterialButton(
              height: _maxValue(size.height * 0.22, 81),
              minWidth: _maxValue(size.width * 0.001, 0.67),
              color: Color(0xff54c4b7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              onPressed: () {
                audioButton.play('som_botao.mp3');

                audioExplainingInitialScreen
                    .play("audios_explicacao/audioParaTelaInicial.mp3");
                loadData();
              },
              child: Icon(
                FontAwesomeIcons.question,
                size: _maxValue(size.width * 0.08, 52.2),
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                audioButton.play('som_botao.mp3');
                _alertExplainingAbcKids();
              },
              child: Image.asset(
                "images/logoRedonda.png",
                width: _maxValue(size.width * 0.135, 89),
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
                if (MusicBackground.isStop == false) {
                  MusicBackground.stop();
                  _iconAudio(size);
                } else if (MusicBackground.isStop == true) {
                  MusicBackground.loop();
                  _iconAudio(size);
                }
              },
              child: iconAudio,
            ),
          ],
        ),
      ),
    );
  }
}
