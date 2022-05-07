import 'package:dnlfqa_app/color_palette.dart';
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

  TextTitle({required this.text, this.align = TextAlign.center, this.color = Colors.black54});

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

class  MyElevatedButtonStyle {
  final Gradient? gradient;
  final double height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;

  MyElevatedButtonStyle({
    this.gradient,
    this.borderRadius,
    this.width,
    this.height = 44.0,
  });

}

class MyElevatedButton extends StatelessWidget {
  final MyElevatedButtonStyle style;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.style.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: style.width,
      height: style.height,
      decoration: BoxDecoration(
        gradient: style.gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
