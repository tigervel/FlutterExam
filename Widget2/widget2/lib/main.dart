import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  //Expanded 위젯.. 가장 많이 쓰이는 위젯중 하나이다. Col,Row 에서 애를 사용하면, 위젯이 나머지 공간을 모두 사용하는 특징을 가짐. 즉 최대한의 공간을 사용함
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(child: Container(color: Colors.lightBlue,)),
            Expanded(child: Container(color: Colors.red,))
          ],
        ),
      ),
    );
  }
}