import 'package:flutter/material.dart';

/*
상태관리(state) : 데이터에 따른 위젯이 리랜더링이 되려면 반드시 Statefull 위젯을 상속받아야함.
이렇게 상속을 받은후엔 setState 를 이용해서 데이터 변동에 따른 위젯을 재렌더링 하도록 함.

상태 관리 위젯은 내부적으로 상태(state)를 관리하는 클래스 타입 이어야 하는데, 이는 State 클래스를 상속 받아서 해결함.

ex> 상태불명 위젯 --> 상태위젯 --> 상태위젯 상속 위젯 이러한 순으로 앱을 구성함..
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '카운터 앱',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  bool _isCounterVisible = true;
  Color _counterColor = Colors.black;

  //이벤트 핸들러 메서드 정의
  void incrementCount() {
    setState(() {
      _counter++;
    });
  }

  void resetCount() {
    setState(() {
      _counter = 0;
    });
  }

  void toggleCounter() {
    setState(() {
      _isCounterVisible = !_isCounterVisible;
    });
  }

  void changeCounterColor() {
    setState(() {
      _counterColor = Colors.amberAccent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isCounterVisible)
              Text('Counter', style: TextStyle(fontSize: 24)),
            if (_isCounterVisible)
              Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _counterColor,
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: incrementCount, child: Text('카운터 증가')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: resetCount, child: Text('카운터 초기화')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleCounter,
              child: Text(_isCounterVisible ? 'Hide' : 'Show'),
            ),

            ElevatedButton(
              onPressed: changeCounterColor,
              child: Text('카운트 컬러 바꾸기'),
            ),
          ],
        ),
      ),
    );
  }
}
