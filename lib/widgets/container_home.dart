import 'package:flutter/material.dart';
import 'package:abc_kids/pages/card_digitar_palavra.dart';
import 'package:abc_kids/pages/card_falar_palavra.dart';
import 'package:abc_kids/pages/card_ler_palavra.dart';
import 'package:abc_kids/pages/card_aprender_pronuncia.dart';
import 'package:audioplayers/audio_cache.dart';

class ContainerEspecial extends StatefulWidget {
  @override
  _ContainerEspecialState createState() => _ContainerEspecialState();
}

class _ContainerEspecialState extends State<ContainerEspecial> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");

  Widget _CardStory({String img}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      height: 200.0,
      width: 200.0,
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
      height: 330,
      width: size.width,
      padding: EdgeInsets.only(right: 18.0, top: 80.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                audioBotao.play('som_botao.mp3');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CardAprenderPronuncia()));
              },
              child: Container(
                child: _CardStory(img: "images/aprenderAlfabeto.png"),
              ),
            ),
            GestureDetector(
              onTap: () {
                audioBotao.play('som_botao.mp3');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CardDigitarPalavra()));
              },
              child: Container(
                child: _CardStory(img: "images/digitarPalavra.png"),
              ),
            ),
            GestureDetector(
              onTap: () {
                audioBotao.play('som_botao.mp3');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CardFalarPalavra()));
              },
              child: Container(
                child: _CardStory(img: "images/falarPalavra.png"),
              ),
            ),
            GestureDetector(
              onTap: () {
                audioBotao.play('som_botao.mp3');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardLerPalavra()));
              },
              child: Container(
                child: _CardStory(img: "images/lerPalavra.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
