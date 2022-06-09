import 'package:dnlfqa_app/globals.dart';
import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../color_palette.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.colorLMain,
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: const Alignment(-0.5, -1),
                  end: const Alignment(0.5, 1.0),
                  colors: darkTheme
                      ? [
                          const Color(0xFF2D211C),
                          const Color(0XFF4D331D),
                          const Color(0XFF8D6852)
                        ]
                      : [
                          const Color(0xFFF4DCC0),
                          const Color(0XFFDDC2AE),
                          const Color(0XFFC59E87)
                        ],
                  stops: const [0.0, 0.5, 1.0])),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                titleTextStyle:
                    const TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                title: const Text('Forms'),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body:
                  // ListView(
                  //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  //   children: [
                  //     FormsCard('title', 'url', context),
                  //     FormsCard('title', 'url', context),
                  //     FormsCard('title', 'url', context),
                  //   ],
                  // ),
                  Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    TextSecondary(
                        text: "Go to the website to get forms : ",
                        color: ColorPalette.colorLMain),
                    ElevatedButton(
                        onPressed: () {},
                        child: TextPrimary(
                          text: "Go to Website",
                          color: ColorPalette.colorLMain,
                        ))
                  ],
                ),
              ))),
    );
  }
}

Widget FormsCard(String title, String url, BuildContext context) {
  return Card(
    //color: Colors.transparent,
    //color: ColorPalette.colorLMain,
    child: Container(
      // blur: 60,
      // borderRadius: BorderRadius.zero,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextSecondary(
                text: title,
                color: !darkTheme
                    ? ColorPalette.colorLMain
                    : ColorPalette.colorDMain,
              )
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              final Uri _url = Uri.parse(url);
              await launchUrl(_url, mode: LaunchMode.externalApplication);
            },
            child: TextPrimary(
              text: 'Go to Form',
              color:
                  darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDMain,
            ),
            style: ElevatedButton.styleFrom(
                primary: !darkTheme
                    ? ColorPalette.colorLMain
                    : ColorPalette.colorDMain),
          )
        ],
      ),
    ),
  );
}
