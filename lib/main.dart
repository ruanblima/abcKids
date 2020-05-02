import 'dart:async';
import 'package:abc_kids/widgets/musica_fundo.dart';
import 'package:abc_kids/widgets/semConexao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:abc_kids/widgets/containerRenderizarHome.dart';

void main() {

  runApp(MaterialApp(
    title: "ABCKIDS",
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConnectivityResult _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>_connectionSubion;
  StreamController _streamctl = StreamController<ConnectivityResult>();

  @override
  void initState() {
    super.initState();
    //MusicaFundo.loop();

    _connectionSubion = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _streamctl.sink.add(result);
          setState(() {
            _connectionStatus = result;
          });
        });

    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose(){
    _streamctl.close();
    _connectionSubion.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: _streamctl.stream,
      builder: (context, snapshot){
        if(snapshot.data == ConnectivityResult.wifi || snapshot.data == ConnectivityResult.mobile){
          return ContainerRenderizarHome();
        }else{
          return SemConexao();
        }
      },
    );
  }
  _SplashScreenState();
}
