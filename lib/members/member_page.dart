import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

class Member extends StatefulWidget {
  const Member({Key? key}) : super(key: key);

  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<Member> {
  BMFMapController? mapController;

  @override
  void initState() {
    super.initState();
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    mapController = controller;

    mapController?.setCustomMapStyleEnable(true);
    mapController?.setCustomMapStyle(
        'files/4cd6e8996e6bc4bb3d0194ba01ec7b89.sty', 0);
    mapController?.showUserLocation(true);
    mapController?.updateMapOptions(BMFMapOptions(maxZoomLevel: 20));
    mapController?.updateMapOptions(BMFMapOptions(showMapScaleBar: true));

    BMFCoordinate coordinate = BMFCoordinate(30.24817, 120.163637);

    BMFLocation location = BMFLocation(
        coordinate: coordinate,
        altitude: 0,
        horizontalAccuracy: 5,
        verticalAccuracy: -1.0,
        speed: 1.0,
        course: 1.0);
    BMFUserLocation userLocation = BMFUserLocation(
      location: location,
    );
    mapController?.updateLocationData(userLocation);

    /// 地图加载回调
    mapController?.setMapDidLoadCallback(callback: () {
      print('地图加载完成');
    });
  }

  /// 设置地图参数
  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(30.24817, 120.163637),
      zoomLevel: 14,
      changeCenterWithDoubleTouchPointEnabled: true,
      gesturesEnabled: true,
      scrollEnabled: true,
      zoomEnabled: true,
      rotateEnabled: true,
      compassPosition: BMFPoint(0, 0),
      showMapScaleBar: false,
      maxZoomLevel: 15,
      minZoomLevel: 8,
//      mapType: BMFMapType.Satellite
    );
    return mapOptions;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "地图",
          style: TextStyle(fontFamily: 'Pixel'),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            onBMFMapCreated(controller);
          },
          mapOptions: initMapOptions(),
        ),
      ),
    );
  }
}
