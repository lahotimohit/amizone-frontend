class FacultyResponse {
  final String status;
  final FacultyData data;

  FacultyResponse({required this.status, required this.data});

  factory FacultyResponse.fromJson(Map<String, dynamic> json) {
    return FacultyResponse(
      status: json['status'],
      data: FacultyData.fromJson(json['data']),
    );
  }
}

class FacultyData {
  final String studentName;
  final String course;
  final int semester;
  final List<Subject> subjects;

  FacultyData({
    required this.studentName,
    required this.course,
    required this.semester,
    required this.subjects,
  });

  factory FacultyData.fromJson(Map<String, dynamic> json) {
    return FacultyData(
      studentName: json['student_name'],
      course: json['course'],
      semester: json['semester'],
      subjects:
          (json['subjects'] as List).map((e) => Subject.fromJson(e)).toList(),
    );
  }
}

class Subject {
  final String subjectCode;
  final String subjectName;
  final List<Faculty> faculty;

  Subject({
    required this.subjectCode,
    required this.subjectName,
    required this.faculty,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectCode: json['subject_code'],
      subjectName: json['subject_name'],
      faculty:
          (json['faculty'] as List).map((e) => Faculty.fromJson(e)).toList(),
    );
  }
}

class Faculty {
  final String name;
  final String profilePhoto;

  Faculty({required this.name, required this.profilePhoto});

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      name: json['name'],
      profilePhoto: json['profile_photo'],
    );
  }
}
