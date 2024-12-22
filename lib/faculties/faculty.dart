import 'dart:convert';

import 'package:amizone_frontend/api/endpoints.dart';
import 'package:amizone_frontend/appbar/appbar.dart';
import 'package:amizone_frontend/faculties/models/facult_model.dart';
import 'package:amizone_frontend/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                  maxHeight: MediaQuery.of(context).size.height * 0.72),
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
    SecureStorage storage = SecureStorage();
    String enrollment = "";
    await storage.readData("enrollment").then((value) {
      enrollment = value.toString();
    });
    var getFacultyUrl = Uri.parse(getAllFaculties);
    var response =
        await http.post(getFacultyUrl, body: {"enrollment": enrollment});
    return FacultyResponse.fromJson(jsonDecode(response.body));
  }
}

class SubjectCard extends StatefulWidget {
  final Subject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  State<SubjectCard> createState() => _SubjectCardState();
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
                      '${widget.subject.subjectName}[${widget.subject.subjectCode}]',
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
