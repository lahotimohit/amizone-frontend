import 'package:amizone_frontend/dashboard/widgets/calendar.dart';
import 'package:amizone_frontend/dashboard/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class AmizoneDashboard extends StatefulWidget {
  const AmizoneDashboard({super.key});

  @override
  State<AmizoneDashboard> createState() => _AmizoneDashboardState();
}

class _AmizoneDashboardState extends State<AmizoneDashboard> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomMenuBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: const Color(0xFF003B70),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 255, 183, 2),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF003B70),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () {
                              scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/amizone-logo-front.png',
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      children: [
                        Text(
                          'Amity University Rajasthan, Jaipur',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        _buildActionButton(Icons.notifications,
                            const Color.fromARGB(255, 103, 103, 103))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(Icons.book, Colors.purple),
                        _buildActionButton(Icons.settings, Colors.green),
                        _buildActionButton(Icons.calendar_today, Colors.red),
                        _buildActionButton(
                            Icons.person_2, const Color(0xFF003B70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(16),
                    color: const Color.fromARGB(255, 65, 219, 188),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attendance',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 140,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: 75,
                                    color: Colors.green,
                                    radius: 30,
                                    title: '6',
                                    titleStyle: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  PieChartSectionData(
                                    value: 25,
                                    color: Colors.amber,
                                    radius: 30,
                                    title: '2',
                                    titleStyle: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                ],
                                centerSpaceRadius:
                                    40, // Creates the inner donut space
                                sectionsSpace: 4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              _buildLegendItem('Above 85%', Colors.green),
                              const SizedBox(width: 16),
                              _buildLegendItem('75% to 85%', Colors.yellow),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: const Color.fromARGB(255, 255, 100, 127),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fee Due 1000.00',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow[100],
                                ),
                                child: const Text(
                                  'Pay Now',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildFeeItem('Due date : 23/12/2024'),
                          _buildFeeItem(
                              'Late Fee Rs.100/- per day upto 02/01/2025'),
                          _buildFeeItem('Late Fee Rs.7500/- upto 22/01/2025'),
                          _buildFeeItem('Late Fee Rs.15000/- from 23/01/2025'),
                        ],
                      ),
                    ),
                  ),
                  // Advertisement Card
                  Card(
                    margin: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/genleap.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // Webinar Card
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: const Color.fromARGB(255, 255, 191, 97),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              'Online Guest Lectures /\nAcademic & Research\nWebinars',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text("Click Here")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                          minHeight: 400),
                      child: const ClassScheduleScreen()),
                  const SizedBox(
                    height: 30,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        elevation: 4,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.white60,
                                width: double.infinity,
                                child: Text(
                                  "Amity Central Library(OPAC)",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person_2_rounded,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                      Text(
                                        "User-id: ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "9581858",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.key,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                      Text(
                                        "Password: ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "Show",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12, color: Colors.blue),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "EBSCO Online: Business Journal : ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 10, color: Colors.blue),
                                  ),
                                  Text(
                                    "2,300 journals,\n more than 1,100\n peer-reviewd",
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    maxLines: 5,
                                    style: GoogleFonts.poppins(fontSize: 10),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.blue)),
                                      onPressed: () {},
                                      child: const Text(
                                        "eLibrary",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.blue)),
                                      onPressed: () {},
                                      child: const Text(
                                        "Read more",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget _buildFeeItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
