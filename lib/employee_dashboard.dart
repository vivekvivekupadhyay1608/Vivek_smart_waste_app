import 'package:flutter/material.dart';

// employee_screens फोल्डर के अंदर से सही इम्पोर्ट्स
import 'employee_screens/employee_reports_page.dart';
import 'employee_screens/employee_route_page.dart';
import 'employee_screens/employee_stats_page.dart';
import 'employee_screens/employee_profile_page.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _currentIndex = 0;

  // ग्लोबल डार्क मोड स्टेट जो एम्प्लॉय डैशबोर्ड के सभी पेजों को कंट्रोल करेगी
  bool _isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // चारों मॉड्यूलर पेजों की लिस्ट
    final List<Widget> pages = [
      EmployeeReportsPage(isDarkMode: _isDarkMode),
      EmployeeRoutePage(isDarkMode: _isDarkMode),
      EmployeeStatsPage(isDarkMode: _isDarkMode),
      EmployeeProfilePage(isDarkMode: _isDarkMode, onThemeChanged: _toggleTheme),
    ];

    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            "EcoTrack Employee",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF2E7D32), // कर्मचारियों के लिए म्युनिसिपल ग्रीन थीम
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_active, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No new operational alerts")),
                );
              },
            ),
          ],
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF2E7D32),
          unselectedItemColor: Colors.grey,
          backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "Reports",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigation),
              label: "Route",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "Stats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}