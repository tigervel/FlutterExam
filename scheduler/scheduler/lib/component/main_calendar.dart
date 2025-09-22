import 'package:flutter/material.dart';
import 'package:scheduler/const/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  //타입def 로 날짜 선택시 실행 할 함수 선언함.
  //선택된 날짜도 같은 개념으로 정의 해야함.

  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({required this.onDaySelected, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_kr',
      //typedef 로 선언된 날짜 선택시 수행할 함수 설정함.
      onDaySelected: onDaySelected,

      //선택된 날짜를 구분할 로직을 작성해야함..
      //이때 사용하는 속성이 selectedDayP......임..
      //간단하게 구현되는 방식만 말하자면, 날짜를 선택하면, 전체 날짜를 다 가져와서,
      //선택된 날짜가 현재 날짜와 같은지를 검사해서, 같은 날짜값을 반환하도록 내부적으로 로직이 짜여있음.
      //위 로직을 구현함 typedef 속성을 구현만 하면됨.
      selectedDayPredicate: (date) =>
          date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day,

      focusedDay: DateTime.now(),
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(3000, 1, 1),

      //달력의 최상단 스타일링
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
      ),
      calendarStyle: CalendarStyle(
        defaultDecoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(6.0),
          color: LIGHT_GREY_COLOR,
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          //borderRadius: BorderRadius.circular(6.0),
          color: LIGHT_GREY_COLOR,
        ),
        selectedDecoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: PRIMARY_COLOR, width: 1.0),
        ),
        defaultTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        weekendTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        selectedTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
