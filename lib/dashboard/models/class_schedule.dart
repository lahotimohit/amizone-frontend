import 'package:flutter/material.dart';

class ClassSchedule {
  final String subject;
  final String faculty;
  final TimeOfDay start_time;
  final TimeOfDay end_time;
  final String room_number;

  ClassSchedule({
    required this.subject,
    required this.faculty,
    required this.start_time,
    required this.end_time,
    required this.room_number,
  });
}
