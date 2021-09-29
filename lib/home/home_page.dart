import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, Object>? _locationResult;
  BaiduLocation? _baiduLocation; // 定位结果

  StreamSubscription<Map<String, Object>?>? _locationListener;

  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

  @override
  void initState() {
    super.initState();
    _locationPlugin.requestPermission();
    LocationFlutterPlugin.setApiKey("Yp5mSSpy1rX0tx8ZqTvfE3OON2wKZiQ1");

    _locationListener = _locationPlugin
        .onResultCallback()
        .listen((Map<String, Object>? result) {
      setState(() {
        _locationResult = result;
        try {
          _baiduLocation =
              BaiduLocation.fromMap(result); // 将原生端返回的定位结果信息存储在定位结果类中
          print(_baiduLocation?.getMap());
          _sendLocData();
        } catch (e) {
          print(e);
        }
      });
    });
  }

  Future<void> _sendLocData() async {
    _locationResult!.putIfAbsent("userId", () => 3);
    Response response;
    var dio = Dio();
    var formData = FormData.fromMap(_locationResult!);
    response = await dio.post('http://192.168.31.33:20001/record/push',
        data: formData);
    print("--------------");
    print(response);
  }

  // 设置android端和ios端定位参数
  void _setLocOption() {
    // android 端设置定位参数
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Battery_Saving); // 设置定位模式
    androidOption.setScanspan(2000); // 设置发起定位请求时间间隔

    Map androidMap = androidOption.getMap();

    // ios 端设置定位参数
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    iosOption.setBMKLocationCoordinateType(
        "BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
    iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
    iosOption.setLocationTimeout(10); // 设置位置获取超时时间
    iosOption.setDesiredAccuracy("kCLLocationAccuracyBest"); // 设置预期精度参数
    iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
    iosOption.setDistanceFilter(100); // 设置定位最小更新距离
    iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
    iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

    Map iosMap = iosOption.getMap();

    _locationPlugin.prepareLoc(androidMap, iosMap);
  }

  /// 启动定位
  void _startLocation() {
    _setLocOption();
    _locationPlugin.startLocation();
  }

  /// 停止定位
  void _stopLocation(){
    _locationPlugin.stopLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               ElevatedButton(
                onPressed: _startLocation,
                child:  Text('开始定位'),
              ),
               Container(width: 20.0),
              ElevatedButton(
                onPressed: _stopLocation,
                child:  Text('停止定位'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
