import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ScheduleType {
  @JsonValue('SCHEDULE')
  schedule(value: 'SCHEDULE'),
  @JsonValue('LECTURE')
  lecture(value: 'LECTURE');

  final String value;

  const ScheduleType({
    required this.value,
  });

  static ScheduleType fromValue(String value) {
    switch (value) {
      case 'SCHEDULE':
        return ScheduleType.schedule;
      case 'LECTURE':
        return ScheduleType.lecture;
      default:
        throw Exception('Invalid value');
    }
  }
}
