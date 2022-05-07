import 'package:flutter/material.dart';

class TextPrimary extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color color;

  TextPrimary({required this.text, this.align = TextAlign.left, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 16,
        color: color,
        letterSpacing: 1.25,
        fontFamily: 'SFUI',
      )
    );
  }
}

class TextTitle extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color? color;

  TextTitle({required this.text, this.align = TextAlign.left, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 50,
          letterSpacing: 1.5,
          fontFamily: 'SFUI',
          fontWeight: FontWeight.w700,
          color: color,
        )
    );
  }
}

class TextSubTitle extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color? color;

  TextSubTitle({required this.text, this.align = TextAlign.left, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 35,
          letterSpacing: 0.7,
          fontFamily: 'Brandon Grotesque',
          fontWeight: FontWeight.w500,
          color: color,
        )
    );
  }
}

class TextThick extends StatelessWidget {
  String text;
  TextAlign align;
  Color? color;
  TextThick({required this.text, this.align = TextAlign.center, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(
            fontSize: 24,
            letterSpacing: 1.5,
            fontFamily: 'SFUI',
            fontWeight: FontWeight.w900,
            color: color
        )
    );
  }
}
