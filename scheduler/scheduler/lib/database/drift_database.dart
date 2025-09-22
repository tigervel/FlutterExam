//part 를 구성하고, 이를 build 해서 실제 CRUD 를 구현하도록 하는 DB 클래스를 생성하도록합니다.

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:scheduler/model/schedule.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

//part 는 일반적으로 이 파일이름에 .g. 를 넣어서 생성합니다.

part 'drift_database.g.dart';

//사용할 테이블 생성 및 등록
@DriftDatabase(tables: [Schedules])
//helper 클래스 생성..일반적으로 LocalDataBase 와 _$... 이름으로 생성함
class LocalDataBase extends _$LocalDataBase {
  LocalDataBase() : super(_openConnection());

  //수행될 쿼리 curd 를 작성해 봅니다.
  //데이터를 조회 하고 변화를 감지 하는 watch 메서드 호출
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  //Insert 작성..
  //Insert 시엔 build 가 제대도 되면, Entity명+Companion 이라는 객체가 생성됨
  //이 객체의 내부엔 데이터가 들어가 있음..이걸 이용해서 insert 해주면 됨.
  //제대로 insert 되면, 결과 row count 가 리턴됨..Future 타입임..
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  removeSchdule(int id) =>
      (delete(schedules)..where((table) => table.id.equals(id))).go();

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory(); //DB 파일 저장 폴더
    print('---->${dbFolder.path}');
    final file = File(p.join(dbFolder.path, 'db.sqllite'));
    return NativeDatabase(file);
  });
}
