import 'dart:math';

import 'package:dnlfqa_app/color_palette.dart';
import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

bool isLoading = false;

class Anniversary {
  String hName;
  String wName;
  String date;

  Anniversary({required this.hName, required this.wName, required this.date});
}

class Birthday {
  String name;
  String date;

  Birthday({required this.name, required this.date});
}

class Travel {
  String name;
  String date;

  Travel({required this.name, required this.date});
}

var travellingFromQatar = [
  Travel(name: 'Member 1 Name', date: '15-09'),
  Travel(name: 'Member 2 Name', date: '15-09'),
  Travel(name: 'Member 3 Name', date: '15-09'),
];
var travellingToQatar = [
  Travel(name: 'Member 1 Name', date: '15-09'),
  Travel(name: 'Member 2 Name', date: '15-09'),
];
var birthdays = [
  Birthday(name: 'Member 1 Name', date: '15-09'),
  Birthday(name: 'Member 2 Name', date: '15-09'),
  Birthday(name: 'Member 3 Name', date: '15-09'),
];
var anniversaries = [
  Anniversary(hName: 'Member 1 Name', wName: 'Member 2 Name', date: '5-10'),
  Anniversary(hName: 'Member 3 Name', wName: 'Member 4 Name', date: '15-11'),
  Anniversary(hName: 'Member 5 Name', wName: 'Member 6 Name', date: '15-11'),
  Anniversary(hName: 'Member 7 Name', wName: 'Member 8 Name', date: '15-11'),
];
var infos = [
  'Announcement 1',
  'Announcement 2',
  'Announcement 3',
  'Announcement 4',
  'Announcement 5'
];

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementScreen createState() => _AnnouncementScreen();
}

class _AnnouncementScreen extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
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
                const TextStyle(fontSize: 28, fontFamily: 'Montserrat'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            bottom: const TabBar(
              unselectedLabelColor: Colors.white38,
              tabs: [
                Tab(icon: Icon(Icons.notification_important_rounded)),
                Tab(icon: Icon(Icons.cake_rounded)),
                Tab(icon: Icon(Icons.favorite_outlined)),
                Tab(icon: Icon(Icons.flight_takeoff)),
              ],
            ),
            title: const Text('Wish'),
          ),
          body: TabBarView(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(children: [
                          //TextSubTitleRegular(text: '', color: ColorPalette.colorLMain),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: infos.length,
                              itemBuilder: (context, index) {
                                return AnnounceCard(infos[index]);
                              }),
                        ])),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 5),
                            child: TextSubTitleRegular(
                                text: 'Birthday',
                                color: ColorPalette.colorLMain),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: birthdays.length,
                              itemBuilder: (context, index) {
                                return SingleTextCard(birthdays[index].name,
                                    birthdays[index].date);
                              }),
                        ])),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 5),
                            child: TextSubTitleRegular(
                                text: 'Wedding\n      Anniversary',
                                color: ColorPalette.colorLMain),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: anniversaries.length,
                              itemBuilder: (context, index) {
                                return DoubleTextCard(
                                    anniversaries[index].hName,
                                    anniversaries[index].wName,
                                    anniversaries[index].date);
                              }),
                        ])),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TravelFromQatarDivider(),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: travellingFromQatar.length,
                                itemBuilder: (context, index) {
                                  return SingleTextCard(
                                      travellingFromQatar[index].name,
                                      travellingFromQatar[index].date);
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            travellingToQatar.isNotEmpty
                                ? TravelToQatarDivider()
                                : const SizedBox.shrink(),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: travellingToQatar.length,
                                itemBuilder: (context, index) {
                                  return SingleTextCard(
                                      travellingToQatar[index].name,
                                      travellingToQatar[index].date);
                                }),
                          ],
                        ),
                      ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget TravelFromQatarDivider() {
  return Center(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
    child: Row(
      children: [
        TextSubTitleRegular(text: 'From Qatar', color: ColorPalette.colorLMain),
        const Icon(
          Icons.flight_takeoff,
          color: ColorPalette.colorLMain,
        ),
      ],
    ),
  ));
}

Widget TravelToQatarDivider() {
  return Center(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
    child: Row(
      children: [
        TextSubTitleRegular(text: 'To Qatar', color: ColorPalette.colorLMain),
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: const Icon(
              Icons.flight_land,
              color: ColorPalette.colorLMain,
            )),
      ],
    ),
  ));
}

Widget AnnounceCard(String text) {
  return Card(
    margin: const EdgeInsets.all(5),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: TextPrimary(
        text: text,
        color: !darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDMain,
      ),
    ),
  );
}

Widget SingleTextCard(String text, String dateStr) {
  var date = dateStr.split('-');
  dateStr = "${date[0]} ${getMonth(int.parse(date[1]))}";
  return Card(
    margin: const EdgeInsets.all(5),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextPrimary(
              text: text,
              color: !darkTheme
                  ? ColorPalette.colorLMain
                  : ColorPalette.colorDMain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: TextSmall1(
              text: dateStr,
              color: !darkTheme
                  ? ColorPalette.colorLMain
                  : ColorPalette.colorDMain,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget DoubleTextCard(String text1, String text2, String dateStr) {
  var date = dateStr.split('-');
  dateStr = "${date[0]} ${getMonth(int.parse(date[1]))}";

  return Card(
    margin: const EdgeInsets.all(5),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextPrimary(
                text: text1,
                color: !darkTheme
                    ? ColorPalette.colorLMain
                    : ColorPalette.colorDMain,
              ),
              TextPrimary(
                text: text2,
                color: !darkTheme
                    ? ColorPalette.colorLMain
                    : ColorPalette.colorDMain,
              ),
            ],
          ),
          TextSmall1(
            text: dateStr,
            color:
                !darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDMain,
          ),
        ],
      ),
    ),
  );
}
