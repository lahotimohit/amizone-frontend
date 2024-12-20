import 'package:amizone_frontend/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amizone_frontend/subjects/models/subjects.dart';

class CourseResponse {
  final String status;
  final String studentName;
  final String enrollment;
  final String course;
  final int semester;
  final List<Subject> studentSubjects;

  CourseResponse({
    required this.status,
    required this.studentName,
    required this.enrollment,
    required this.course,
    required this.semester,
    required this.studentSubjects,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      status: json['status'],
      studentName: json['student_name'],
      enrollment: json['enrollment'],
      course: json['course'],
      semester: json['semester'],
      studentSubjects: (json['student_subjects'] as List)
          .map((e) => Subject.fromJson(e))
          .toList(),
    );
  }
}

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  late Future<CourseResponse> _coursesFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future in initState
    _coursesFuture = fetchCourses();
  }

  Future<CourseResponse> fetchCourses() async {
    // Simulated API call - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return CourseResponse.fromJson({
      "status": "success",
      "student_name": "Mohit Lahoti",
      "enrollment": "A20405221143",
      "course": "B.TECH (CSE)",
      "semester": 7,
      "student_subjects": [
        {
          "subject_code": "BCS702",
          "subject_name": "Artificial Intelligence",
          "course": "B.TECH (CSE)",
          "semester": 7,
          "credits": 4,
          "subject_type": "Compulsory",
          "description": "",
          "attendance": {
            "present": 35,
            "absent": 5,
            "late": 0,
            "total_classes": 40,
            "attendance_percentage": 87.50
          }
        },
        {
          "subject_code": "BCS703",
          "subject_name": "Information & Storage Management",
          "course": "B.TECH (CSE)",
          "semester": 7,
          "credits": 4,
          "subject_type": "Compulsory",
          "description": "",
          "attendance": {
            "present": 35,
            "absent": 8,
            "late": 0,
            "total_classes": 43,
            "attendance_percentage": 84.50
          }
        },
      ]
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            universalAppBar(scaffoldKey),
            Text(
              "My Courses",
              style: GoogleFonts.poppins(color: Colors.blue, fontSize: 20),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(border: Border.all()),
              child: FutureBuilder<CourseResponse>(
                future: _coursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  }

                  final data = snapshot.data!;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.grey[100],
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Semester',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: DropdownButton<int>(
                                  value: data.semester,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  items: [
                                    for (int i = 1; i <= 8; i++)
                                      DropdownMenuItem(
                                        value: i,
                                        child: Text('$i'),
                                      )
                                  ],
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.studentSubjects.length,
                          itemBuilder: (context, index) {
                            final subject = data.studentSubjects[index];
                            return Card(
                              color: Colors.white,
                              margin: const EdgeInsets.all(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(
                                        'Course Code', subject.subjectCode),
                                    _buildInfoRow(
                                        'Course Name', subject.subjectName),
                                    _buildInfoRow('Type', subject.subjectType),
                                    _buildSyllabusRow(),
                                    _buildSessionPlanRow(),
                                    _buildAttendanceRow(subject.attendance),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(color: Colors.black87, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyllabusRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              'Course Syllabus',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.black54),
            onPressed: () {
              // Handle syllabus download
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSessionPlanRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              'Session Plans',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.visibility),
              label: const Text('View'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Handle view session plans
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceRow(Attendance attendance) {
    final attendanceText =
        '${attendance.present}/${attendance.totalClasses} (${attendance.attendancePercentage.toStringAsFixed(2)}%)';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              'Attendance',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.visibility, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    attendanceText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}