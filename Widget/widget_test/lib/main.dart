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
        body: SizedBox(
          height: double.infinity, //반대축에서 이동할 공간을 제공하기 위해 높이를 최대한으로 설정하는 문법

          //row,col 자식들은 자식의 크기만큼만 공간을 사용한다
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            //flexible 위젯 : Row 나 Col 내부에 사용되는 위젯...자신의 크기만큼 최소한만 사용한다 ..만약 매개변수를 사용하면 비율만큼 공간을 사용하도록 설정할 수 있음
              children: [
                Flexible(
                  flex: 1,
                  child: Container( color: Colors.red,)),
                Flexible(
                  flex: 1,
                  child: Container( color: const Color.fromARGB(255, 46, 17, 212),)),
                   Flexible(
                  flex: 4,
                  child: Container( color: const Color.fromARGB(255, 1, 1, 1),))
              // Container(
              //   height: 50.0,
              //   width: 50.0,
              //   color: Colors.red,
              // ),
              // SizedBox(width: 12.0,),
              // Container(
              //   height: 50.0,
              //   width: 50.0,
              //   color: const Color.fromARGB(255, 73, 179, 51),
              // ),
              // SizedBox(width: 12.0,),
              // Container(
              //   height: 50.0,
              //   width: 50.0,
              //   color: const Color.fromARGB(255, 100, 29, 193),
              // ),
              // SizedBox(width: 12.0,)
            ],
           )
           //Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Container(
          //       height: 50.0,
          //       width: 50.0,
          //       color: Colors.red,
          //     ),
          //     SizedBox(width: 12.0,),
          //     Container(
          //       height: 50.0,
          //       width: 50.0,
          //       color: const Color.fromARGB(255, 73, 179, 51),
          //     ),
          //     SizedBox(width: 12.0,),
          //     Container(
          //       height: 50.0,
          //       width: 50.0,
          //       color: const Color.fromARGB(255, 100, 29, 193),
          //     ),
          //     SizedBox(width: 12.0,)
          //   ],
          // ),
        ),
        // body: Center(
        //   child: SafeArea(
        //     bottom: true,
        //     top: true,
        //     left: true,
        //     right: true,
            
        //     child: Container(
        //       color: Colors.blueAccent,
        //       height: 250.0,
        //       width: 300.0,
          //),
           //),
        //),
      ),
    );
  }

}

