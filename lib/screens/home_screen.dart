import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dnlfqa_app/screens/settings_screen.dart';
import 'package:dnlfqa_app/screens/wishing_screen.dart';
import 'package:dnlfqa_app/widgets.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
// import 'package:http/browser_client.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../color_palette.dart';
import '../notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //bool _loading = true;


  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text('Allow Notifications'),
                  content: const Text('Our app would like to send you notifications'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Don\'t Allow',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) => Navigator.pop(context)),
                      child: const Text(
                        'Allow',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
          );
        }
      },
    );

    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextPrimary(text: 'Scheduled Notification Set'),
        ),
      );
    });

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
              AwesomeNotifications().setGlobalBadgeCounter(value - 1),
        );
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const WishScreen(),
          ),
              (route) => route.isFirst);
    });
  }


  @override
  Widget build(BuildContext context) {

    final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      textStyle: const TextStyle(
        fontSize: 60,
      ),
      fixedSize: const Size(300, 150),
    );
    final scrollBtns = [
      ElevatedButton(
          style: style,
          onPressed: () {},
          child: TextTitle(
              text: "News",
              align: TextAlign.center,
              color: ColorPalette.colorLMain
          )
      ),
      ElevatedButton(
        style: style,
          onPressed: () {},
          child: TextTitle(
            text: "Announcements",
            align: TextAlign.center,
            color: ColorPalette.colorLMain
          )
      ),
      ElevatedButton(
        style: style,
          onPressed: () {},
          child: TextTitle(
              text: "Forms",
              align: TextAlign.center,
              color: ColorPalette.colorLMain
          )
      ),
      ElevatedButton(
        style: style,
          onPressed: () {},
          child: TextTitle(
              text: "Upcoming Meetings",
              align: TextAlign.center,
              color: ColorPalette.colorLMain
          )
      ),
      ElevatedButton(
          style: style,
          onPressed: () {},
          child: TextTitle(
              text: "Gallery",
              align: TextAlign.center,
              color: ColorPalette.colorLMain
          )
      ),
      ElevatedButton(
          style: style,
          onPressed: () {},
          child: TextTitle(
              text: "Prayer Requests",
              align: TextAlign.center,
              color: ColorPalette.colorLMain
          )
      ),
    ];
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    return Scaffold(
      backgroundColor: ColorPalette.colorLMain,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.5, 1),
            end: Alignment(-0.5, -1.0),
            colors: [
              Color(0xFFFAEDDD),
              Color(0XFFDDC2AE),
              Color(0XFFA97C62),
            ],
            stops: [
              0.0,
              0.7,
              1.0
            ]

          )
        ),
        child: SafeArea(
          child: ListView(
            children:  [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Image.asset(
                        'assets/dnlfLogo.png',
                        scale: 4,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    iconSize: 45,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
                  CarouselSlider.builder(
                      itemCount: scrollBtns.length,
                      itemBuilder: (context, index, realIndex){
                        final scrollBtn = scrollBtns[index];
                        return buildImage(scrollBtn, index);
                      },
                      options: CarouselOptions(
                        viewportFraction: 0.8,
                        height: 175,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      )
                  ),
                  SizedBox(height: 30,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextSubTitle(
                          text: "Daily Manna",
                          color: ColorPalette.colorDMain,
                        ),
                        SizedBox(height: 5,),
                        YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          bottomActions: [
                            CurrentPosition(),
                            ProgressBar(isExpanded: true),
                          ],
                        ),
                        SizedBox(height: 15,),
                        TextSubTitle(
                          text: "Pastor's\nMessage",
                          color: ColorPalette.colorDMain,
                        ),
                        TextPrimary(
                            text: "Lorem ipsum dolor sit amet"
                                ", consectetur adipiscing elit. Maecenas nec elementum dui, non scelerisque sapien. Pellentesque tempor "
                                "\neget neque at scelerisque. Morbi auctor leo nisi, vel commodo elit venenatis ut. Maecenas mollis ex non urna tincidunt,"
                                "consectetur adipiscing elit. Maecenas nec elementum dui, non scelerisque sapien. Pellentesque tempor "
                                " a varius nibh ultricies. In eu arcu a augue aliquet pulvinar. Nam ante erat, dignissim vitae velit sit amet, imperdiet dignissim sem. Aliquam tincidunt sapien quis elementum cursus.\n Curabitur non felis facilisis, iaculis sapien eu, semper mauris.",
                            color: ColorPalette.colorDMain
                        ),
                        SizedBox(height: 20,),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.black,
                        ),
                        // SizedBox(height: 20,),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset('assets/Youtube_Icon.png'),
                                onPressed: (){},
                              ),
                              IconButton(
                                icon: Image.asset('assets/Facebook_Icon.png'),
                                onPressed: (){},
                              ),
                              IconButton(
                                icon: Image.asset('assets/Insta_Icon.png'),
                                onPressed: (){},
                              ),
                              IconButton(
                                icon: Image.asset('assets/Twitter_Icon.png'),
                                onPressed: (){},
                              ),
                              IconButton(
                                icon: Image.asset('assets/Whatsapp_Icon.png'),
                                onPressed: (){},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
              /*
              SizedBox(height: 10,),
              TextButton(
                  onPressed: () {
                    DateTime dt = DateTime.now().add(const Duration(seconds: 5));
                    createScheduledNotification(
                        DateTime.now().add(const Duration(seconds: 5))
                    );
                  },
                  child: TextPrimary(text: 'Schedule notification')
              ),
              TextButton(
                  onPressed: cancelScheduledNotifications,
                  child: TextPrimary(text: 'Delete notification')
              ),
              */
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(ElevatedButton button, int index) => Container(
    //margin: const EdgeInsets.symmetric(),
    child: button
  );

}
