import 'package:abc_kids/widgets/backgroundImage.dart';
import 'package:abc_kids/widgets/bodyHome.dart';
import 'package:flutter/material.dart';
import 'package:abc_kids/widgets/rowHome.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audio_cache.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");

  @override
  void initState() {
    super.initState();
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
          Column(
            children: <Widget>[
              RowHome(),
              BodyHome(),
            ],
          ),
        ],
      ),
    );
  }
}
