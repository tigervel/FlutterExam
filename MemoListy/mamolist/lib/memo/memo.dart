import 'package:flutter/material.dart';

class Memo extends StatelessWidget{
  const Memo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MemoList(),
    );
  }

}
class MemoList extends StatefulWidget{
  const MemoList({super.key});

  @override
  State<MemoList> createState() =>_MemoListState();

}
class _MemoListState extends State<MemoList>{
  List<String> memos =[];
  void _addMemo(String memo){
    setState(() {
      memos.add(memo);
    });
  }
  void _deleteMemo(int index){
    setState(() {
      memos.removeAt(index);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 목록'),
      ),
      //내부의 List 를 대상으로 List 를 전개할때 builder 를 사용한다
      body: ListView.builder(
        itemCount: memos.length,
        itemBuilder:(context,index) {
          return Card(
            child: ListTile(
              title: Text(memos[index]),
              trailing: IconButton(onPressed: (){
                _deleteMemo(index);
              }, 
              icon: Icon(Icons.delete)),
            ),
          );
        },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          //이 버튼이 눌려지면, 메모를 추가 할 수 있도록 연결 할 예정입니다
          //그럴러면, 현재 앱 위에 새롭게 앱(class) 가 올라와야 합니다
          //이를 위해서 Navigator 의 라우트 기느을 이용할 예정 입니다.
          //이는 나중에 다시 강의
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMemoScreen(addMemo: _addMemo),
              )
            );
             
        },
        child: Icon(Icons.add),
        ),
    );
  }
}

class AddMemoScreen extends StatefulWidget {
  final Function(String) addMemo;

  AddMemoScreen({required this.addMemo});
  
  @override
  _AddMemoScreenState createState() => _AddMemoScreenState();
}
class _AddMemoScreenState extends State<AddMemoScreen>{

  //인풋요소의 제어 하기 위한 컨트롤러 생성.. 반드시 초기에 생성하고, dispose() 를 오버라이드 해서 해제 해줘야한다
  final TextEditingController _memoContorller = TextEditingController();

  @override
  void dispose(){
    _memoContorller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(title: Text('메모추가'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _memoContorller,
              decoration: InputDecoration(
                labelText: '메모'
              ),
            ),
            SizedBox(height: 16,),
            ElevatedButton(onPressed: (){
              //입력된 메모 값을 저장하는 로직을 작성해야한다
              String memo = _memoContorller.text;
              if(memo.isNotEmpty){
                widget.addMemo(memo);
                Navigator.pop(context);
              }
            },
             child: Text('저장'))
          ],
        ),
      ),
    );
  }

}