import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //구글맵을 이용하면 위경도 위치를 담당하는 객체가 있다 그 객체는 LatLng 이다
  //이 객체를 이용해서 초기 맵의 위치값을 지정하도록 할 예정

  static final LatLng academyLatLng = LatLng(37.495275, 127.029505);

  //내 폰에서 위치사용을 허가 받으려면, 사용자가 허가를 해줘야합니다
  //그 허가를 먼저 받도록 할 예정
  //그러기 위해서는 먼저, 위치 서비스가 활성화 되어 있는지를 판단해야 합니다. 아래는 해당 API 이다

  //화면에 마커 그리기.. 이 마커는 구글 플러그인에서 제공한다.. 여러마커를 사용할 수 있는데, 핵심은 마커별로 개별 ID 를
  //부여하고, 중복되지 않는 위 - 경도 값을 할당하는것이다 .. 이것이 중요하다 중복되면 표현이 되지않는다
  // 학원 위치 마커 선언
  static final Marker marker = Marker(
    markerId: MarkerId('academy'),
    position: academyLatLng,
  );

  //Circle 선언

  static final Circle circle = Circle(
    circleId: CircleId('aroundid'),
    center: academyLatLng,
    radius: 50, // 반경5미터
    fillColor: Colors.lightBlue.withOpacity(0.3),
    strokeColor: Colors.tealAccent,
    strokeWidth: 1,
  );
  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) return '위치 서비스를 활성화 해주 세요';

    //위치 권한을 확인 하도록 한다.

    LocationPermission checkPermission = await Geolocator.checkPermission();

    if (checkPermission == LocationPermission.denied) {
      //다시한번 위치 권한 요청하기
      checkPermission = await Geolocator.requestPermission();
      if (checkPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요';
      }
    }
    //만약 위치권한이 거절되면, 앱에서는 재요청 불가함
    if (checkPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 설정해주세요';
    }
    return '위치권한이 허가되었습니다';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (context, snapshot) {
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == '위치권한이 허가되었습니다') {
            return Column(
              children: [
                SizedBox(height: 15),
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: academyLatLng,
                      zoom: 18,
                    ),
                    myLocationEnabled: true,
                    markers: Set.from([marker]),
                    circles: Set.from([circle]),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.av_timer,
                        color: Colors.orangeAccent,
                        size: 30,
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          //이벤트에 따른 위치값 얻어내서
                          final curPosition =
                              await Geolocator.getCurrentPosition();

                          //위치 편차 구하기
                          final distance = Geolocator.distanceBetween(
                            curPosition.latitude,
                            curPosition.longitude,
                            academyLatLng.latitude,
                            academyLatLng.longitude,
                          );

                          bool canCheck = distance < 100;

                          //이 값을 기준으로 알러트를 생성합니다
                          //showDialog 를 생성할 건데, 여기에는 bulider 가 무인자 빌더로 구현합니다
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('이것은 타이틀이여 100미터 '),
                                content: Text(canCheck ? '등교췤' : '아직멀다'),
                                actions: [
                                
                                  if(canCheck)
                                  TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text('비콘'),),
                                    TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('취소'),
                                  ),
                                
                                ],
                              );
                            },
                          );
                        },
                        child: Text('비콘'),
                      ),
                  
                          SizedBox(width: 20,),
                          TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0
                                ),
                                borderRadius: BorderRadius.circular(20.0)
                              )
                            ),
                            style: TextStyle(fontSize: 25, backgroundColor: Colors.yellowAccent, ),
                            textAlign: TextAlign.center,
                            
                            
                          ),
                 
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(child: Text('알 수 없는 상태입니다'));
        },
      ),
    );
  }

  // App custom 해서 사용 해보기 app bar 로 설정
  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      title: Text(
        '출석체크 하기',
        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
      ),
    );
  }
}
