import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scheduler/const/colors.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int count;

  const TodayBanner({
    super.key,
    required this.selectedDate,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontSize: 16.0,
    );

    return Container(
      color: PRIMARY_COLOR,

      child: Row(
        children: [
          Text(
            '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
            style: textStyle,
          ),
          Text('${count} 개', style: textStyle),
        ],
      ),
    );
  }
}
