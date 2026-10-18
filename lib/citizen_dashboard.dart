import 'package:flutter/material.dart';

// सिटीजन के चारों मॉड्यूलर पेजों का सही इम्पोर्ट
import 'citizen_screens/report_waste_page.dart';
import 'citizen_screens/track_truck_page.dart';
import 'citizen_screens/reports_page.dart';
import 'citizen_screens/profile_page.dart';

class CitizenDashboard extends StatefulWidget {
  const CitizenDashboard({super.key});

  @override
  State<CitizenDashboard> createState() => _CitizenDashboardState();
}

class _CitizenDashboardState extends State<CitizenDashboard> {
  int _currentIndex = 0;

  // ग्लोबल डार्क मोड स्टेट जो पूरी ऐप और चारों पेजों को एक साथ कंट्रोल करेगी
  bool _isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // चारों पेजों की लिस्ट, जिसमें ProfilePage को डार्क मोड और थीम टॉगल का फंक्शन पास किया गया है
    final List<Widget> pages = [
      const ReportWastePage(),
      const TrackTruckPage(),
      const ReportsPage(),
      ProfilePage(isDarkMode: _isDarkMode, onThemeChanged: _toggleTheme),
    ];

    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            "EcoTrack Citizen",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF1976D2),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_active, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No new notifications")),
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
          selectedItemColor: const Color(0xFF1976D2),
          unselectedItemColor: Colors.grey,
          backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: "Report",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping),
              label: "Track Truck",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "Reports",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}