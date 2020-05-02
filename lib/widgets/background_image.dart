import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    return Container(
      height: size.height,
      width: size.width,
      child: Image.asset(
        "images/planoDeFundoOficialSemLogo.jpeg",
        fit: BoxFit.cover,
      ),
    );
  }
}
