import 'dart:async';

import 'package:miss/root_page.dart';
import 'package:flutter/material.dart';

class TransitPage extends StatefulWidget {
  const TransitPage({Key? key}) : super(key: key);

  @override
  _TransitPageState createState() => _TransitPageState();
}

class _TransitPageState extends State<TransitPage> {
  late Timer _timer;
  int _currentTime = 2;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        _jumpRootPage();
      }
    });
  }

  void _jumpRootPage() {
    _timer.cancel();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (BuildContext context) => const RootPage(),
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          children: [
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height / 5,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3.5,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
