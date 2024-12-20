import 'package:flutter/material.dart';

class ClassSchedule {
  final String subject;
  final String teacher;
  final String teacherId;
  final String location;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  ClassSchedule({
    required this.subject,
    required this.teacher,
    required this.teacherId,
    required this.location,
    required this.startTime,
    required this.endTime,
  });
}
