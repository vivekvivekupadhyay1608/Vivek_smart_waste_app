import 'package:flutter/material.dart';
import 'login_page.dart';

class CitizenDashboard extends StatefulWidget {
  const CitizenDashboard({super.key});

  @override
  State<CitizenDashboard> createState() => _CitizenDashboardState();
}

class _CitizenDashboardState extends State<CitizenDashboard> {
int _selectedIndex = 0;
String _selectedTruckInfo = 'Ghaziabad Live Fleet: Tap any truck pin on the map';

void _openCameraAction() {
showDialog(
context: context,
builder: (context) => AlertDialog(
title: const Row(
children: [
Icon(Icons.camera_alt_rounded, color: Color(0xFF6366F1)),
SizedBox(width: 8),
Text('Smart Camera Portal', style: TextStyle(fontSize: 16)),
],
),
content: const Text('Camera integrated successfully! Click capture to snap the waste issue location and auto-upload GPS coordinates.'),
actions: [
TextButton(
onPressed: () => Navigator.pop(context),
child: const Text('Cancel'),
),
ElevatedButton(
style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1)),
onPressed: () {
Navigator.pop(context);
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('📸 Issue Captured & GPS Tagged Successfully!')),
);
},
child: const Text('Capture Photo', style: TextStyle(color: Colors.white)),
),
],
),
);
}

Widget _buildHomeView() {
return SingleChildScrollView(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
width: double.infinity,
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
borderRadius: BorderRadius.circular(16),
boxShadow: [
BoxShadow(
color: const Color(0xFF6366F1).withOpacity(0.3),
blurRadius: 8,
offset: const Offset(0, 4),
),
],
),
child: Row(
children: [
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: const [
Text(
'Welcome, Citizen! 👋',
style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
),
SizedBox(height: 6),
Text(
'Ghaziabad Municipal Zone. Track live waste collection trucks across sectors & blocks in real-time.',
style: TextStyle(color: Colors.white70, fontSize: 13),
),
],
),
),
const Icon(Icons.local_shipping_rounded, color: Colors.white, size: 40),
],
),
),
const SizedBox(height: 20),
const Text(
'Quick Services',
style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
),
const SizedBox(height: 12),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
_buildServiceCard(
icon: Icons.camera_alt_rounded,
label: 'Report Issue',
color: Colors.orange,
onTap: _openCameraAction,
),
_buildServiceCard(
icon: Icons.map_rounded,
label: 'Track Truck',
color: Colors.blue,
onTap: () {
setState(() { _selectedIndex = 1; });
},
),
_buildServiceCard(
icon: Icons.calendar_today_rounded,
label: 'Schedule',
color: Colors.purple,
onTap: () {
setState(() { _selectedIndex = 3; });
},
),
_buildServiceCard(
icon: Icons.feedback_rounded,
label: 'Feedback',
color: Colors.green,
onTap: () {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('💬 Feedback portal module active!')),
);
},
),
],
),
const SizedBox(height: 24),
const Text(
'Live GPS & Collection Status (Ghaziabad)',
style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
),
const SizedBox(height: 12),
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.9),
borderRadius: BorderRadius.circular(12),
border: Border.all(color: Colors.blue.shade100),
boxShadow: [
BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2)),
],
),
child: Column(
children: [
Row(
children: [
const Icon(Icons.gps_fixed_rounded, color: Color(0xFF6366F1), size: 22),
const SizedBox(width: 10),
const Expanded(
child: Text(
'Location: Raj Nagar Extension, Ghaziabad',
style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF334155)),
),
),
Container(
padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
decoration: BoxDecoration(
color: Colors.green.withOpacity(0.1),
borderRadius: BorderRadius.circular(6),
),
child: const Text(
'ACTIVE GPS',
style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
),
),
],
),
const Divider(height: 24),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: const [
Text('Assigned Truck:', style: TextStyle(color: Colors.grey, fontSize: 12)),
Text('Truck #GZB-101 (Block A)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
],
),
const SizedBox(height: 8),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: const [
Text('Estimated Arrival:', style: TextStyle(color: Colors.grey, fontSize: 12)),
Text('5 mins remaining', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF6366F1))),
],
),
],
),
),
],
),
);
}

