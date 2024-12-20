import 'package:amizone_frontend/wifi/wifi_screen.dart';
import 'package:flutter/material.dart';

class CustomMenuBar extends StatelessWidget {
  const CustomMenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
                color: const Color.fromARGB(255, 255, 183, 2),
                width: double.infinity,
                child: Image.asset(
                  "assets/images/amizone-logo-front.png",
                  height: 70,
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MenuListTile(
                      icon: Icons.home,
                      title: 'Home',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    MenuListTile(
                      icon: Icons.calendar_today,
                      title: 'My Calendar',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    MenuListTile(
                      icon: Icons.book,
                      title: 'My Courses',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    MenuListTile(
                      icon: Icons.app_registration,
                      title: 'Registration',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    MenuListTile(
                      icon: Icons.schedule,
                      title: 'Time Table',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    MenuListTile(
                      icon: Icons.people,
                      title: 'My Faculty',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    MenuListTile(
                      icon: Icons.assignment,
                      title: 'Examination',
                      hasSubmenu: true,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const MenuListTile(
                      icon: Icons.work,
                      title: 'ATPC Placement',
                      hasSubmenu: true,
                      backgroundColor: Color.fromARGB(255, 249, 199, 72),
                    ),
                    const MenuListTile(
                      icon: Icons.work,
                      title: 'CRC Placement',
                      hasSubmenu: true,
                      backgroundColor: Color.fromARGB(255, 249, 199, 72),
                    ),
                    const MenuListTile(
                        icon: Icons.description,
                        title: 'Student Document',
                        hasSubmenu: true),
                    const MenuListTile(
                        icon: Icons.payment, title: 'Fee Details'),
                    const MenuListTile(icon: Icons.dashboard, title: 'IAD'),
                    const MenuListTile(
                        icon: Icons.feedback, title: 'Suggestion Box'),
                    const MenuListTile(
                        icon: Icons.public, title: 'The Global Times'),
                    const MenuListTile(
                        icon: Icons.pause_presentation, title: 'NTCC'),
                    MenuListTile(
                        icon: Icons.wifi,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => WifiScreen()));
                        },
                        title: 'Register for Wifi'),
                    const MenuListTile(
                        icon: Icons.report, title: 'Research Repository'),
                    const MenuListTile(
                        icon: Icons.hotel_sharp, title: 'Hostel'),
                    const MenuListTile(icon: Icons.payment, title: 'ASAP'),
                    const MenuListTile(icon: Icons.dashboard, title: 'SAP'),
                    const MenuListTile(
                        icon: Icons.feedback, title: 'Apply for Transcript'),
                    const MenuListTile(
                        icon: Icons.outbond, title: 'Withdrawal'),
                    const MenuListTile(icon: Icons.logout, title: 'Logout'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Updated MenuListTile to include onTap callback
class MenuListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool hasSubmenu;
  final bool isSelected;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const MenuListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.hasSubmenu = false,
    this.isSelected = false,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF003B70) : Colors.grey[600],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF003B70) : Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: hasSubmenu
            ? Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey[600],
              )
            : null,
        selected: isSelected,
        onTap: onTap,
      ),
    );
  }
}
