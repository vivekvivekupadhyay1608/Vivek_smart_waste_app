import 'package:flutter/material.dart';
import 'login_page.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
int _selectedIndex = 0;

void _showActionDialog(String title, String message) {
showDialog(
context: context,
builder: (context) => AlertDialog(
title: Row(
children: [
const Icon(Icons.verified_rounded, color: Color(0xFF10B981)),
const SizedBox(width: 8),
Text(title, style: const TextStyle(fontSize: 16)),
],
),
content: Text(message),
actions: [
ElevatedButton(
style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
onPressed: () {
Navigator.pop(context);
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('✅ Action processed successfully!')),
);
},
child: const Text('OK', style: TextStyle(color: Colors.white)),
),
],
),
);
}

// 1. Home View (मेन डैशबोर्ड)
Widget _buildHomeView() {
return SingleChildScrollView(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.9),
borderRadius: BorderRadius.circular(12),
border: Border.all(color: Colors.blue.shade100),
),
child: Row(
children: [
Container(
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: const Color(0xFF10B981).withOpacity(0.1),
shape: BoxShape.circle,
),
child: const Icon(Icons.engineering_rounded, color: Color(0xFF10B981), size: 24),
),
const SizedBox(width: 12),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: const [
Text('Welcome Back!', style: TextStyle(color: Colors.grey, fontSize: 12)),
SizedBox(height: 2),
Text(
'Field Officer | EMP-1023 (Ghaziabad Zone)',
style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B)),
),
],
),
),
Container(
padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
decoration: BoxDecoration(
color: Colors.green.withOpacity(0.1),
borderRadius: BorderRadius.circular(6),
),
child: Row(
children: const [
CircleAvatar(radius: 3, backgroundColor: Colors.green),
SizedBox(width: 4),
Text('Online', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
],
),
),
],
),
),
const SizedBox(height: 16),

// टुडे टास्क प्रोग्रेस कार्ड
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
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: const [
Text('Today\'s Tasks (Ghaziabad)', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
Text('Live Status', style: TextStyle(color: Colors.white70, fontSize: 12)),
],
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
_buildTaskStat('8', 'Total', Colors.white),
_buildTaskStat('5', 'Completed', Colors.white70),
_buildTaskStat('3', 'Pending', Colors.white70),
],
),
],
),
),
const SizedBox(height: 20),

// क्विक एक्शंस ग्रिड
const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
const SizedBox(height: 12),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
_buildActionCard(Icons.task_alt_rounded, 'My Tasks', Colors.blue, () => setState(() => _selectedIndex = 1)),
_buildActionCard(Icons.alt_route_rounded, 'Navigation', Colors.green, () => setState(() => _selectedIndex = 2)),
_buildActionCard(Icons.qr_code_scanner_rounded, 'Scan Bin', Colors.purple, () => _showActionDialog('Bin Scanner', 'IoT Smart Bin scanned successfully! Status: Full.')),
_buildActionCard(Icons.upload_file_rounded, 'Upload Proof', Colors.orange, () => _showActionDialog('Proof Upload', 'Collection completion photo uploaded successfully.')),
],
),
const SizedBox(height: 24),

// करंट टास्क कार्ड
const Text('Current Task', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
const SizedBox(height: 12),
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.9),
borderRadius: BorderRadius.circular(12),
border: Border.all(color: Colors.blue.shade100),
),
child: Row(
children: [
const Icon(Icons.local_shipping, color: Color(0xFF10B981), size: 28),
const SizedBox(width: 14),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: const [
Text('TRK-021', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B))),
SizedBox(height: 2),
Text('Ward A - Zone 1\nRaj Nagar Extension, Street 5', style: TextStyle(color: Colors.grey, fontSize: 11)),
],
),
),
Container(
padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
decoration: BoxDecoration(
color: Colors.green.withOpacity(0.1),
borderRadius: BorderRadius.circular(6),
),
child: const Text('ON ROUTE', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
),
],
),
),
],
),
);
}

