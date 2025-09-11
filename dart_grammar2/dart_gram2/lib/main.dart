import 'package:flutter/material.dart';
//머터리얼 기능과 관련된 파일을 import 
//이걸 import 해야만 기본 위젯을 사용할 수 있음.

//중요한 위젯 몇가지
// 1. Container : 자식을 담는 위젯 ... 배경, 너비, 높이 등을 디자인 가능하다
// 2. GestureDetector : 제스처를 기능을 자식 위젯에서 인식하는 대표적 위젯,
// 탭, 드래그, DB Click 등의 제스처 기능을 자식 위젯에서 인식하게 됬을때 콜백을 수정하도록 정의됨
// 3. SizedBox : 대표적인 마진을 적용시키는 위젯
// 4. 배치위젯 : 컬럼(세로배치), ROW(가로배치)
// 5. 그룹 위젯 : ListView 위젯.. 리스트 처럼 위젯들을 나열할 때 사용되는 위젯..

// 여기서 잠깐... children 과 child 의 차이점 단일과 복수


void addNumber(int n1,int n2) async{
  print('${n1} + ${n2} 시작');

//await 은 대기하고 싶은 비동기 함수 앞에 입력함
  await Future.delayed(Duration(seconds: 3),(){
    print('${n1 + n2}');
  });
}

void main() {
  //Dart 비동기 통신 : Future<type> : 이 클래스는 비동기 통신을 처리하기 위한 객체이다

  // addNumber(1, 2);
  // addNumber(3, 4);
  // addNumber(5, 6);



  //FloatingActionButton 이라는 위젯이 있다 이 위젯이 적용돌수 있는 위젯을 찾아보고, 클릭이라는
  //text 를 가진 위 버튼을 생성해보기 이벤트 핸들링은 옵션
  runApp(

    MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          
        },
        child: Text('텍스트버튼'),),

        body: SizedBox(
          width: double.infinity,
       
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Full',style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                ),
              ),
              Text('Stack Fighing'),
              TextButton(onPressed: (){}, 
              child: Text('텍스트 버튼'),
              style: TextButton.styleFrom(foregroundColor: Colors.orange),
              ),
              IconButton(onPressed: (){}, 
              icon: Icon(Icons.home)),
              GestureDetector(
                onTap: (){
                  print('on tap');
                },
                onDoubleTap: (){
                  print('on double tap');
                },
                //길게눌렀을떄
                onLongPress: (){
                  print('길게 누르지마 무거워');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.red,
                    border: Border.all(
                      width: 150.0,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  width: 100.0,
                  height: 100.0,
                  
                ),
              )
            ],
          ),
        ),
       
      ),
    )
    
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
