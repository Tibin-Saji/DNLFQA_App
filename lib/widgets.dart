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
        fontFamily: 'Montserrat',
      )
    );
  }
}

class TextSecondary extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color color;

  TextSecondary({required this.text, this.align = TextAlign.left, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 18,
          color: color,
          letterSpacing: 1.25,
          fontFamily: 'Montserrat',
        )
    );
  }
}

class TextSmall1 extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color color;

  TextSmall1({required this.text, this.align = TextAlign.left, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 12,
          color: color,
          letterSpacing: 1.25,
          fontFamily: 'Montserrat',
        )
    );
  }
}

class TextTitleRegular extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color? color;

  TextTitleRegular({required this.text, this.align = TextAlign.center, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 50,
          letterSpacing: 1.5,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w300,
          color: color,
        )
    );
  }
}

class TextTitleThin extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color? color;

  TextTitleThin({required this.text, this.align = TextAlign.center, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 50,
          letterSpacing: 1.5,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          color: color,
        )
    );
  }
}

class TextSubTitleRegular extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color? color;

  TextSubTitleRegular({required this.text, this.align = TextAlign.left, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 35,
          letterSpacing: 0.7,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          color: color,
        )
    );
  }
}

class TextSubTitleThin extends StatelessWidget {
  //const TextPrimary({Key? key}) : super(key: key);
  String text;
  TextAlign align;
  Color? color;

  TextSubTitleThin({required this.text, this.align = TextAlign.left, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 35,
          letterSpacing: 0.7,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          color: color,
        )
    );
  }
}

class TextThick1 extends StatelessWidget {
  String text;
  TextAlign align;
  Color? color;
  TextThick1({required this.text, this.align = TextAlign.center, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(
            fontSize: 24,
            letterSpacing: 1.5,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            color: color
        )
    );
  }
}

class TextThick2 extends StatelessWidget {
  String text;
  TextAlign align;
  Color? color;
  TextThick2({required this.text, this.align = TextAlign.center, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(
            fontSize: 24,
            letterSpacing: 1.5,
            fontFamily: 'Montserrat',
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
