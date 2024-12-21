import 'package:amizone_frontend/appbar/appbar.dart';
import 'package:flutter/material.dart';

// Model classes
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

class FacultyListScreen extends StatelessWidget {
  const FacultyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            universalAppBar(scaffoldKey),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              child: FutureBuilder<FacultyResponse>(
                future: fetchFacultyData(),
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

                  return ListView.builder(
                    itemCount: snapshot.data!.data.subjects.length,
                    itemBuilder: (context, index) {
                      final subject = snapshot.data!.data.subjects[index];
                      return SubjectCard(subject: subject);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<FacultyResponse> fetchFacultyData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return FacultyResponse.fromJson({
      "status": "success",
      "data": {
        "student_name": "Mohit Lahoti",
        "course": "B.TECH (CSE)",
        "semester": 7,
        "subjects": [
          {
            "subject_code": "BCS702",
            "subject_name": "Artificial Intelligence",
            "faculty": [
              {
                "name": "Dr. Yashpal Singh",
                "profile_photo":
                    "https://cdn.pixabay.com/photo/2023/12/08/23/46/cat-8438334_1280.jpg"
              }
            ]
          },
          {
            "subject_code": "BCS703",
            "subject_name": "Artificial Intelligence Lab",
            "faculty": [
              {
                "name": "Dr. Yashpal Singh",
                "profile_photo":
                    "https://cdn.pixabay.com/photo/2023/12/08/23/46/cat-8438334_1280.jpg"
              }
            ]
          },
          // Add more subjects as needed
        ]
      }
    });
  }
}

class SubjectCard extends StatefulWidget {
  final Subject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  _SubjectCardState createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF003B70),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subject.subjectName.contains('Lab')
                            ? '[AI Lab]'
                            : '[AI]',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '[${widget.subject.subjectCode}]',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.orange,
                    child: Text(
                      '${widget.subject.subjectName} [${widget.subject.subjectName.contains('Lab') ? 'AI Lab' : 'AI'}] [${widget.subject.subjectCode}]',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Faculty details (expandable)
          if (isExpanded)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    for (var faculty in widget.subject.faculty)
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(faculty.profilePhoto),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    faculty.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton.icon(
                                          icon: const Icon(Icons.feedback),
                                          label: const Text('Feedback'),
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton.icon(
                                          icon: const Icon(Icons.message),
                                          label: const Text('Post Message'),
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
