import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//Stack 위젯 : 배치 위젯의 일종..내부에 자식을 지정한 Stack 위치에 배치 하도록 설정함. 각 stack 은 내부에서 위치삾을 지정할 수있음

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              //Image.asset('images/app_icon_128.png'),
              Image(
                image: AssetImage('images/app_icon_128.png'),
                width: 200,
                height: 200,
              ),
              Text(
                'Welcome Flutter',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('버튼')),
              SizedBox(height: 10, width: 10),
              ElevatedButton(onPressed: () {}, child: Text('버튼')),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Text('Item1'),
              SizedBox(height: 10, width: 10),
              Text('Item2'),
              SizedBox(height: 10, width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
