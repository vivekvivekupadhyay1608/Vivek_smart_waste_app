import 'package:flutter/material.dart';
import 'login_page.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const EmployeeHomeScreen(),
    const EmployeeTasksScreen(),
    const EmployeeMapScreen(),
    const EmployeeReportsScreen(),
    const EmployeeProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF6C5CE7);

    return Scaffold(
      backgroundColor: const Color(0xFFDFE6E9),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450), // मोबाइल फ्रेम जैसा दिखने के लिए
          decoration: BoxDecoration(
            color: const Color(0xFFF7F9FC),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Scaffold(
            body: _screens[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: primaryPurple,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 1. Employee Home Screen
class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF6C5CE7);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header
              Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: primaryPurple,
                        child: Text("YJ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Welcome Back!", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const Text("Yash Jaiswal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Row(
                            children: const [
                              Text("Field Worker | EMP1023", style: TextStyle(fontSize: 11, color: Colors.grey)),
                              SizedBox(width: 8),
                              Icon(Icons.circle, size: 8, color: Colors.green),
                              SizedBox(width: 4),
                              Text("Online", style: TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.black87),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Today's Tasks Summary Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF8e44ad)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.between,
                      children: const [
                        Text("Today's Tasks", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Mon, 23 Sep 2026", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _taskCountBox("8", "Total", Colors.white),
                        _taskCountBox("5", "Completed", Colors.greenAccent),
                        _taskCountBox("3", "Pending", Colors.orangeAccent),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Services / Actions
              const Text("Quick Actions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _quickActionItem(Icons.task_alt, "My Tasks"),
                  _quickActionItem(Icons.navigation, "Navigation"),
                  _quickActionItem(Icons.qr_code_scanner, "Scan Bin"),
                  _quickActionItem(Icons.upload_file, "Upload Proof"),
                ],
              ),
              const SizedBox(height: 24),

              // Current Task Card
              const Text("Current Task", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.between,
                      children: const [
                        Text("TRK-021", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Chip(
                          label: Text("ON ROUTE", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                          backgroundColor: Colors.green50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text("Ward A - Zone 1\nRaj Nagar, Street 5", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskCountBox(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }

  Widget _quickActionItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
          ),
          child: Icon(icon, color: const Color(0xFF6C5CE7)),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// 2. Tasks Screen
class EmployeeTasksScreen extends StatelessWidget {
  const EmployeeTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks"), backgroundColor: const Color(0xFF6C5CE7)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.local_shipping, color: Color(0xFF6C5CE7)),
            title: Text("TRK-021 - Ward A"),
            subtitle: Text("Raj Nagar, Street 5"),
            trailing: Chip(label: Text("ON ROUTE", style: TextStyle(color: Colors.green, fontSize: 10)), backgroundColor: Colors.greenAccent),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_shipping, color: Colors.orange),
            title: Text("TRK-022 - Ward A"),
            subtitle: Text("Shiv Mandir Road"),
            trailing: Chip(label: Text("PENDING", style: TextStyle(color: Colors.orange, fontSize: 10)), backgroundColor: Colors.orangeAccent),
          ),
        ],
      ),
    );
  }
}

// 3. Map / Navigation Screen
class EmployeeMapScreen extends StatelessWidget {
  const EmployeeMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navigation Route"), backgroundColor: const Color(0xFF6C5CE7)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.map, size: 80, color: Color(0xFF6C5CE7)),
            SizedBox(height: 16),
            Text("Live GPS Navigation for Collection Truck TRK-021", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// 4. Reports / Analytics Screen
class EmployeeReportsScreen extends StatelessWidget {
  const EmployeeReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Reports"), backgroundColor: const Color(0xFF6C5CE7)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.bar_chart, size: 80, color: Color(0xFF6C5CE7)),
            SizedBox(height: 16),
            Text("Performance: 12 Completed, 3 Pending", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// 5. Employee Profile & Logout
class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Worker Profile"), backgroundColor: const Color(0xFF6C5CE7)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(radius: 40, backgroundColor: Color(0xFF6C5CE7), child: Text("YJ", style: TextStyle(fontSize: 24, color: Colors.white))),
          ),
          const SizedBox(height: 10),
          const Center(child: Text("Yash Jaiswal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const Center(child: Text("Field Worker | EMP1023", style: TextStyle(color: Colors.grey))),
          const SizedBox(height: 30),
          ListTile(leading: const Icon(Icons.person), title: const Text("Personal Information"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () {}),
          ListTile(leading: const Icon(Icons.assignment), title: const Text("Task History"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () {}),
          ListTile(leading: const Icon(Icons.help), title: const Text("Help & Support"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () {}),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(double.infinity, 48)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}