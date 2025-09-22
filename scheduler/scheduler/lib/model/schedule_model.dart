import 'package:scheduler/database/drift_database.dart';

class ScheduleModel {
  final String id;
  final String content;
  final DateTime date;
  final int startTime;
  final int endTime;

  ScheduleModel({
    required this.id,
    required this.content,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  //JSon 으로 부터 모델을 생성하도록 생성자 정의
  ScheduleModel.fromJson({required Map<String, dynamic> json})
    : id = json['id'],
      content = json['content'],
      startTime = json['startTime'],
      endTime = json['endTime'],
      date = DateTime.parse(json['date']);

  //모델을 JSON 으로 변환해서 보낼수 있도록 정의
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'date':
          '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  ScheduleModel copuWith({
    String? id,
    String? content,
    DateTime? date,
    int? startTime,
    int? endTime,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      content: content ?? this.content,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
