import 'package:amizone_frontend/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WifiScreen extends StatelessWidget {
  WifiScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            universalAppBar(scaffoldKey),
            Text(
              "Register your wi-fi devices",
              style: GoogleFonts.poppins(fontSize: 24, color: Colors.blue),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Device 1",
                      style: GoogleFonts.poppins(),
                    ),
                    contentRow(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Device 2",
                      style: GoogleFonts.poppins(),
                    ),
                    contentRow(),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Registered",
                        style: GoogleFonts.poppins(
                            color: Colors.red, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Note Section
                    const Text(
                      'Note:-',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        children: [
                          TextSpan(
                            text: 'Once registered, the MAC IDs can\'t be ',
                          ),
                          TextSpan(
                            text: 'altered',
                            style: TextStyle(color: Colors.red),
                          ),
                          TextSpan(
                            text:
                                '. Please take enough care to input correct MAC ID of your devices.',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget contentRow() {
  return Row(
    children: [
      const Expanded(
          child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            hintText: '4E-43-8A-8F-B5-49',
            hintStyle: TextStyle(color: Colors.grey)),
      )),
      const SizedBox(
        width: 8,
      ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: const Text(
          'Delete',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}
