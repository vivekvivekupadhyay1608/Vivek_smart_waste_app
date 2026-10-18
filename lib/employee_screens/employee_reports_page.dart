import 'package:flutter/material.dart';

class EmployeeReportsPage extends StatelessWidget {
  final bool isDarkMode;
  const EmployeeReportsPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Assigned Ward Complaints",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Review citizen waste reports and mark them as resolved.",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                Card(
                  color: isDarkMode ? Colors.grey[850] : Colors.white,
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.image, size: 40, color: Colors.green),
                    title: const Text("Garbage Dump near Sector 62 Park"),
                    subtitle: const Text("Status: Pending\nReporter: Vivek Upadhyay"),
                    isThreeLine: true,
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Report marked as Resolved!")),
                        );
                      },
                      child: const Text("Resolve", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}