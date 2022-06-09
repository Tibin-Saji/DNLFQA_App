import 'package:dnlfqa_app/color_palette.dart';
import 'package:dnlfqa_app/firestore_functions.dart';
import 'package:dnlfqa_app/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';

import '../globals.dart';

Color textColor =
    darkTheme ? ColorPalette.colorLMain : ColorPalette.colorDSecondary;
TextEditingController myController = TextEditingController();

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.isMemFunc}) : super(key: key);
  Function isMemFunc;

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  late String verId;
  late String phone;
  bool codeSent = false;
  bool isVerified = false;
  bool getOTPButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Form(
            key: const Key('Initial Phone Login'),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    'assets/dnlfLogo.png',
                    scale: 4,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextTitleRegular(
                    text: "Let's get you started.",
                    color: textColor,
                    align: TextAlign.left,
                  ),
                  codeSent
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: OTPTextField(
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: 30,
                            style: const TextStyle(
                                fontSize: 40, color: ColorPalette.colorDMain),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            //fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) {
                              verifyPin(pin);
                            },
                          ),
                        )
                      : IntlPhoneField(
                          decoration: const InputDecoration(
                              //labelText: 'Phone Number',
                              ),
                          dropdownTextStyle: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: ColorPalette.colorDMain,
                              fontWeight: FontWeight.w600),
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              color: ColorPalette.colorDMain,
                              fontWeight: FontWeight.w600),
                          initialCountryCode: 'QA',
                          onChanged: (phoneNumber) {
                            setState(() {
                              phone = phoneNumber.completeNumber;
                            });
                          },
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  !codeSent
                      //TODO: When clicked, change text or the button itself into a circular progress indicator
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.925,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  getOTPButtonPressed = true;
                                });
                                verifyPhone();
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: ColorPalette.colorLMain),
                              child: !getOTPButtonPressed
                                  ? TextSecondaryBold(
                                      text: "Get OTP",
                                      color: ColorPalette.colorDMain,
                                    )
                                  : const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      child: CircularProgressIndicator(),
                                    )),
                        )
                      : TextButton(
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                  decoration: TextDecoration.underline)),
                          onPressed: () {
                            setState(() {
                              getOTPButtonPressed = false;
                              codeSent = false;
                            });
                          },
                          child: TextPrimary(
                              text: "Change Phone Number",
                              color: ColorPalette.colorGrey)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          const snackBar = SnackBar(content: Text("Login Success"));
          bool isMember = await checkMembership(phone);
          widget.isMemFunc(isMember);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        verificationFailed: (FirebaseAuthException e) {
          final snackBar = SnackBar(content: Text("${e.message}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            codeSent = true;
            verId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            verId = verificationId;
          });
        },
        timeout: const Duration(seconds: 60));
  }

  Future<void> verifyPin(String pin) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      bool isMember = await checkMembership(phone);
      const snackBar = SnackBar(content: Text("Login Success"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      //TODO: have a wrapper around this and home screen to control login
      widget.isMemFunc(isMember);
    } on FirebaseAuthException catch (e) {
      const snackBar =
          SnackBar(content: Text("Some error occurred logging you in."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
