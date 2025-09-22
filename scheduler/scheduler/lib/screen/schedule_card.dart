import 'package:flutter/material.dart';
import 'package:scheduler/const/colors.dart';

//아래의 두 위젯을 배치하여 하나의 위젯으로 합치는 작업 합니다.
class ScheduleCard extends StatelessWidget {
  //파라미터로 보낼 변수 선언.
  final int startTime;
  final int endTime;
  final String content;

  const ScheduleCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    //내부 위젯의 높이를 최대 높이로 설정 하는 위젯으로 감싸기
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PRIMARY_COLOR, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              _Time(startTime: startTime, endTime: endTime),
              SizedBox(width: 16.0),
              _Content(content: content),
              SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(content));
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  const _Time({required this.startTime, required this.endTime, super.key});

  @override
  Widget build(BuildContext context) {
    //이 위젯에서만 사용한 스타일은 이 내부에 정의..
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 16.0,
    );

    return Column(
      children: [
        Text('${startTime.toString().padLeft(2, '0')}:00', style: textStyle),
        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
          style: textStyle.copyWith(fontSize: 10.0),
        ),
      ],
    );
  }
}
