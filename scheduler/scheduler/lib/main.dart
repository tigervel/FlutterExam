import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/provider/schedule_provider.dart';
import 'package:scheduler/repository/ScheduleRepository.dart';
import 'package:scheduler/screen/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduler/database/drift_database.dart';

//다국어 설정 할게요.. 매우 간단함...
//플러터가 로딩 될때까지 기다렸다가, intl 의 초기화 함수를 실행하고, 언어 설정값을 지정만 하면 됩니다.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  final database = LocalDataBase();
  GetIt.I.registerSingleton<LocalDataBase>(database);

  //provider 초기화 코드 
  final repository = Schedulerepository();
  final scheduleProvider = ScheduleProvider(repository: repository);


  runApp(
    //프로바이더를 하위 위젯에 제공하기
    ChangeNotifierProvider(create: (_) => scheduleProvider, child: MaterialApp(home: HomeScreen()),)
    );
}
