import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class EmployeeReportsPage extends StatefulWidget {
  final bool isDarkMode;
  const EmployeeReportsPage({super.key, required this.isDarkMode});

  @override
  State<EmployeeReportsPage> createState() => _EmployeeReportsPageState();
}

class _EmployeeReportsPageState extends State<EmployeeReportsPage> {
  File? _proofImage;
  Uint8List? _webProofImageBytes;
  final ImagePicker _picker = ImagePicker();
  bool _isResolved = false;

  Future<void> _pickProofImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (kIsWeb) {
        var bytes = await image.readAsBytes();
        setState(() {
          _webProofImageBytes = bytes;
        });
      } else {
        setState(() {
          _proofImage = File(image.path);
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Work completion photo captured successfully!")),
      );
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
            "Assigned Ward Complaints",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Review citizen waste reports, upload work proof, and mark as resolved.",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                Card(
                  color: widget.isDarkMode ? Colors.grey[850] : Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.green),
                            const SizedBox(width: 8),
                            const Text("Garbage Dump near Sector 62 Park", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("Reporter: Vivek Upadhyay", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 5),
                        Text(
                          "Status: ${_isResolved ? 'Resolved (Done)' : 'Pending'}",
                          style: TextStyle(
                            color: _isResolved ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // फोटो अपलोड प्रूफ सेक्शन
                        if (_proofImage != null || _webProofImageBytes != null) ...[
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: kIsWeb && _webProofImageBytes != null
                                    ? MemoryImage(_webProofImageBytes!)
                                    : FileImage(_proofImage!) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton.icon(
                              onPressed: _pickProofImage,
                              icon: const Icon(Icons.camera_alt, color: Color(0xFF2E7D32)),
                              label: const Text("Capture Proof", style: TextStyle(color: Color(0xFF2E7D32))),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isResolved ? Colors.grey : const Color(0xFF2E7D32),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isResolved = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Task marked as Resolved! Great job.")),
                                );
                              },
                              child: Text(_isResolved ? "Completed" : "Mark Done", style: const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
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