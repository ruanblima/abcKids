import 'package:abc_kids/pages/cardEnterWord.dart';
import 'package:abc_kids/pages/cardLearnPronunciation.dart';
import 'package:abc_kids/pages/cardReadWord.dart';
import 'package:abc_kids/pages/cardSpeakWord.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class BodyHome extends StatefulWidget {
  @override
  _BodyHomeState createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  static AudioCache audioButton = new AudioCache(prefix: "audios/");

  double _maxValue(double s, double max) {
    if (s < max) {
      return s;
    } else {
      return max;
    }
  }

  Widget _CardStory({String img, Size size}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      height: _maxValue(size.height * 0.556, 205),
      width: _maxValue(size.width * 0.313, 205),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.asset(img, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;

    return Container(
      height: _maxValue(size.height * 0.7, 256),
      width: size.width,
      padding: EdgeInsets.only(right: 18.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                audioButton.play('som_botao.mp3');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CardLearnPronunciation()));
              },
              child: Container(
                child:
                    _CardStory(img: "images/aprenderAlfabeto.png", size: size),
              ),
            ),
            GestureDetector(
              onTap: () {
                audioButton.play('som_botao.mp3');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardEnterWord()));
              },
              child: Container(
                child: _CardStory(img: "images/digitarPalavra.png", size: size),
              ),
            ),
            GestureDetector(
              onTap: () {
                audioButton.play('som_botao.mp3');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardSpeakWord()));
              },
              child: Container(
                child: _CardStory(img: "images/falarPalavra.png", size: size),
              ),
            ),
            GestureDetector(
              onTap: () {
                audioButton.play('som_botao.mp3');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardReadWord()));
              },
              child: Container(
                child: _CardStory(img: "images/lerPalavra.png", size: size),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
