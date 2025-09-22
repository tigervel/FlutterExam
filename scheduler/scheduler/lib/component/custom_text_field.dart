//여기에는 bottom sheet 에 들어가 텍스틀 필드를 구현합니다.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduler/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  //시간 영역을 선택 하는경우, 숫자키보드만 보이도록 변수를 선언함
  final bool isTime;

  //폼 저장과, 저장될 내용을 검증 하도록 설정함.
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    //컬럼위젯으로 텍스트필드를 자식으로 생성함..
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w400),
        ),
        Expanded(
          flex: isTime ? 0 : 1,
          child: TextFormField(
            onSaved: onSaved,
            validator: validator,
            cursorColor: Colors.grey,
            maxLines: isTime ? 1 : null, //1인 경우엔 한줄만입력 제한, 아닌경우엔 한줄이상 입력
            expands: !isTime, //공간을 최대한 차지 할지를 확인 하는 속성..시간관련은 최대한 차지하도록 설정,
            keyboardType: isTime
                ? TextInputType.number
                : TextInputType.multiline,
            //포맷설정..
            inputFormatters: isTime
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: TEXTFIELD_FILL_COLOR,
              suffixText: isTime ? '시' : null,
            ),
          ),
        ),
      ],
    );
  }
}
