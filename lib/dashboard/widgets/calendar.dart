import 'package:amizone_frontend/dashboard/models/class_schedule.dart';
import 'package:amizone_frontend/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:amizone_frontend/dashboard/data/class_schedule.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});
  @override
  _ClassScheduleScreenState createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  DateTime selectedDate = DateTime.now();
  SecureStorage storage = SecureStorage();
  String day = "";

  void _changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            child: FutureBuilder<Map<int, List<ClassSchedule>>>(
              future: classSchedules(DateFormat('EEEE').format(selectedDate)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final scheduleMap = snapshot.data!;
                  final scheduleList = scheduleMap[selectedDate.weekday] ?? [];

                  return Column(
                    children: [
                      _buildHeader(context),
                      const Divider(color: Color.fromARGB(255, 214, 214, 214)),
                      _buildDateHeader(),
                      const Divider(color: Color.fromARGB(255, 214, 214, 214)),
                      scheduleList.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: scheduleList.length,
                                itemBuilder: (context, index) {
                                  final classInfo = scheduleList[index];
                                  return _buildClassTile(classInfo);
                                },
                              ),
                            )
                          : const Center(child: Text('No schedules available')),
                    ],
                  );
                } else {
                  return const Center(child: Text('No schedules available'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white60,
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: Text(
            'My Classes',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 38,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_left, color: Colors.blue, size: 38),
                onPressed: () => _changeDate(-1),
              ),
            ),
            SizedBox(
              width: 38,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_right, color: Colors.blue, size: 38),
                onPressed: () => _changeDate(1),
              ),
            ),
            SizedBox(
              width: 38,
              child: IconButton(
                icon: const Icon(Icons.calendar_month, color: Colors.blue),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    setState(() => selectedDate = picked);
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Text(
              DateFormat('MMMM d, yyyy').format(selectedDate),
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Text(
        DateFormat('EEEE').format(selectedDate),
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildClassTile(ClassSchedule classInfo) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  '${_formatTime(classInfo.start_time)}\n-\n${_formatTime(classInfo.end_time)}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 136, 155, 175),
                    height: 1.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                child: Container(
                  width: 12,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 86, 228, 90),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.menu_book,
                              size: 20, color: Colors.purple),
                        ),
                        Expanded(
                          child: Text(
                            classInfo.subject,
                            style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person_2,
                            size: 16, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(
                          classInfo.faculty,
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.red),
                        const SizedBox(width: 4),
                        Text(
                          classInfo.room_number,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
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
        const Divider(color: Color.fromARGB(255, 214, 214, 214)),
      ],
    );
  }
}
