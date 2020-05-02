import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class ContainerLevel123 extends StatefulWidget {
  @override
  _ContainerLevel123State createState() => _ContainerLevel123State();
}

class _ContainerLevel123State extends State<ContainerLevel123> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");
  String nivel = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                            },
                            child: Image.asset(
                              "images/1.png",
                              height: 80.0,
                            ),
                          ),
                          MaterialButton(
                            minWidth: 50.0,
                            height: 50.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                            },
                            child: Image.asset(
                              "images/2.png",
                              height: 80.0,
                            ),
                          ),
                          MaterialButton(
                            minWidth: 50.0,
                            height: 50.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200.0)),
                            onPressed: () {
                              audioBotao.play('som_botao.mp3');
                            },
                            child: Image.asset(
                              "images/3.png",
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
    );
  }
}
