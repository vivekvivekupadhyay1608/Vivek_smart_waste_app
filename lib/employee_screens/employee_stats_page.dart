import 'package:flutter/material.dart';

class EmployeeStatsPage extends StatefulWidget {
  final bool isDarkMode;
  const EmployeeStatsPage({super.key, required this.isDarkMode});

  @override
  State<EmployeeStatsPage> createState() => _EmployeeStatsPageState();
}

class _EmployeeStatsPageState extends State<EmployeeStatsPage> {
  // प्रेजेंटेशन के लिए डेमो मोड टॉगल (बाइपास)
  bool _isPresentationDemoMode = false;

  @override
  Widget build(BuildContext context) {
    // अगर डेमो मोड ऑन है, तो ग्राफ में एक्टिव वैल्यू दिखेगी, अन्यथा शून्य (0)
    int collectedBins = _isPresentationDemoMode ? 45 : 0;
    double collectionEfficiency = _isPresentationDemoMode ? 88.5 : 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Daily Collection Summary",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // प्रेजेंटेशन बाइपास टॉगल स्विच
              Row(
                children: [
                  const Text("Demo Mode", style: TextStyle(fontSize: 12)),
                  Switch(
                    value: _isPresentationDemoMode,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      setState(() {
                        _isPresentationDemoMode = val;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),

          // स्टैट्स कार्ड्स
          Row(
            children: [
              Expanded(
                child: Card(
                  color: widget.isDarkMode ? Colors.grey[850] : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text("Bins Collected", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text("$collectedBins", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Card(
                  color: widget.isDarkMode ? Colors.grey[850] : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text("Efficiency", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text("$collectionEfficiency%", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // 1. साप्ताहिक (Weekly) एनालिटिकल ग्राफ - Mon to Sun
          const Text(
            "Weekly Collection Analytics (Mon - Sun)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Container(
            height: 220,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBar("Mon", _isPresentationDemoMode ? 0.6 : 0.0),
                    _buildBar("Tue", _isPresentationDemoMode ? 0.8 : 0.0),
                    _buildBar("Wed", _isPresentationDemoMode ? 0.5 : 0.0),
                    _buildBar("Thu", _isPresentationDemoMode ? 0.9 : 0.0),
                    _buildBar("Fri", _isPresentationDemoMode ? 0.7 : 0.0),
                    _buildBar("Sat", _isPresentationDemoMode ? 0.85 : 0.0),
                    _buildBar("Sun", _isPresentationDemoMode ? 0.4 : 0.0),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _isPresentationDemoMode ? "Weekly Analytics Active (Demo Mode)" : "No active work recorded yet (Status: 0)",
                  style: TextStyle(fontSize: 12, color: _isPresentationDemoMode ? Colors.green : Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // 2. एरिया-वाइज (Shastri Nagar Blocks) एनालिटिकल ग्राफ
          const Text(
            "Shastri Nagar Area-wise Collection Analytics",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Container(
            height: 220,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBar("Block A", _isPresentationDemoMode ? 0.75 : 0.0),
                    _buildBar("Block B", _isPresentationDemoMode ? 0.9 : 0.0),
                    _buildBar("Block C", _isPresentationDemoMode ? 0.65 : 0.0),
                    _buildBar("Block D", _isPresentationDemoMode ? 0.85 : 0.0),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _isPresentationDemoMode ? "Zone: Ghaziabad Shastri Nagar (Demo Active)" : "No area data recorded yet",
                  style: TextStyle(fontSize: 12, color: _isPresentationDemoMode ? Colors.green : Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double heightFactor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 22,
          height: 90 * heightFactor,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}