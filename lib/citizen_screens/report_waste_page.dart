import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class ReportWastePage extends StatefulWidget {
  const ReportWastePage({super.key});

  @override
  State<ReportWastePage> createState() => _ReportWastePageState();
}

class _ReportWastePageState extends State<ReportWastePage> {
  File? reportWasteImage;
  Uint8List? webImageBytes;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _openCameraOrGallery() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (photo != null) {
        if (kIsWeb) {
          var bytes = await photo.readAsBytes();
          setState(() {
            webImageBytes = bytes;
          });
        } else {
          setState(() {
            reportWasteImage = File(photo.path);
          });
        }
        _showWasteReportPreviewDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No photo captured.")),
        );
      }
    } catch (e) {
      _openGalleryFallback();
    }
  }

  Future<void> _openGalleryFallback() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (kIsWeb) {
          var bytes = await image.readAsBytes();
          setState(() {
            webImageBytes = bytes;
          });
        } else {
          setState(() {
            reportWasteImage = File(image.path);
          });
        }
        _showWasteReportPreviewDialog();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _showWasteReportPreviewDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Waste Report Preview"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (kIsWeb && webImageBytes != null)
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: Image.memory(webImageBytes!, fit: BoxFit.cover),
                  )
                else if (!kIsWeb && reportWasteImage != null)
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: Image.file(reportWasteImage!, fit: BoxFit.cover),
                  ),
                const SizedBox(height: 15),
                Text(
                  "Description: ${_descriptionController.text.isEmpty ? 'No description provided' : _descriptionController.text}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text("Do you want to submit this report?"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1976D2)),
              onPressed: () {
                Navigator.pop(context);
                _descriptionController.clear();
                setState(() {
                  reportWasteImage = null;
                  webImageBytes = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Report submitted successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, size: 45, color: Colors.redAccent),
          const SizedBox(height: 10),
          const Text(
            "Report Waste in your Area",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Capture waste photo and provide details to notify municipality.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: _openCameraOrGallery,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.blue[50],
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1976D2), width: 3),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 3)
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 50, color: Color(0xFF1976D2)),
                  SizedBox(height: 8),
                  Text(
                    "TAP TO OPEN\nCAMERA",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1976D2)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Enter waste description (location or amount)",
              alignLabelWithHint: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: const Icon(Icons.description, color: Color(0xFF1976D2)),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (_descriptionController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please add description or photo first!")),
                  );
                } else {
                  _showWasteReportPreviewDialog();
                }
              },
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text("Submit Waste Report", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}