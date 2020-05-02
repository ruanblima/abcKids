import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audio_cache.dart';

class LinhaHome extends StatefulWidget {
  @override
  _LinhaHomeState createState() => _LinhaHomeState();
}

class _LinhaHomeState extends State<LinhaHome> {
  static AudioCache audioBotao = new AudioCache(prefix: "audios/");
  static AudioCache audioExplicandoTelaInicial =
  new AudioCache(prefix: "audios/");

  void _alertExplicandoAbcKids() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("O que é o jogo Abc Kids",
              style: TextStyle(
                  color: Color(0xff54c4b7),
                  fontSize: 25.0,
                  fontFamily: "SnigletRegular")),
          content: new Text
          ("O jogo Abc Kids, é um jogo que foi desenvolvivido e que têm o objetivo de" + 
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
            // usually buttons at the bottom of the dialog
            new FlatButton.icon(
              color: Color(0xff54c4b7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                audioBotao.play('som_botao.mp3');
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
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, top: 8.0),
        child: Row(
          children: <Widget>[
//            MaterialButton(
//              minWidth: 80.0,
//              height: 80.0,
//              color: Color(0xff54c4b7),
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(100.0)),
//              onPressed: () {
//                audioBotao.play('som_botao.mp3');
//              },
//              child: Icon(
//                FontAwesomeIcons.userAlt,
//                color: Colors.white,
//                size: 40.0,
//              ),
//            ),
            Padding(
              padding: EdgeInsets.only(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: MaterialButton(
                    minWidth: 80.0,
                    height: 80.0,
                    color:  Color(0xff54c4b7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200.0)),
                    onPressed: () {
                      audioBotao.play('som_botao.mp3');
                      audioExplicandoTelaInicial
                          .play("audios_explicacao/audioParaTelaInicial.mp3");
                    },
                    child: Icon(
                      FontAwesomeIcons.question,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 180.0),
              child: MaterialButton(
                minWidth: 10.0,
                height: 80.0,
                color: Color(0xff54c4b7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                onPressed: () {
                  audioBotao.play('som_botao.mp3');
                  _alertExplicandoAbcKids();
                },
                child: Image.asset(
                  "images/logoRedonda.png",
                  height: 70.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 165.0),
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
        ),
      ),
    );
  }
}
