import 'package:flutter/material.dart';
import 'package:mamolist/memo/memo.dart';

void main() {
  runApp(MaterialApp(home:Memo(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  bool isActive = false;
  
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(title: Text('앱바'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isActive ? 'Active 상태' : 'InActive 상태',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20,),
            IconButton(onPressed: (){
              setState(() {
                isActive = !isActive;
              });
              if (isActive){
                print('음악 재생...');
              } else{
                print('음악 일시정지...');
              }
            }, icon: Icon(isActive? Icons.play_arrow : Icons.pause,size: 40,)),
            
          ],
        ),
      ),
    );
  }
}

