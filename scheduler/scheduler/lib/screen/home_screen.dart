import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/component/main_calendar.dart';

import 'package:scheduler/const/colors.dart';
import 'package:scheduler/database/drift_database.dart';
import 'package:scheduler/provider/schedule_provider.dart';
import 'package:scheduler/screen/schedule_card.dart';
import 'package:scheduler/screen/today_banner.dart';
import 'package:scheduler/component/shedule_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

//Provider 를 이용한 상태 관리 코드..Provider 를 제공하면  상태객체를 생성할 필요없이
//위젯에 프로바이더만 등록 해주면 됨.
class HomeScreen extends StatelessWidget {
  //선택된 날짜 관리 변수 선언.

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //프로바이더 지정하고, 프로바이더가 변경이 있을때만다 build  함수 재실행 하도록 메서드 호출함.
    final provider = context.watch<ScheduleProvider>();

    //선택된 날짜 가져오기..프로바이더에 정의 했으니 get.
    final selectedDate = provider.selectedDate;
    //선택된 날짜에 해당하는 일정 가져오기.
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //아래서 위로 새로운 앱이 오픈되도록 하는 위젯을 사용합니다.
          showModalBottomSheet(
            context: context,
            builder: (_) => ScheduleBottomSheet(selectedDate: selectedDate),
            //스크롤을 가능하도록 설정함.
            isScrollControlled: true,
            isDismissible: true,
          );
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          MainCalendar(
            selectedDate: selectedDate,
            onDaySelected: (selectedDay, focusedDay) =>
                onDaySelected(selectedDay, focusedDay, context),
          ),
          SizedBox(height: 8.0),
          TodayBanner(selectedDate: selectedDate, count: 0),
          Expanded(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];

                return Dismissible(
                  key: ObjectKey(schedule.id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (DismissDirection direction) {
                    provider.deleteSchedule(
                      date: selectedDate,
                      id: schedule.id,
                    );
                  },
                  child: ScheduleCard(
                    startTime: schedule.startTime,
                    endTime: schedule.endTime,
                    content: schedule.content,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onDaySelected(
    DateTime selectedDate,
    DateTime focuseDate,
    BuildContext context,
  ) {
    final provider = context.read<ScheduleProvider>();
    provider.changeSelectedDate(date: selectedDate);

    provider.getSchedules(date: selectedDate);
  }
}

// DB 를 이용한 상태 관리 코드..
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   //캘린더에서 비교한 날짜값에 따라서 랜더링 변경되어야 함.
//   //떄문에 상태 데이터로 현재 시간값을 설정하도록 하고, 이 객체를 파라미터로 넘김..
//   DateTime selectedDate = DateTime.utc(
//     DateTime.now().year,
//     DateTime.now().month,
//     DateTime.now().day,
//   );

//   @override
//   Widget build(BuildContext context) {
//     //스카폴드를 선언하고, 컬럼배치를 이용해서 MainCalendar 를 배치하고 실행해보세요.
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           //아래서 위로 새로운 앱이 오픈되도록 하는 위젯을 사용합니다.
//           showModalBottomSheet(
//             context: context,
//             builder: (_) => ScheduleBottomSheet(selectedDate: selectedDate),
//             //스크롤을 가능하도록 설정함.
//             isScrollControlled: true,
//             isDismissible: true,
//           );
//         },
//         backgroundColor: PRIMARY_COLOR,
//         child: Icon(Icons.add),
//       ),
//       body: Column(
//         children: [
//           MainCalendar(
//             selectedDate: selectedDate,
//             onDaySelected: onDaySelected,
//           ),
//           SizedBox(height: 8.0),

//           StreamBuilder<List<Schedule>>(
//             stream: GetIt.I<LocalDataBase>().watchSchedules(selectedDate),
//             builder: (context, snapshot) {
//               return TodayBanner(
//                 selectedDate: selectedDate,
//                 count: snapshot.data?.length ?? 0,
//               );
//             },
//           ),
//           SizedBox(height: 8.0),
//           Expanded(
//             child: StreamBuilder(
//               stream: GetIt.I<LocalDataBase>().watchSchedules(selectedDate),
//               builder: (context, snapshot) {
//                 //print(snapshot);
//                 //정보가 없으면 빈 컨테이너
//                 if (!snapshot.hasData) {
//                   return Text('데이터 없음');
//                 }
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final schedule = snapshot.data![index];

//                     //각 item 별로 밀어서 삭제 하도록 기능 정의 합니다.
//                     //Dismmisible 위젯을 이용함..
//                     return Dismissible(
//                       key: ObjectKey(schedule.id),
//                       direction: DismissDirection.startToEnd,
//                       onDismissed: (DismissDirection direction) {
//                         GetIt.I<LocalDataBase>().removeSchdule(schedule.id);
//                       },
//                       child: ScheduleCard(
//                         startTime: schedule.start,
//                         endTime: schedule.end,
//                         content: schedule.content,
//                       ),
//                     );
//                   },
//                 );
//               },
//             ), //일정 정보가 Stream 으로 제공되도록 우리가 정의 했음...때문에 이를 구현하는 Builder 로 구현합니다.context
//           ),
//         ],
//       ),
//     );
//   }

//   void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
//     setState(() {
//       this.selectedDate = selectedDate;
//     });
//   }
// }
