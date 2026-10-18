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

          // एनालिटिकल ग्राफ रिप्रेजेंटेशन
          const Text(
            "Hourly Collection Analytics",
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
                    _buildBar("8 AM", _isPresentationDemoMode ? 0.3 : 0.0),
                    _buildBar("10 AM", _isPresentationDemoMode ? 0.7 : 0.0),
                    _buildBar("12 PM", _isPresentationDemoMode ? 0.9 : 0.0),
                    _buildBar("2 PM", _isPresentationDemoMode ? 0.5 : 0.0),
                    _buildBar("4 PM", _isPresentationDemoMode ? 0.85 : 0.0),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _isPresentationDemoMode ? "Live Analytics Active (Demo Mode)" : "No active work recorded yet (Status: 0)",
                  style: TextStyle(fontSize: 12, color: _isPresentationDemoMode ? Colors.green : Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String timeLabel, double heightFactor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25,
          height: 100 * heightFactor,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(timeLabel, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}