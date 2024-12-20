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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SizedBox(
                          width: 38,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_left,
                              color: Colors.blue,
                              size: 38,
                            ),
                            onPressed: () => _changeDate(-1),
                          ),
                        ),
                        SizedBox(
                          width: 38,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_right,
                              color: Colors.blue,
                              size: 38,
                            ),
                            onPressed: () => _changeDate(1),
                          ),
                        ),
                        SizedBox(
                          width: 38,
                          child: IconButton(
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.blue,
                            ),
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
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Color.fromARGB(255, 214, 214, 214),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          DateFormat('EEEE').format(selectedDate),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 214, 214, 214),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            classSchedules[selectedDate.weekday]?.length ?? 0,
                        itemBuilder: (context, index) {
                          final classInfo =
                              classSchedules[selectedDate.weekday]![index];
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Time Column
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        '${_formatTime(classInfo.startTime)}\n-\n${_formatTime(classInfo.endTime)}',
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 136, 155, 175),
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    // Status dot
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, right: 8.0),
                                      child: Container(
                                        width: 12,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 86, 228, 90),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    // Class details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
                                                child: Icon(
                                                  Icons.menu_book,
                                                  size: 20,
                                                  color: Colors.purple,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  classInfo.subject,
                                                  style: const TextStyle(
                                                    color: Colors.purple,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
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
                                                '${classInfo.teacher}[${classInfo.teacherId}]',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.blue,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                classInfo.location,
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
                              const Divider(
                                color: Color.fromARGB(255, 214, 214, 214),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
