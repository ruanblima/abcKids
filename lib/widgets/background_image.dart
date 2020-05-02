import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000.0,
      width: double.infinity,
      child: Image.asset(
        "images/planoDeFundoOficialSemLogo.jpeg",
        fit: BoxFit.cover,
      ),
    );
  }
}
