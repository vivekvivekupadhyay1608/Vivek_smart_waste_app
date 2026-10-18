import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeRoutePage extends StatelessWidget {
  final bool isDarkMode;
  const EmployeeRoutePage({super.key, required this.isDarkMode});

  Future<void> _openNavigationMap() async {
    final Uri mapUrl = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=Sector+62+Ghaziabad');
    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Live Collection Route",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Optimized path for today's waste pickup schedule.",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Card(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Current Assigned Route:", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(height: 5),
                  Text("Ward 12 - Sector 62 (Block A to D)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Divider(height: 20),
                  Text("Next Pickup Stop: Gate No. 3, Apex Society", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 8),
                  Text("Estimated Time: 5 mins", style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _openNavigationMap,
              icon: const Icon(Icons.navigation, color: Colors.white),
              label: const Text("Start GPS Navigation", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}