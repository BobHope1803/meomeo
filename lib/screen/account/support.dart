import 'package:flutter/material.dart';

import '../../helpers/color.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorLogo,
        title: Text("Help & Support"),
      ),
      body: Container(color: Colors.white,),
    );
  }
}
