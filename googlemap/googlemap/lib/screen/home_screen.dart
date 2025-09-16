import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  
  //구글맵을 이용하면 위경도 위치를 담당하는 객체가 있다 그 객체는 LatLng 이다
  //이 객체를 이용해서 초기 맵의 위치값을 지정하도록 할 예정

  static final LatLng academyLatLng =LatLng(37.494813 , 127.030080);

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: renderAppBar(),
      body: GoogleMap(initialCameraPosition: CameraPosition(
        target: academyLatLng,
        zoom: 44)),);
  }
  // App custom 해서 사용 해보기 app bar 로 설정
  AppBar renderAppBar(){
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      title: Text(
        '출석체크 하기',
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold
        ),),
    );
  }
}
