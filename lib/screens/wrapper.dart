import 'package:dnlfqa_app/screens/login_screeen.dart';
import 'package:flutter/cupertino.dart';

import '../globals.dart';
import 'home_not_member_screen.dart';
import 'home_screen.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // bool? _isMember;

  void isMemFunc(bool? result) {
    //TODO: save it in shared preferences too.
    setState(() {
      print('the result is $result');
      isMember = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return HomeNotMemberScreen(
    //   isMemFunc: isMemFunc,
    // );

    if (isMember == null) {
      return LoginScreen(isMemFunc: isMemFunc);
    } else {
      return isMember!
          ? HomeScreen(isMemFunc: isMemFunc)
          : HomeNotMemberScreen(isMemFunc: isMemFunc);
    }
  }
}
