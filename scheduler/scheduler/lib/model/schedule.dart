//테이블로 구성될 클래스 정의..이때 table 이라는 클래스의 자식으로 선언 되어야 함.
//컬럼및 속성 등의 보면암...

import 'package:drift/drift.dart';

class Schedules extends Table {
  //컬럼및 속성 선언함.

  //커럼타입
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get start => integer()();
  IntColumn get end => integer()();
}
