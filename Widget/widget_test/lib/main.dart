import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//무상태(Stateless) 란, 한번 랜더링된 이후 절대 재 랜더링이 되지 않는 특성을 가진 위젯을 뜻함
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('앱바 타이틀'),
        ),
        body: Center(
          child: SafeArea(
            bottom: true,
            top: true,
            left: true,
            right: true,
            
            child: Container(
              color: Colors.blueAccent,
              height: 250.0,
              width: 300.0,
          ), ),
        ),
      ),
    );
  }

}

