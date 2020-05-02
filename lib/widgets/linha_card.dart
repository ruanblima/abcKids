import 'package:flutter/material.dart';
import 'package:abc_kids/pages/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audio_cache.dart';

class LinhaCard extends StatefulWidget {
  @override
  _LinhaCardState createState() => _LinhaCardState();
}

class _LinhaCardState extends State<LinhaCard> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15.0, top: 20.0),
          child: FlatButton.icon(
            color: Color(0xff54c4b7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {
              audioBotao.play('som_botao.mp3');
              Navigator.pop(context, HomePage());
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
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, left: 280.0),
          child: MaterialButton(
            minWidth: 50.0,
            height: 50.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200.0)),
            onPressed: () {
              audioBotao.play('som_botao.mp3');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Image.asset(
              "images/logoRedonda.png",
              height: 80.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 545.0, top: 8.0),
          child: MaterialButton(
            minWidth: 80.0,
            height: 80.0,
            color: Color(0xff54c4b7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
            onPressed: () {
              audioBotao.play('som_botao.mp3');
            },
            child: Icon(
              FontAwesomeIcons.volumeUp,
              color: Colors.white,
              size: 40.0,
            ),
          ),
        ),
      ],
    );
  }
}
