//글로벌 상태 관리 역할을 하는 프로바이더를 사용.. 대부분 플러터 사용자가 이 프로바이더를 사용
//사용하는 형태는 각 위젯에서 상태관리를 각각하는게 아니라, 이 프로바이더를 창조해서 상태관리를 하도록 한다고 생각하면 된다
//모든 클래스는 플로바이더화 되어질 수 있고, 프로바이더가 되는 방법은 ChangeNotifler 을 상속 하기만 하면된다
//이 클래스를 상속받는 클래스는 목적에 따라 변수가 필요한데, 지금은, Repository, 선택된 날짜, API 를 통해서 얻어낸 일정 정보를 저장한 cache 변수이다



import 'package:flutter/material.dart';
import 'package:scheduler/model/schedule_model.dart';
import 'package:scheduler/repository/ScheduleRepository.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider extends ChangeNotifier{
  //API 요청 로직을 담은 객체 변수 선언
  final Schedulerepository repository;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  //일정 정보를 저장할 변수
  Map<DateTime, List<ScheduleModel>> cache = {};

  ScheduleProvider({
    required this.repository
  }):super(){
    getSchedules(date : selectedDate);
  }
  
  void getSchedules({required DateTime date}) async{
    final resp = await repository.getSchedule(date: date);

    cache.update(date, (value)=> resp, ifAbsent: () => resp,);

    //이 프로바이더를 제공받는 모든 위젯에게 업데이트 요청
    notifyListeners();
  }
  //스케쥴 생성 정의
  void createSchedule({
    required ScheduleModel schedule,
  }) async {
    final targetDate = schedule.date;
    //스케줄 별 id 생성
    final uuid = Uuid();
    final tempId = uuid.v4();
    final newSchedule = schedule.copuWith(id: tempId);


    //서버에서 응답받기 전에 캐시 데이터 먼저 업데이트
    cache.update(
      targetDate, (value) => [
        ...value,
        newSchedule
      ]..sort((a, b) => a.startTime.compareTo(b.startTime)),
      ifAbsent: () => [newSchedule],);

      //위젯 업데이트
      notifyListeners();

      //위에서 캐시 업데이트 했으니, 이제 서버로부터 응답 get
      try{
        final savedSchedule = await repository.createSchedule(schedule: schedule);
        cache.update(
          targetDate,
          (value) => value.map((e) => e.id ==tempId ? e.copuWith(id:savedSchedule):e).toList(),);
      }catch(e){
        cache.update(
          targetDate,
          (value) => value.where((e) => e.id != tempId).toList());
      }
  }

  //삭제 
  void deleteSchedule({required DateTime date, required String id}) async{
    final targetSchedule = cache[date]!.firstWhere(
      (e) => e.id == id); //삭제될 일정을 기억 시킴

      //캐시 업데이트
      cache.update(
        date,
        (value) => value.where((e) => e.id != id).toList(),
        ifAbsent: () => [],);

        notifyListeners();


        try{
          await repository.deleteSchedule(id: id); //삭제 함수 실행

        }catch(e){
          cache.update(
            date,
            (value) => 
              [...value,targetSchedule]..sort((a, b) => a.startTime.compareTo(b.startTime),));
              
        }
        notifyListeners();
  }

  void changeSelectedDate({
    required DateTime date}) {
      selectedDate = date;
      notifyListeners();
  }
}