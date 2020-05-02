import 'package:flutter/material.dart';

class SemConexao extends StatefulWidget {
  @override
  _SemConexaoState createState() => _SemConexaoState();
}

class _SemConexaoState extends State<SemConexao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff54c4b7),
        alignment: FractionalOffset.center,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(),
                  child: Image.asset("images/logoRedonda.png", height: 250.0,),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Você está sem conexão com a internet",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontFamily: "SnigletRegular"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
