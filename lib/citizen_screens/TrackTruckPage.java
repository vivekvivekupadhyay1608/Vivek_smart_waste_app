import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackTruckPage extends StatelessWidget {
  const TrackTruckPage({super.key});

  // गूगल मैप्स या लाइव लोकेशन लिंक खोलने का फंक्शन
  Future<void> _openGoogleMaps() async {
    final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/@28.6692,77.4538,15z');
    
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // एरिया के गार्बेज ट्रकों की डमी लिस्ट (जिसे बाद में हम डेटाबेस से जोड़ सकते हैं)
    final List<Map<String, String>> truckList = [
      {
        "truckNumber": "UP 14 BT 4021",
        "driverName": "Rajesh Kumar",
        "route": "Sector 62 - Block A & B",
        "status": "On the way",
        "eta": "10 mins"
      },
      {
        "truckNumber": "UP 14 CZ 8892",
        "driverName": "Amit Singh",
        "route": "Raj Nagar Extension - Zone 3",
        "status": "Arriving Soon",
        "eta": "3 mins"
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // हेडर कार्ड या बैनर
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_shipping, size: 40, color: Colors.green),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Live Garbage Collection",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Track assigned trucks in your ward in real-time.",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Active Trucks in Your Area",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // ट्रकों की लिस्ट दिखाने के लिए ListView
          Expanded(
            child: ListView.builder(
              itemCount: truckList.length,
              itemBuilder: (context, index) {
                var truck = truckList[index];
                return Card(
                  color: isDarkMode ? Colors.grey[850] : Colors.white,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              truck["truckNumber"]!,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1976D2)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                truck["status"]!,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.person, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text("Driver: ${truck["driverName"]}"),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.route, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text("Route: ${truck["route"]}"),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text("Expected Arrival: ${truck["eta"]}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // गूगल मैप्स पर रीडायरेक्ट करने वाला मुख्य बटन
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _openGoogleMaps, // क्लिक करते ही Google Maps पर रीडायरेक्ट हो जाएगा
              icon: const Icon(Icons.map, color: Colors.white),
              label: const Text("Open Live Map in Google Maps", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}