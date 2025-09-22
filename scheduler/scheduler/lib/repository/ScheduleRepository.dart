//CRUD 를 구현한 repository
//이 파일의 클래스를 이용해서 서버와 API 통신을 구현함

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:scheduler/model/schedule_model.dart';

class Schedulerepository {

  //DIO 객체 : 플러터에서 HTTP 통신을 위한 Powerful 한 Lib 이다  이 객체를 이용 해야만 http 통신 (get,post,del 등)을 사용할 수 있다
  final dio = Dio();
  //접속할 로컬 경로 설정
  //Android 는 로컬 경로 10.0.2.2 로 인식한다 , 나머지 플랫폼은 그냥 localhost 이다
  final targetUrl = 'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/schedule';

  //특정 날짜에 해당하는 전체 스케쥴 get 함수 정의
  Future<List<ScheduleModel>> getSchedule({
    required DateTime date,
  }) async{
    final resp = await dio.get(
      targetUrl, 
      queryParameters: {
      'date':
        '${date.year}${date.month.toString().padLeft(2,'0')}${date.day.toString().padLeft(2,'0')}',
    });

    return resp.data
    .map<ScheduleModel>((x)=> ScheduleModel.fromJson(json: x))
    .toList();
  }


  //특정 날짜에 해당하는 스케쥴 생성 API 정의
  Future<String> createSchedule({
    required ScheduleModel schedule
  }) async{

    //모델을 JSON 으로 변환
    final json = schedule.toJson();

    //post 로 데이터 전송
    final resp = await dio.post(targetUrl, data: json);

    return resp.data?['id'];

  }

  //삭제 처리
  Future<String> deleteSchedule({
    required String id,

  })async {
    final resp = dio.delete(targetUrl, data: {'id' : id});
    return resp.toString();
  }

}