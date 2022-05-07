import 'dart:math';

import 'package:dnlfqa_app/widgets.dart';
import 'package:flutter/material.dart';

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
        child: Scaffold(
          appBar: AppBar(
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
            TextThick(text: 'QATAR', color: Colors.grey[600]),
            Icon(Icons.flight_takeoff, color: Colors.grey[600],),
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
              TextThick(text: 'QATAR', color: Colors.grey[600]),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Icon(Icons.flight_land, color: Colors.grey[600],)
              ),
            ],
          ),
        )
    );
  }
}



