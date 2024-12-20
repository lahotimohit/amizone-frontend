import 'package:amizone_frontend/dashboard/models/class_schedule.dart';
import 'package:flutter/material.dart';

Map<int, List<ClassSchedule>> classSchedules = {
  DateTime.wednesday: [
    ClassSchedule(
      subject: 'FLT701 French',
      teacher: 'Dr Deepak Sharma',
      teacherId: '314294',
      location: 'LT-12-B',
      startTime: TimeOfDay(hour: 9, minute: 15),
      endTime: TimeOfDay(hour: 10, minute: 10),
    ),
    ClassSchedule(
      subject: 'BCS701 Communication Skills',
      teacher: 'Mr Bashar Akhtar',
      teacherId: '312630',
      location: 'LT-12-B',
      startTime: TimeOfDay(hour: 10, minute: 15),
      endTime: TimeOfDay(hour: 11, minute: 10),
    ),
    // Add more classes as needed
  ],
};
