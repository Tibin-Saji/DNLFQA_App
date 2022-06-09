import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../color_palette.dart';
import '../globals.dart';
import '../meeting_class.dart';


final Color color = darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDMain;

class MeetingDetailsScreen extends StatelessWidget {
  const MeetingDetailsScreen({Key? key, this.meetStr}) : super(key: key);
  final meetStr;


  @override
  Widget build(BuildContext context) {
    var meet = Meeting.stringToMeeting(meetStr);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: const Alignment(-0.5, -1),
              end: const Alignment(0.5, 1.0),
              colors: darkTheme ? [const Color(0xFF2D211C), const Color(0XFF4D331D), const Color(0XFF8D6852)]  :  [const Color(0xFFF4DCC0), const Color(0XFFDDC2AE), const Color(0XFFC59E87) ],
              stops: const [0.0, 0.5, 1.0]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleTextStyle: const TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
          title: const Text('Meeting Details'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 15,),
            TextRow('Name', meet.name),
            TextRow('Day', meet.weekday),
            TextRow('Time', meet.time),
            TextRow('Link', meet.link),
            TextRow('Id', meet.mId),
            TextRow('Password', meet.pass),
            TextRow('Starting From', meet.startDate),
            TextRow('Ends On', meet.endDate),
          ],
        )
      ),
    );
  }
}

Widget TextRow (String fieldName, String? value){
  return value == null
    ? const SizedBox.shrink()
    : Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
      children: [
        TextSecondaryBold(
            text: '$fieldName : ',
            color: color,
        ),
        Flexible(
          child: fieldName == 'Link' ? makeLink(value) : TextPrimary(
              text: fieldName == 'Day' ? getWeekday(int.parse(value)) : value,
              color: color,
          ),
        )
      ],
      ),
    );
}

Widget makeLink(String value) {
  return GestureDetector(
    child: TextPrimary(
        text: value,
        color: color,
    ),
    onTap: () async{
      final Uri url = Uri.parse(value);
      await launchUrl(url);
    },
  );
}
