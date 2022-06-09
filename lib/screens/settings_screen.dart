import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';

import '../color_palette.dart';
import '../globals.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // late bool wish_notif;
  // late bool meet_notif;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-0.5, -1),
              end: Alignment(0.5, 1.0),
              colors: darkTheme
                  ? [Color(0xFF2D211C), Color(0XFF4D331D), Color(0XFF8D6852)]
                  : [Color(0xFFF4DCC0), Color(0XFFDDC2AE), Color(0XFFC59E87)],
              stops: const [0.0, 0.5, 1.0])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleTextStyle: TextStyle(fontSize: 24, fontFamily: 'SFUIText'),
          title: Text('Settings'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextSubTitleRegular(
                    text: 'Get notification for :',
                    color: ColorPalette.colorLMain),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextPrimary(
                              text: 'Birthdays, Anniversary\nand Travels',
                              color: darkTheme
                                  ? Color(0xFFAB9787)
                                  : ColorPalette.colorDSecondary),
                          SwitcherButton(
                            offColor: Colors.grey[200]!,
                            onColor: Colors.brown[700]!,
                            onChange: (value) {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextPrimary(
                              text: 'Church Meetings',
                              color: darkTheme
                                  ? Color(0xFFAB9787)
                                  : ColorPalette.colorDSecondary),
                          SwitcherButton(
                            offColor: Colors.grey[200]!,
                            onColor: Colors.brown[700]!,
                            onChange: (value) {},
                          ),
                        ],
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              child: const Text('Read'),
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              child: const Text('Save'),
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              child: const Text('Delete DB'),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
