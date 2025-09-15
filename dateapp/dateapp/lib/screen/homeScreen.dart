import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScrren extends StatefulWidget {
  const HomeScrren({super.key});

  @override
  State<HomeScrren> createState() => _HomeScrrenState();
}

class _HomeScrrenState extends State<HomeScrren> {
  DateTime firstDay = DateTime.now();
  void onHeartPressed() {
    //print('클릭됬다');
    // setState(() {
    //   _firstDay=_firstDay.subtract(Duration(days:1));
    // });
    //쿠퍼티노 디자인 요소를 랜더링 할 때는 show쿠퍼티노다이얼로 함수를 호출함..
    //내부에 어떤 요소를 build 할건지를 builder 속성값으로 정의함..
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  firstDay = date;

                });
              },
              mode: CupertinoDatePickerMode.date,
            ),
          ),
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(onHeartPressed: onHeartPressed, firstDay: firstDay),
            _CoupleImage(),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 149, 182),
    );
  }
}

//날짜와 이미지를 반반으로 하도록 각 클래스에서 해당 컨텐트를 정의 합니다.
//이 둘을 위에서 합치는 겁니다.

class _DDay extends StatelessWidget {
  //제스쳐 콜백 함수를 객체가 생성될때 받도록 설정합니다. 반드시 넘겨주도록 named 로 설정
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  _DDay({required this.onHeartPressed, required this.firstDay});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    return Column(
      children: [
        SizedBox(height: 16.0),
        Text('데이트 카운터 앱', style: textTheme.displayLarge),
        SizedBox(height: 16.0),
        Text('처음 만난 날', style: textTheme.bodyLarge),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyMedium,
        ),
        SizedBox(height: 16.0),
        IconButton(
          onPressed: onHeartPressed,
          icon: Icon(Icons.favorite, color: Colors.red),
        ),
        SizedBox(height: 16.0),
        //동적 데이터용 Text 임의 설정
        Text(
          'D-Day + ${DateTime(now.year, now.month, now.day).difference(firstDay).inDays}',
          style: textTheme.displayLarge,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          'asset/img/middle_image.png',
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
