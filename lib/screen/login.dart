import 'package:meomeo/components/text.dart';
import 'package:meomeo/helpers/authen_google.dart';
import 'package:meomeo/helpers/utils.dart';
import 'package:meomeo/provider/account.dart';
import 'package:meomeo/screen/main_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/authen_facebook.dart';
import '../helpers/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "", password = "";

  _signInWithGoogle() async {
    UserCredential? user = await signInWithGoogle();
    if (user?.additionalUserInfo?.profile != null) {
      saveDataLogin(user: user, typeLogin: "google");
      getLocalDataLogin(provider: Provider.of<AccountProvider>(context, listen: false));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainHomeScreen(),
          ),
          (route) => false);
    }
  }

  _signInWithFacebook() async {
    UserCredential? user = await signInWithFacebook();
    if (user?.additionalUserInfo?.profile != null) {
      saveDataLogin(typeLogin: "facebook", user: user);
      getLocalDataLogin(provider: Provider.of<AccountProvider>(context, listen: false));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainHomeScreen(),
          ),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isLogin") == true) {
      getLocalDataLogin(provider: Provider.of<AccountProvider>(context, listen: false));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainHomeScreen(),
          ),
          (route) => false);
    }
  }

  void initialization() async {
    _checkLogin();
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Image(
              image: AssetImage("images/MeoMeo.png"),
              width: 50.w,
              fit: BoxFit.contain,
            ),
            customText(
                title: "Meo Meo",
                color: colorLogo,
                fontSize: 40,
                minFontSize: 30,
                maxFontSize: 50,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 30,
            ),
            textField(isUsername: true, title: "Username"),
            SizedBox(
              height: 30,
            ),
            textField(isUsername: false, title: "Password"),
            SizedBox(
              height: 30,
            ),
            _btnLogin(),
            SizedBox(
              height: 20,
            ),
            _optionLogin(),
          ],
        ),
      ),
    );
  }

  Widget _btnLogin() {
    return Container(
      width: 80.w,
      decoration: BoxDecoration(
        color: colorLogo,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 45,
        child: TextButton(
            onPressed: () {},
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.white.withOpacity(0.2)),
            ),
            child: customText(
                title: "Login",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400)),
      ),
    );
  }

  Widget _optionLogin() {
    return Container(
      width: 80.w,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _line()),
              customText(title: "  OR  ", color: colorLogo, fontSize: 15),
              Expanded(child: _line()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _containerOptionLogin(isFaceBook: true),
              _containerOptionLogin(isFaceBook: false),
            ],
          )
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 1,
      color: Colors.grey.withOpacity(0.8),
    );
  }

  Widget _containerOptionLogin({required bool isFaceBook}) {
    return Container(
      width: 55,
      height: 55,
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(45),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            ),
            overlayColor:
                MaterialStateProperty.all<Color>(colorLogo.withOpacity(0.1)),
          ),
          onPressed: () async {
            if (isFaceBook) {
              // code for login facebook
              await _signInWithFacebook();
            } else {
              //code for login google
              await _signInWithGoogle();
            }
          },
          child: Center(
              child: FaIcon(
            isFaceBook
                ? FontAwesomeIcons.facebookF
                : FontAwesomeIcons.googlePlusG,
            size: 20,
            color: colorLogo,
          ))),
    );
  }

  Widget textField({required bool isUsername, required String title}) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: 80.w,
        child: TextField(
          onChanged: (value) {
            if (isUsername) {
              username = value.trim();
            } else {
              password = value.trim();
            }
            setState(() {});
          },
          cursorColor: colorLogo,
          obscureText: !isUsername,
          decoration: InputDecoration(
            hintText: title,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: colorLogo),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
