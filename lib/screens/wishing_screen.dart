import 'dart:math';

import 'package:dnlfqa_app/color_palette.dart';
import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class WishScreen extends StatefulWidget {
  const WishScreen({Key? key}) : super(key: key);

  @override
  _WishScreenState createState() => _WishScreenState();
}

class _WishScreenState extends State<WishScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(-0.5, -1),
                  end: Alignment(0.5, 1.0),
                  colors: darkTheme ? [Color(0xFF2D211C), Color(0XFF4D331D), Color(0XFF8D6852)]  :  [Color(0xFFF4DCC0), Color(0XFFDDC2AE), Color(0XFFC59E87) ],
                  stops: const [0.0, 0.5, 1.0]
              )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              titleTextStyle: TextStyle(fontSize: 24, fontFamily: 'SFUIText'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              bottom: const TabBar(
                tabs: [
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                          child: ListTile(
                            title: Text('Tibin Mathew Saji'),
                            trailing: IconButton(
                                onPressed: (){print('Called');},
                                icon: Icon(Icons.phone
                                )
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                          child: ListTile(
                            title: Text('Tibin Mathew Saji'),
                            trailing: IconButton(
                                onPressed: (){print('Called');},
                                icon: Icon(Icons.phone
                                )
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      const TravelFromQatarDivider(),
                      Card(
                          child: ListTile(
                            title: TextPrimary(text: 'Br. Tibin Mathew Saji \nSis. Tibin Mathew Saji'),
                            trailing: IconButton(
                                onPressed: (){print('Called');},
                                icon: Icon(Icons.phone)
                            ),
                          )
                      ),
                      SizedBox(height: 20,),
                      const TravelToQatarDivider(),
                      Card(
                          child: ListTile(
                            title: TextPrimary(text: 'Br. Tibin Mathew Saji \nSis. Tibin Mathew Saji'),
                            trailing: IconButton(
                                onPressed: (){print('Called');},
                                icon: Icon(Icons.phone)
                            ),
                          )
                      ),
                      Card(
                          child: ListTile(
                            title: TextPrimary(text: 'Br. Tibin Mathew Saji \nSis. Tibin Mathew Saji'),
                            trailing: IconButton(
                                onPressed: (){print('Called');},
                                icon: Icon(Icons.phone)
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class TravelFromQatarDivider extends StatelessWidget {
  const TravelFromQatarDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
        child: Row(
          children: [
            TextThick1(text: 'QATAR', color: ColorPalette.colorLMain),
            Icon(Icons.flight_takeoff, color: ColorPalette.colorLMain,),
          ],
        ),
      )
    );
  }
}

class TravelToQatarDivider extends StatelessWidget {
  const TravelToQatarDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
          child: Row(
            children: [
              TextThick1(text: 'QATAR', color: ColorPalette.colorLMain),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Icon(Icons.flight_land, color: ColorPalette.colorLMain,)
              ),
            ],
          ),
        )
    );
  }
}