// गाजियाबाद का लोकल एरिया मैप और उसके ऊपर 4 ट्रक्स की सटीक पोजीशन
Widget _buildGpsMapView() {
return Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text('Ghaziabad City Zone - Live Fleet Map', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
Container(
padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
child: const Text('4 Trucks Active', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
),
],
),
const SizedBox(height: 10),
// चयनित ट्रक की जानकारी दिखाने वाला बैनर
Container(
width: double.infinity,
padding: const EdgeInsets.all(10),
margin: const EdgeInsets.only(bottom: 10),
decoration: BoxDecoration(
color: const Color(0xFF6366F1).withOpacity(0.1),
borderRadius: BorderRadius.circular(8),
border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
),
child: Text(
_selectedTruckInfo,
style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF6366F1)),
),
),
Expanded(
child: Container(
width: double.infinity,
decoration: BoxDecoration(
color: Colors.blue.shade50,
borderRadius: BorderRadius.circular(16),
border: Border.all(color: Colors.blue.shade200),
// गाजियाबाद/लोकल अर्बन ग्रिड और रोड्स को दर्शाने वाला साफ़-सुथरा मैप पैटर्न
image: const DecorationImage(
image: NetworkImage('https://images.unsplash.com/photo-1569336415962-a4bd9f69cd83?auto=format&fit=crop&w=1000&q=80'),
fit: BoxFit.cover,
opacity: 0.3,
),
),
child: Stack(
children: [
// ट्रक 1: Raj Nagar (Block A) - ऊपर-बाईं ओर
Positioned(
top: 60,
left: 40,
child: _buildMapPin(
truckNo: 'GZB-101',
block: 'Raj Nagar (Block A)',
color: Colors.green,
),
),
// ट्रक 2: Indirapuram (Block B) - ऊपर-दाइयों ओर
Positioned(
top: 80,
right: 50,
child: _buildMapPin(
truckNo: 'GZB-204',
block: 'Indirapuram (Block B)',
color: Colors.blue,
),
),
// ट्रक 3: Vaishali (Sector 4) - नीचे-बाईं ओर
Positioned(
bottom: 80,
left: 60,
child: _buildMapPin(
truckNo: 'GZB-309',
block: 'Vaishali (Sector 4)',
color: Colors.orange,
),
),
// ट्रक 4: Kaushambi (Block C) - नीचे-दाइयों ओर
Positioned(
bottom: 60,
right: 60,
child: _buildMapPin(
truckNo: 'GZB-412',
block: 'Kaushambi (Block C)',
color: Colors.purple,
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

Widget _buildMapPin({required String truckNo, required String block, required Color color}) {
return GestureDetector(
onTap: () {
setState(() {
_selectedTruckInfo = 'Selected: Truck #$truckNo at $block (Status: Collecting Waste)';
});
},
child: Container(
padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
border: Border.all(color: color, width: 2),
boxShadow: [
BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 4)),
],
),
child: Row(
mainAxisSize: MainAxisSize.min,
children: [
Icon(Icons.local_shipping_rounded, color: color, size: 16),
const SizedBox(width: 6),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
children: [
Text(truckNo, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
Text(block, style: const TextStyle(fontSize: 9, color: Colors.black87, fontWeight: FontWeight.w600)),
],
),
],
),
),
);
}
  Widget _buildReportView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Report Waste Issue (Ghaziabad)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt_outlined, size: 50, color: Color(0xFF6366F1)),
                  const SizedBox(height: 16),
                  const Text('Snap & Report Garbage Overflow', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Directly integrate with device camera to capture location coordinates and send to Ghaziabad Nagar Nigam authority.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: _openCameraAction,
                    icon: const Icon(Icons.camera, color: Colors.white),
                    label: const Text('Open Camera Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ghaziabad Collection Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _buildScheduleCard('Monday - Organic Waste (Block A & B)', '7:00 AM - 9:00 AM', Colors.green, true),
                _buildScheduleCard('Wednesday - Recyclables (Indirapuram)', '8:00 AM - 10:00 AM', Colors.blue, false),
                _buildScheduleCard('Friday - General Waste (Raj Nagar)', '7:00 AM - 9:00 AM', Colors.orange, false),
                _buildScheduleCard('Sunday - Special Drive (Vaishali)', '9:00 AM - 11:00 AM', Colors.purple, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Citizen Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF6366F1),
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(height: 12),
                Text('Resident Citizen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('EcoTrack Ghaziabad Smart Community Member', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const ListTile(
            leading: Icon(Icons.location_on, color: Color(0xFF6366F1)),
            title: Text('Registered Address'),
            subtitle: Text('Raj Nagar Extension, Sector 10, Ghaziabad'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Color(0xFF6366F1)),
            title: const Text('Push Notifications'),
            trailing: Switch(value: true, onChanged: (val) {}),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Logout Portal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeView(),
      _buildGpsMapView(),
      _buildReportView(),
      _buildScheduleView(),
      _buildProfileView(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.eco_rounded, color: Color(0xFF6366F1), size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'EcoTrack Citizen Portal (Ghaziabad)',
              style: TextStyle(color: Color(0xFF1E293B), fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF6366F1)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6366F1),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_rounded), label: 'GPS Map'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_rounded), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildServiceCard({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade100),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(String title, String time, Color color, bool isToday) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isToday ? const Color(0xFF6366F1) : Colors.blue.shade100, width: isToday ? 1.5 : 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.calendar_today, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          if (isToday)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF6366F1).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: const Text('TODAY', style: TextStyle(color: Color(0xFF6366F1), fontSize: 10, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}