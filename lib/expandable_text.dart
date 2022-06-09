import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  Color textColor;

  DescriptionTextWidget(
      {Key? key, required this.text, this.textColor = Colors.black})
      : super(key: key);

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                TextPrimary(
                  text: flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  // color: const Color(0xFFAB9787)
                  color: widget.textColor,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                    child: Text(
                      flag ? "show more" : "show less",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
