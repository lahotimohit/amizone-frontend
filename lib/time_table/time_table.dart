import 'package:amizone_frontend/appbar/appbar.dart';
import 'package:amizone_frontend/dashboard/widgets/calendar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            universalAppBar(scaffoldKey),
            Text(
              "WEEKLY TIME SCHEDULE",
              style: GoogleFonts.poppins(color: Colors.blue, fontSize: 20),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: ClassScheduleScreen())
          ],
        ),
      ),
    );
  }
}
