import 'package:dnlfqa_app/color_palette.dart';
import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globals.dart';

Color textColor =
    darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDSecondary;
TextEditingController myController = TextEditingController();

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  _PlaylistScreen createState() => _PlaylistScreen();
}

class _PlaylistScreen extends State<PlaylistScreen> {
  @override
  void initState() {
    super.initState();
  }

  late String verId;
  late String phone;
  bool codeSent = false;
  bool isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              title: const Text('Sermons'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: ListView(
              children: [
                PlaylistCard(
                    context,
                    '3 Days Fasting - May 2022',
                    'assets/3DaysFastingMay2022.jpg',
                    'https://www.youtube.com/watch?v=PIMRVN9mkfQ&list=PLDSDtjIIHO-PQrlAlNhr3dq_-AuKct8wt'),
                PlaylistCard(
                    context,
                    '21 Days Fasting - April 2022',
                    'assets/21DaysFastingApril2022.jpg',
                    'https://www.youtube.com/watch?v=DbN1AHkf4fU&list=PLDSDtjIIHO-NiKZHNaf4RyupJqiFUoD6W'),
                PlaylistCard(
                    context,
                    'Salvation And Christian Life',
                    'assets/SalvationAndChristianLife.jpg',
                    'https://www.youtube.com/watch?v=XovjAk1Xf_w&list=PLDSDtjIIHO-MW3AmkXS4pu9S-2MlBtZgI'),
              ],
            )));
  }
}

Widget PlaylistCard(
    BuildContext context, String title, String imagePath, String url) {
  return GestureDetector(
    onTap: () async {
      final Uri _url = Uri.parse(url);
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    },
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width,
            //height: 240,
            fit: BoxFit.contain,
          ),
          //colorFilter: ColorFilters.greyscale,

          Container(
            color: Color(0xA0000000),
            padding: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextSecondary(
              color: ColorPalette.colorLMain,
              text: title,
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
