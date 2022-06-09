import 'package:dnlfqa_app/database_helpers.dart';
import 'package:dnlfqa_app/screens/meetings_details_screen.dart';
import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../color_palette.dart';
import '../globals.dart';
import '../meeting_class.dart';

var weeklyMeetingsData;
var specialMeetingsData;
var isLoading;

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _State();
}

class _State extends State<MeetingScreen> {
  @override
  void initState() {
    getMeetingsFromDB();
    super.initState();
  }

  @override
  void dispose() {
    // MeetingsDatabase.instance.close();
    super.dispose();
  }

  Future<void> getMeetingsFromDB() async {
    setState(() => isLoading = true);

    weeklyMeetingsData = await MeetingsDatabase.instance.readMeetings(true);
    specialMeetingsData = await MeetingsDatabase.instance.readMeetings(false);

    print("${weeklyMeetingsData.length} meetings Screen");

    // if (weeklyMeetingsData.isEmpty) {
    //   await getMeetings();
    //
    //   weeklyMeetingsData = await MeetingsDatabase.instance.readMeetings(true);
    //   specialMeetingsData = await MeetingsDatabase.instance.readMeetings(false);
    // }

    setState(() => isLoading = false);
  }

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
            title: const Text('Meetings'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextSubTitleRegular(
                            text: 'Weekly',
                            color: darkTheme
                                ? ColorPalette.colorLMain
                                : ColorPalette.colorDMain,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: weeklyMeetingsData.length,
                              itemBuilder: (context, index) {
                                return MeetingCard(
                                    weeklyMeetingsData[index], context);
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          specialMeetingsData.length > 0
                              ? TextSubTitleRegular(
                                  text: 'Special',
                                  color: darkTheme
                                      ? ColorPalette.colorLMain
                                      : ColorPalette.colorDMain,
                                )
                              : const SizedBox(
                                  width: 0,
                                ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: specialMeetingsData.length,
                              itemBuilder: (context, index) {
                                return MeetingCard(
                                    specialMeetingsData[index], context);
                              }),
                        ],
                      ),
                    ]),
        ));
  }
}

Widget MeetingCard(Meeting meetData, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new MeetingDetailsScreen(
                  meetStr: Meeting.meetingtoString(meetData),
                ))),
    child: Card(
      //color: Colors.transparent,
      //color: ColorPalette.colorLMain,
      child: Container(
        // blur: 60,
        // borderRadius: BorderRadius.zero,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextSecondary(
                  text: meetData.name,
                  color: !darkTheme
                      ? ColorPalette.colorLMain
                      : ColorPalette.colorDMain,
                ),
                TextSmall1(
                  text:
                      '${getWeekday(int.parse(meetData.weekday ?? '0'))} ${meetData.time}',
                  color: !darkTheme
                      ? ColorPalette.colorLMain
                      : ColorPalette.colorDMain,
                )
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse(
                    "https://www.google.com/search?q=remote+config+flutter&source=lmns&tbm=vid&bih=714&biw=1488&hl=en&sa=X&ved=2ahUKEwi95KPptff3AhVFjtgFHTutCh8Q_AUoAnoECAEQAg");
                await launchUrl(url, mode: LaunchMode.externalApplication);
              },
              child: TextPrimary(
                text: 'Join',
                color: darkTheme
                    ? ColorPalette.colorLMain
                    : ColorPalette.colorDMain,
              ),
              style: ElevatedButton.styleFrom(
                  primary: !darkTheme
                      ? ColorPalette.colorLMain
                      : ColorPalette.colorDMain),
            )
          ],
        ),
      ),
    ),
  );
}
