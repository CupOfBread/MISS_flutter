import 'package:miss/transit_page.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFMapSDK, BMF_COORD_TYPE;

void main() {
  runApp(const MyApp());
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        '请输入百度开放平台申请的iOS端API KEY', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CupOfBread',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: const TransitPage(),
    );
  }
}
