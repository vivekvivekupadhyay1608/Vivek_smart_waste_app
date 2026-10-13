import 'package:flutter/material.dart';

class LoginFormPage extends StatelessWidget {
  final String role; // Pata lagane ke liye ki Citizen hai ya Worker
  const LoginFormPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    Color themeColor = role == 'Citizen' ? Colors.green : Colors.orange;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('$role Portal'),
          backgroundColor: themeColor,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "LOGIN"),
              Tab(text: "REGISTER"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // --- LOGIN TAB ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: role == 'Citizen' ? 'Mobile Number or Email' : 'Worker ID',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TextField(
                    decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Captcha Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Captcha: X7K9P", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Icon(Icons.refresh),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(labelText: 'Enter Captcha', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      // Login logic yahan aayega
                    },
                    child: const Text("LOGIN", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ],
              ),
            ),

            // --- REGISTRATION TAB ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  if (role == 'Citizen') ...[
                    const TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
                    const SizedBox(height: 15),
                    const TextField(decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder())),
                    const SizedBox(height: 15),
                    const TextField(decoration: InputDecoration(labelText: 'Pincode', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                    const SizedBox(height: 15),
                  ] else ...[
                    const TextField(decoration: InputDecoration(labelText: 'Worker ID', border: OutlineInputBorder())),
                    const SizedBox(height: 15),
                    const TextField(decoration: InputDecoration(labelText: 'Admin Passkey', border: OutlineInputBorder()), obscureText: true),
                    const SizedBox(height: 15),
                  ],
                  const TextField(decoration: InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder()), keyboardType: TextInputType.phone),
                  const SizedBox(height: 15),
                  const TextField(decoration: InputDecoration(labelText: 'Email ID (For Verification)', border: OutlineInputBorder()), keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  // Captcha Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Captcha: M3L2R", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Icon(Icons.refresh),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(labelText: 'Enter Captcha', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      // Register & Email Verification logic yahan aayega
                    },
                    child: const Text("REGISTER & VERIFY", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}