class Subject {
  final String subjectCode;
  final String subjectName;
  final String course;
  final int semester;
  final int credits;
  final String subjectType;
  final String description;
  final Attendance attendance;

  Subject({
    required this.subjectCode,
    required this.subjectName,
    required this.course,
    required this.semester,
    required this.credits,
    required this.subjectType,
    required this.description,
    required this.attendance,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectCode: json['subject_code'],
      subjectName: json['subject_name'],
      course: json['course'],
      semester: json['semester'],
      credits: json['credits'],
      subjectType: json['subject_type'],
      description: json['description'],
      attendance: Attendance.fromJson(json['attendance']),
    );
  }
}

class Attendance {
  final int present;
  final int absent;
  final int late;
  final int totalClasses;
  final double attendancePercentage;

  Attendance({
    required this.present,
    required this.absent,
    required this.late,
    required this.totalClasses,
    required this.attendancePercentage,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      present: json['present'],
      absent: json['absent'],
      late: json['late'],
      totalClasses: json['total_classes'],
      attendancePercentage: json['attendance_percentage'].toDouble(),
    );
  }
}
