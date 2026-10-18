import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: isDarkMode ? Colors.grey[950] : Colors.white,
            child: const TabBar(
              labelColor: Color(0xFF1976D2),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF1976D2),
              tabs: [
                Tab(text: "Pending Reports"),
                Tab(text: "Resolved Reports"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.hourglass_empty, size: 60, color: Colors.orange),
                      SizedBox(height: 10),
                      Text("No Pending Reports", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check_circle_outline, size: 60, color: Colors.green),
                      SizedBox(height: 10),
                      Text("No Resolved Reports", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
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