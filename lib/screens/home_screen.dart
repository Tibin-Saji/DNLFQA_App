import 'dart:io';

import 'package:dnlfqa_app/globals.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dnlfqa_app/screens/meetings_screen.dart';
import 'package:dnlfqa_app/screens/settings_screen.dart';
import 'package:dnlfqa_app/screens/wishing_screen.dart';
import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../color_palette.dart';

class HomeScreen extends StatefulWidget {
  //TODO: Pass the video id from main itself
  const HomeScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var isLoading;
  var id;
  bool darkTheme = true;


  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  Future<void> getVideoId() async{
    setState(() => isLoading = true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.get(SharedPrefName.VideoId);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getVideoId();
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

    final Color color = darkTheme ? ColorPalette.colorDMain : ColorPalette.colorLMain;

    final MyElevatedButtonStyle style = MyElevatedButtonStyle(
      height: 150,
      width: 300,
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
          colors: darkTheme ? [const Color(0xFFFBEFDF), const Color(0xFFAC7656)] : [const Color(0xFF251712), const Color(0xFF462E25)],
          begin: const Alignment(-1,-1),
          end: const Alignment(1,1),
      )
    );

    final iconColor = darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDMain;
    print(id);
    final scrollBtns = [
      MyElevatedButton( 
          style: style,
          onPressed: () {},
          child: TextTitleRegular(
              text: "News",
              color: color
          )
      ),
      MyElevatedButton(
        style: style,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishScreen()),
            );
          },
          child: TextTitleRegular(
            text: "Announcements",
              color: color
          )
      ),
      MyElevatedButton(
        style: style,
          onPressed: () {},
          child: TextTitleRegular(
              text: "Forms",
              color: color
          )
      ),
      MyElevatedButton(
        style: style,
          onPressed: () {},
          child: TextTitleRegular(
              text: "Upcoming Meetings",
              color: color
          )
      ),
      MyElevatedButton(
          style: style,
          onPressed: () {},
          child: TextTitleRegular(
              text: "Gallery",
              color: color
          )
      ),
      MyElevatedButton(
          style: style,
          onPressed: () {},
          child: TextTitleRegular(
              text: "Prayer Requests",
              color: color
          )
      ),
    ];
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    return Scaffold(
      backgroundColor: ColorPalette.colorLMain,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.5, -1),
            end: Alignment(0.5, 1.0),
            colors: darkTheme ? [Color(0xFF2D211C), Color(0XFF4D331D), Color(0XFF8D6852)]  :  [Color(0xFFF4DCC0), Color(0XFFDDC2AE), Color(0XFFC59E87) ],
            stops: [
              0.0,
              0.5,
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
                    color: iconColor,
                    icon: Image.asset(
                        'assets/PrayerIcon.png',
                        color: iconColor,
                    ),
                    iconSize: 45,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MeetingScreen()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              // CarouselSlider.builder(
              //     itemCount: scrollBtns.length,
              //     itemBuilder: (context, index, realIndex){
              //       final scrollBtn = scrollBtns[index];
              //       return buildImage(scrollBtn, index);
              //     },
              //     options: CarouselOptions(
              //       viewportFraction: 0.8,
              //       height: 175,
              //       autoPlay: false,
              //       enlargeCenterPage: true,
              //       enlargeStrategy: CenterPageEnlargeStrategy.height,
              //     )
              // ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSubTitleRegular(
                      text: "Daily Manna",
                      color: darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDMain
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
                    TextSubTitleRegular(
                      text: "Pastor's Message",
                      color: darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDMain                      ),
                    TextPrimary(
                        text: '''God is immutable or never changing. His love too is unchangeable. The key verse of the bible John 3:16 is an answer to how much God loves us. The love was to such an extent that He gave His only begotten Son to be crucified on the cross for us.
                        A meaningful life starts when we begin to love the God who loves us. A small stream of water flows on to become a river and then an ocean of great torrents. Likewise, the beginning of this life is like a small stream of water which flows on to become a great ocean of Eternal life in Eternity with the Eternal God.
                        The greatest fear of a common man is death. In reality, even men who are ready to die for their principles and ideologies, have a secret fear of death. The basic reason for this fear is the anxiety of what might happen to them after their death.
                    Do you know what will happen to you after your death? Is it possible to know?
                    The Bible clearly states that life does not end with death. With death, only the life on this earth comes to an end but then we enter into a life that is everlasting. Just like a baby comes out of its mother’s womb into this world at birth, we will enter into a different world from the ‘womb of the earth’ after our death.
                    Which world is that? The Bible teaches about two worlds that a man can go into after his death.
                    One World, where there is no liberation; filled with pain, condemnation, fiery lake of burning sulphur; with worms that do not die and fire that does not quench. It has satan and his evil forces being punished and human souls getting tortured. This world is the Eternal Hell.
                    The other World is filled with eternal happiness and peace; where sickness and plagues never afflict us; adorned with tree of life and river of life; vested with God and His holy angels. That is Eternal Heaven.
                        After death, you will ingress one of these worlds. The life on this earth is also for you to decide which one to choose. If you choose hell, you have nothing to do because hell is for all those who do not enter heaven. But to enter heaven, God had given all an opportunity. To attain heaven, you only have to believe in Jesus Christ who was crucified on the cross for the sins of all mankind.
                    Declare with your mouth that 'Jesus Christ is Lord', accept Him in your heart with faith, obey the Word of God, receive baptism and live for Christ. These mark the beginning of an Eternal life in heaven with an Eternal God and a meaningful life on earth.
                    I hope that you may inherit this new life to abide with the Eternal God and to have a meaningful life ahead.
                    God Bless You''',
                        color: darkTheme ? Color(0xFFAB9787) : ColorPalette.colorDMain
                    ),
                    SizedBox(height: 20,),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: darkTheme ? ColorPalette.colorLSecondary : ColorPalette.colorDMain
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/Youtube_Icon_Out.png',
                              color: iconColor,
                            ),
                            onPressed: (){},
                          ),
                          IconButton(
                            icon: Image.asset(
                                'assets/Facebook_Icon_Out.png',
                                color: iconColor,
                            ),
                            onPressed: (){},
                          ),
                          IconButton(
                            icon: Image.asset(
                              'assets/Insta_Icon_Out.png',
                              color: iconColor,
                            ),
                            onPressed: (){},
                          ),
                          IconButton(
                            icon: Image.asset(
                                'assets/Twitter_Icon_Out.png',
                              color: iconColor,
                            ),
                            onPressed: (){},
                          ),
                          IconButton(
                            icon: Image.asset(
                              'assets/Whatsapp_Icon_Out.png',
                              color: iconColor,
                            ),
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

  Widget buildImage(MyElevatedButton button, int index) => Container(
    //margin: const EdgeInsets.symmetric(),
    child: button
  );

}
