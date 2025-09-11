import 'package:flutter/material.dart';

//Named 생성자.. 기존의 생성자외에 객체를 다양한 형태로 발생시킬수 있도록 정의 하는 형태를 말함..

class Idol{
  final String name;
  final int memberCount;
  Idol(this.name,this.memberCount);

  //네임드 생성자를 정의해서 이 생성자를 이용한 Idol을 생성하도록 해봅니다.
  Idol.forMap(Map<String,dynamic> map)
  : this.name = map['name'],
    this.memberCount=map['memberCount'];


  void sayName(){
    print('나는 ${this.name} 입니다 ${this.name} 멤버는 ${this.memberCount} 명 입니다.' );
  }
}

class MenuItem{
  String name;
  int price;

  MenuItem(this.name , this.price);
}

class Cafe{
  late List<MenuItem> menu;

  Cafe(){
    menu = [
      MenuItem('어메리카노', 10),
      MenuItem('콜드브루', 15),
    ];
  }

  //메뉴를 보여주는 메서드 정의
  void dpMenu(){
    //리스트를 순회해서  아아: 2000원
    for(MenuItem m in menu){
      print('${m.name}:${m.price}원')
;    }
  }
  
}

class User {
  String name;
  int age;
  User({required this.name,required this.age});
}


void main() {
  //Dart 언어 ... 자바의 언어와 매우 유사하다 
  //데이터 타입(객체는 당연하고 , P type 은 bool , int, double 만 존재한다)
  Cafe().dpMenu();
  var my = User(name:'덕호',age:32);
  var aespa = Idol('에스파', 4);
  var bts = Idol.forMap({'name':'BTS','memberCount':7});
  bts.sayName();
  aespa.sayName();
  int a = 1;
  double d = 1.0;
  bool flag = false;

  print(a);

 // d = a as double;

  String name = 'tiger';

  print('${name.toString()}'); // $를 이용해서 변수의 값을 출력 시킬수 있다

  String str = '''이건 문자열을
  그대로 출력시키는 키워드 입니다
  이거,문자열''';
  print('$str');

  //Collection : List(Array), Set,Map 그대로 사용한다
  //List 는 배열식으로 표현되고, 나머지는 동일하다.
  //각각의 객체는 내부 Iterator 메서드와 set,getter 등이 있음...자바의 차이점은 메뉴얼을 확인 바란다

  //type 선언중에 dynamic 이란애는 말그대로 값이 타입에 맞도록 변경되도록 허용되는 애다
  List<dynamic> nums = [1, 2.0 ,'3'];

  //var 라는 키워드를 이용해서 변수 선언가능하다 이것은 추론타입이라고 해서, 값이 들어가는 시점에 타입을 지정해준다
  //반대로 int 로 선언해버리면, int 만 들어갈 수 있다
  var k = 10;

  dynamic j = 10;

  j = 'str';

  //nums에서 2를 제거한 list의 내용을 출력해보기
  nums.remove(2);
  print(nums);

  //생성자중에 Named 생성자가 있다
  //기본적으로 생성자는 클래스명과 같은 구조를 따라야 하는데, named 는 여기에 객체 생성을 좀더 다양하게 생성하게 만들어주는 문법이다
  //이름은 static 과 비슷한 형태로 구성되어 있으며 ..EX> Class.namedConstructor(props);

  List<dynamic> list2=List.from(nums);
  List<dynamic> list3=nums.toList();
  print(list2);
  print(list3);

  //좋아하는 과일 4개를 가진 favf 라는 리스트 생성하기
  List<dynamic> favf = ['키위','사과','배','수박'];

  for(dynamic d in favf){
    print(d);
  };

  favf.forEach((element) => print(element));
  favf.forEach((value){
    print(value);
  });

  Map<String , int> ml = {'a':1,'b':2};
  print(ml['a']);

  //시작점 ..진입점 ..app은 여기서 시작됨
  //runApp(const MyApp());
}

class YourApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '야스',
    color: Colors.amber,
    //home: SafeArea(child: Text(style: TextStyle(),)),
    );
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 226, 3, 155)),
      ),
      home: const MyHomePage(title: 'Hello World'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
