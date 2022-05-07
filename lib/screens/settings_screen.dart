import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';

import '../color_palette.dart';
import '../database_helpers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  late bool wish_notif;
  late bool meet_notif;


  @override
  void initState() {
    super.initState();
    _read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorPalette.colorLMain[800]!, ColorPalette.colorDSecondary[100]!],
            stops: const [0.6, 1.0]
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTitle(text: 'Get notification for :'),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextPrimary(text: 'Birthdays, Anniversary\nand Travels'),
                      SwitcherButton(
                        value: wish_notif,
                        offColor: Colors.grey[200]!,
                        onColor: Colors.brown[700]!,
                        onChange: (value){
                          setState(() {
                            wish_notif = value;
                            _save(value, meet_notif);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextPrimary(text: 'Church Meetings'),
                      SwitcherButton(
                        value: meet_notif,
                        offColor: Colors.grey[200]!,
                        onColor: Colors.brown[700]!,
                        onChange: (value){
                          setState(() {
                            meet_notif = value;
                            _save(wish_notif, value);
                          });
                          },
                      ),
                      // IconButton(
                      //   onPressed: (){},
                      //   icon: Icon(Icons.add),
                      // )
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text('Read'),
                          onPressed: () {
                            _read_new();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text('Save'),
                          onPressed: () {
                            _save_new();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text('Delete DB'),
                          onPressed: () {
                            DatabaseHelper helper = DatabaseHelper.instance;
                            helper.DeleteDB();
                          },
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
    );
  }
  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final wish_notif_key = 'wish_notif_key';
    final meet_notif_key = 'meet_notif_key';
    setState(() {
      wish_notif = prefs.getBool(wish_notif_key) ?? true;
      meet_notif = prefs.getBool(meet_notif_key) ?? true;
    });
    print('read: $wish_notif');
    print('read: $meet_notif');
  }

  _save(bool wish, bool meet) async {
    final prefs = await SharedPreferences.getInstance();
    final _wish_notif_key = 'wish_notif_key';
    final _wish_notif = wish;
    prefs.setBool(_wish_notif_key, _wish_notif);
    print('saved $_wish_notif');
    final _meet_notif_key = 'meet_notif_key';
    final _meet_notif = meet;
    prefs.setBool(_meet_notif_key, _meet_notif);
    print('saved $_meet_notif');
  }

  _read_new() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    DateTime dt = DateTime(2022, 3, 1);
    Birthday? bday = await helper.queryBirthday(dt);
    if (bday == null) {
      print('No birthdays on $dt');
    } else {
      print('${bday.date}: ${bday.name}');
    }
  }
  _save_new() async {
    Birthday bday = Birthday();
    bday.name = 'hello';
    bday.date = DateTime(2022, 3, 1);
    DatabaseHelper helper = DatabaseHelper.instance;
    int? id = await helper.insert(bday);
    print('inserted row: $id');
  }
}
