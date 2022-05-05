import 'package:meomeo/components/image.dart';
import 'package:meomeo/components/text.dart';
import 'package:meomeo/helpers/authen_facebook.dart';
import 'package:meomeo/helpers/authen_google.dart';
import 'package:meomeo/helpers/color.dart';
import 'package:meomeo/helpers/icon_custom/meo_meo_icon_icons.dart';
import 'package:meomeo/helpers/utils.dart';
import 'package:meomeo/provider/account.dart';
import 'package:meomeo/screen/account/settings.dart';
import 'package:meomeo/screen/account/support.dart';
import 'package:meomeo/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _doLogout({required AccountProvider providerUser}) {
    if (providerUser.typeLogin == "google") {
      signOutWithGoogle();
    } else {
      signOutWithFacebook();
    }
    clearAllData(provider: providerUser);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
  }

  _doNavigaScreen({required String tittle}) {
    switch (tittle) {
      case "Settings":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
      case "Support":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SupportScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<AccountProvider>(context);
    return SafeArea(
      child: Container(
        width: 100.w,
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _showInfoAccount(providerUser: providerUser),
            const SizedBox(
              height: 20,
            ),
            Flexible(child: _showListOption(providerUser)),
          ],
        ),
      ),
    );
  }

  Widget _showInfoAccount({required AccountProvider providerUser}) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
              child: loadUrlImage(
                setSize: false,
                height: 160,
                width: 160,
                imageUrl: providerUser.photoURL,
              ),
            ),
            Positioned(
                bottom: 5,
                right: 2,
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: colorLogo.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(45)),
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ))),
          ],
        ),
        const SizedBox(height: 20),
        customText(
            title: providerUser.displayName,
            fontWeight: FontWeight.w500,
            fontSize: 18),
        const SizedBox(height: 5),
        customText(
            title: providerUser.email,
            fontSize: 16,
            color: Colors.black.withOpacity(0.7)),
      ],
    );
  }

  Widget _showListOption(AccountProvider providerUser){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          children: [
            customContainer(
                title: "Settings",
                icon: MeoMeoIcon.setting,
                sizeIcon: 20,
                onTap: () => _doNavigaScreen(tittle: "Settings")),
            customContainer(
                title: "Help & Support",
                icon: Icons.help_outline,
                sizeIcon: 25,
                onTap: () => _doNavigaScreen(tittle: "Support")),
            customContainer(
                title: "Logout",
                icon: MeoMeoIcon.logout,
                sizeIcon: 20,
                isShowArrowBack: false,
                onTap: () => _doLogout(providerUser: providerUser)),

          ],
        ),
      ),
    );
  }
  Widget customContainer(
      {Function()? onTap,
      required String title,
      IconData? icon,
      bool isShowArrowBack = true,
      double? sizeIcon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        width: 80.w,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              SizedBox(
                  width: 30,
                  child: Icon(icon ?? Icons.new_releases_outlined,
                      color: Colors.grey, size: sizeIcon ?? 30)),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: customText(
                    title: title.trim(),
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w400),
              )),
              SizedBox(
                  child: isShowArrowBack
                      ? Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.grey, size: 20)
                      : null),
            ],
          ),
        ),
      ),
    );
  }
}
