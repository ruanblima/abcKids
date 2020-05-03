import 'package:abc_kids/widgets/musicBackground.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:abc_kids/pages/homePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audio_cache.dart';

class RowCard extends StatefulWidget {
  @override
  _RowCardState createState() => _RowCardState();
}

class _RowCardState extends State<RowCard> {
  static AudioCache audioButton = new AudioCache(prefix: "audios/");
  var iconAudio;

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

    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.015,
          right: size.width * 0.035,
          top: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton.icon(
            color: Color(0xff54c4b7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {
              audioButton.play('som_botao.mp3');
              Navigator.pop(context, HomePage());
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
          GestureDetector(
            onTap: () {
              audioButton.play('som_botao.mp3');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
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
    );
  }
}
