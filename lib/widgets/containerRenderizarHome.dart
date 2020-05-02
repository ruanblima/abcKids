import 'package:flutter/material.dart';
import 'package:abc_kids/pages/homePage.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class ContainerRenderizarHome extends StatefulWidget {
  @override
  _ContainerRenderizarHomeState createState() =>
      _ContainerRenderizarHomeState();
}

class _ContainerRenderizarHomeState extends State<ContainerRenderizarHome> {
  final PermissionGroup _permissionGroup = PermissionGroup.microphone;
  PermissionStatus _permissionStatus = PermissionStatus.unknown;

  @override
  void initState() {
    checkServiceStatus(context, _permissionGroup);
    requestPermission(_permissionGroup);
    loadData();
  }

  onDoneLoading() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff54c4b7),
      alignment: FractionalOffset.center,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(),
                child: Image.asset(
                  "images/logoRedonda.png",
                  height: 250.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkServiceStatus(BuildContext context, PermissionGroup permission) {
    PermissionHandler()
        .checkServiceStatus(permission)
        .then((ServiceStatus serviceStatus) {
      final SnackBar snackBar =
          SnackBar(content: Text(serviceStatus.toString()));

      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> requestPermission(PermissionGroup permission) async {
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
        await PermissionHandler().requestPermissions(permissions);

    setState(() {
      print(permissionRequestResult);
      _permissionStatus = permissionRequestResult[permission];
      print(_permissionStatus);
    });
  }
}
