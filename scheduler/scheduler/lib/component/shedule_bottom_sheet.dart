//이 페이지에서는 bottom sheet 의 구성품(widget)을 담아내는 모체로 사용됩니다.

//safearea 하위에 컨테이너를 구성하도록 만들어 보세요..컬러는 white 로 구성해보세요.
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:scheduler/component/custom_text_field.dart';
import 'package:scheduler/const/colors.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduler/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  const ScheduleBottomSheet({super.key, required this.selectedDate});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  int? startTime; //시작시간 저장변수
  int? endTime; //종료 시간 저장변수
  String? content; //일정 내용 저장 변수.

  //폼 키 생성..얘를 기준으론 validation 이 이루어짐..
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //키보드의 높이를 가져오는 로직 작성
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      key: formKey,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: '시작 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          startTime = int.parse(val!);
                        },
                        validator: timeValidator, //내부 함수로 구현 할 예정임.
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: CustomTextField(
                        label: '종료 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          endTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),

                Expanded(
                  child: CustomTextField(
                    label: '내용',
                    isTime: false,
                    onSaved: (String? val) {
                      content = val;
                    },
                    validator: contendValidator,
                  ),
                ),
                SizedBox(height: 8.0),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSavePressed,
                    child: Text('저장'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: PRIMARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //GetIt sl = GetIt.instance();
      await GetIt.I<LocalDataBase>().createSchedule(
        SchedulesCompanion(
          start: Value(startTime ?? 0),
          end: Value(endTime ?? 0),
          content: Value(content ?? ''),
          date: Value(widget.selectedDate),
        ),
      );
      Navigator.of(context).pop();
      // print(startTime);
      // print(endTime);
      // print(content);
    }
  }

  String? timeValidator(dynamic value) {
    if (value == null) {
      return '값 입력 해';
    }

    int? number;

    try {
      number = int.parse(value);
    } catch (e) {
      return '숫자만 입력해';
    }

    if (number < 0 || number > 24) {
      return '0 ~ 24 시 사이를 입력해';
    }
    return null;
  }

  String? contendValidator(dynamic? value) {
    if (value == null || value.length == 0) {
      return '일정을 입력해';
    }
    return null;
  }
}
