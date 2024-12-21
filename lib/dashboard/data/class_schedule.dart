import 'dart:convert';
import 'package:amizone_frontend/dashboard/models/class_schedule.dart';
import 'package:amizone_frontend/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Map<int, List<ClassSchedule>>> classSchedules(String day) async {
  SecureStorage storage = SecureStorage();
  String enrollment = "";
  await storage.readData("enrollment").then((value) {
    enrollment = value.toString();
  });
  var timeTableUrl = Uri.parse(
      "https://amizone-backend-nane.vercel.app/tt/api/get-classes-by-day");
  var response = await http
      .post(timeTableUrl, body: {"day": day, "enrollment": enrollment});
  final Map<String, dynamic> responseData = jsonDecode(response.body);

  if (responseData['classes'].isNotEmpty) {
    return parseClassSchedule(responseData);
  }
  return {};
}

Future<Map<int, List<ClassSchedule>>> parseClassSchedule(
    dynamic response) async {
  if (response is Map<String, dynamic> && response.containsKey('classes')) {
    List<ClassSchedule> scheduleList =
        (response['classes'] as List<dynamic>).map<ClassSchedule>((item) {
      return ClassSchedule(
        subject: item['subject'] as String,
        faculty: item['faculty'] as String,
        start_time: parseTime(item['start_time'] as String),
        end_time: parseTime(item['end_time'] as String),
        room_number: item['room_number'] as String,
      );
    }).toList();

    final dayMapping = {
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday,
      'Sunday': DateTime.sunday,
    };

    final dayKey = dayMapping[response['day']] ?? DateTime.monday;
    return {
      dayKey: scheduleList,
    };
  } else {
    throw FormatException('Invalid response format');
  }
}

TimeOfDay parseTime(String time) {
  final format = RegExp(r'(\d+):(\d+)\s([AP]M)');
  final match = format.firstMatch(time);
  if (match != null) {
    final hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final period = match.group(3)!;
    return TimeOfDay(
      hour: (period == 'PM' && hour != 12) ? hour + 12 : hour % 12,
      minute: minute,
    );
  }
  throw FormatException("Invalid time format: $time");
}