Widget _buildTasksListView() {
return Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text('Assigned Tasks List (Ghaziabad)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
const SizedBox(height: 12),
Expanded(
child: ListView(
children: [
_buildTaskItem('TRK-021', 'Ward A - Zone 1 • Raj Nagar Ext.', 'ON ROUTE', Colors.green),
_buildTaskItem('TRK-022', 'Ward A - Zone 2 • Indirapuram', 'PENDING', Colors.orange),
_buildTaskItem('TRK-023', 'Ward B - Zone 2 • Vaishali', 'PENDING', Colors.orange),
_buildTaskItem('TRK-024', 'Ward C - Zone 1 • Kaushambi', 'COMPLETED', Colors.blue),
],
),
),
],
),
);
}

// गाजियाबाद का रूट नेविगेशन मैप (पिकअप पॉइंट, स्टॉपेज 1, स्टॉपेज 2, डेस्टिनेशन)
Widget _buildNavigationMapView() {
return Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween, // <--- यहाँ spaceBetween ठीक कर दिया है
children: [
const Text('Ghaziabad Route Navigation (TRK-021)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
Container(
padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
child: const Text('Live Tracking', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
),
],
),
const SizedBox(height: 10),
Expanded(
child: Container(
width: double.infinity,
decoration: BoxDecoration(
color: Colors.green.shade50,
borderRadius: BorderRadius.circular(16),
border: Border.all(color: Colors.green.shade200),
image: const DecorationImage(
image: NetworkImage('https://images.unsplash.com/photo-1569336415962-a4bd9f69cd83?auto=format&fit=crop&w=1000&q=80'),
fit: BoxFit.cover,
opacity: 0.3,
),
),
child: Stack(
children: [
Positioned(
top: 40,
left: 30,
child: _buildRouteWaypointPin(
title: 'Start: Depot Hub',
subtitle: 'Raj Nagar Ext.',
color: Colors.blue,
icon: Icons.play_arrow_rounded,
),
),
Positioned(
top: 130,
right: 60,
child: _buildRouteWaypointPin(
title: 'Stop 1: Block A Bin',
subtitle: 'Collection Point',
color: Colors.orange,
icon: Icons.pause_circle_filled_rounded,
),
),
Positioned(
bottom: 120,
left: 50,
child: _buildRouteWaypointPin(
title: 'Stop 2: Commercial Market',
subtitle: 'Waste Transfer',
color: Colors.purple,
icon: Icons.location_pin,
),
),
Positioned(
bottom: 40,
right: 40,
child: _buildRouteWaypointPin(
title: 'Destination: Processing Plant',
subtitle: 'Vijay Nagar Dump',
color: Colors.green,
icon: Icons.flag_rounded,
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

Widget _buildRouteWaypointPin({required String title, required String subtitle, required Color color, required IconData icon}) {
return Container(
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
Icon(icon, color: color, size: 18),
const SizedBox(width: 6),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
children: [
Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
Text(subtitle, style: const TextStyle(fontSize: 9, color: Colors.black87, fontWeight: FontWeight.w600)),
],
),
],
),
);
}
  Widget _buildReportsView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Issue Reports & Proofs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildReportItem('Garbage Overflow Proof', 'Uploaded 10 mins ago - Raj Nagar', Colors.green),
                _buildReportItem('Bin Damaged Report', 'Submitted to Ghaziabad Authority', Colors.orange),
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
          const Text('Field Officer Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF10B981),
                  child: Icon(Icons.engineering, size: 40, color: Colors.white),
                ),
                SizedBox(height: 12),
                Text('Field Officer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('EMP-1023 • EcoTrack Ghaziabad Fleet', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const ListTile(
            leading: Icon(Icons.badge, color: Color(0xFF10B981)),
            title: Text('Duty Status'),
            subtitle: Text('Active Shift (Ghaziabad Zone A)'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Color(0xFF10B981)),
            title: const Text('Alerts & Reminders'),
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
      _buildTasksListView(),
      _buildNavigationMapView(),
      _buildReportsView(),
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
                color: const Color(0xFF10B981).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.eco_rounded, color: Color(0xFF10B981), size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'EcoTrack Employee Portal',
              style: TextStyle(color: Color(0xFF1E293B), fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF10B981)),
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
        selectedItemColor: const Color(0xFF10B981),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task_alt_rounded), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.alt_route_rounded), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.description_rounded), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildTaskStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: color, fontSize: 11)),
      ],
    );
  }

  Widget _buildActionCard(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade100),
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

  Widget _buildTaskItem(String title, String subtitle, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.local_shipping, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(String title, String time, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.receipt_long, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}