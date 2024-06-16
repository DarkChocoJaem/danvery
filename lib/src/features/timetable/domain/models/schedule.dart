import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'schedule_time.dart';
import 'schedule_type.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int id;
  final String name;
  final String professor;
  final String memo;
  final ScheduleType type;
  @JsonKey(fromJson: _parseColorFromJson, toJson: _parseColorToJson)
  final Color color;
  final List<ScheduleTime> times;

  Schedule({
    int? id,
    required this.name,
    this.professor = '',
    required this.type,
    required this.memo,
    required this.color,
    required this.times,
  }) : id = id ?? UniqueKey().hashCode;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

Color _parseColorFromJson(String color) => Color(int.parse(color));

String _parseColorToJson(Color color) => color.value.toString();
