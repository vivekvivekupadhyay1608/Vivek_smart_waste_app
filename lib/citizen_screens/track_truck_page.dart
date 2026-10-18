import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackTruckPage extends StatelessWidget {
  const TrackTruckPage({super.key});

  Future<void> _openGoogleMaps() async {
    final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/@28.6692,77.4538,15z');
    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch map');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // यूज़र के वार्ड के लिए एकमात्र असाइंड ट्रक (Single Assigned Garbage Truck)
    final Map<String, String> assignedTruck = {
      "truckNumber": "UP 14 BT 4021",
      "driverName": "Rajesh Kumar",
      "route": "Sector 62 - Ward 12 (Your Area)",
      "status": "On the way",
      "eta": "8 mins"
    };

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        "Assigned Ward Truck",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Live tracking of the garbage collection vehicle for your location.",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          const Text(
            "Your Area Collection Vehicle",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // सिंगल फिक्स ट्रक कार्ड
          Card(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        assignedTruck["truckNumber"]!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1976D2)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          assignedTruck["status"]!,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 25),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: Colors.grey),
                      const SizedBox(width: 10),
                      Text("Assigned Driver: ${assignedTruck["driverName"]}", style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.route, size: 18, color: Colors.grey),
                      const SizedBox(width: 10),
                      Text("Service Route: ${assignedTruck["route"]}", style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 18, color: Colors.grey),
                      const SizedBox(width: 10),
                      Text("Estimated Arrival: ${assignedTruck["eta"]}", style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // गूगल मैप्स पर रीडायरेक्ट करने वाला मुख्य बटन
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _openGoogleMaps,
              icon: const Icon(Icons.map, color: Colors.white),
              label: const Text("Open Live Map in Google Maps", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}