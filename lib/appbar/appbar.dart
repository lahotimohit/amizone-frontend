import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget UniversalAppBar(GlobalKey<ScaffoldState> scaffoldKey) {
  return Container(
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
                _buildActionButton(Icons.person_2, const Color(0xFF003B70)),
              ],
            ),
          ),
        ],
      ),
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
