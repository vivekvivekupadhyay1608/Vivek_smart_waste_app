import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class EmployeeProfilePage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const EmployeeProfilePage({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  State<EmployeeProfilePage> createState() => _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  File? profileImage;
  Uint8List? webProfileImageBytes;
  final ImagePicker _picker = ImagePicker();
  bool _isOnDuty = true;

  Future<void> _pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        var bytes = await image.readAsBytes();
        setState(() {
          webProfileImageBytes = bytes;
        });
      } else {
        setState(() {
          profileImage = File(image.path);
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile picture updated locally!")),
      );
    }
  }

  void _editFieldDialog(String fieldName, String currentValue, String dbKey) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldName"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "New $fieldName", border: const OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32)),
              onPressed: () async {
                if (currentUser != null && controller.text.trim().isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser!.uid)
                      .update({dbKey: controller.text.trim()});

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$fieldName updated successfully!")),
                  );
                }
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _changeEmailDialog(String currentEmail) {
    TextEditingController newEmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Email Address"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter new email and current password for security verification (OTP/Link).", style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 10),
              TextField(
                controller: newEmailController,
                decoration: const InputDecoration(labelText: "New Email", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Current Password", border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32)),
              onPressed: () async {
                try {
                  String newEmail = newEmailController.text.trim();
                  String password = passwordController.text.trim();

                  AuthCredential credential = EmailAuthProvider.credential(
                    email: currentUser!.email!,
                    password: password,
                  );
                  await currentUser!.reauthenticateWithCredential(credential);
                  await currentUser!.verifyBeforeUpdateEmail(newEmail);

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser!.uid)
                      .update({'email': newEmail});

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Verification link sent to new email! Please verify."), backgroundColor: Colors.green),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.red),
                  );
                }
              },
              child: const Text("Update", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Center(child: Text("No user logged in!"));
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("Employee data not found!"));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;
        String dbName = userData['fullName'] ?? 'Municipal Worker';
        String dbEmail = userData['email'] ?? 'worker@ecotrack.com';
        String dbAddress = userData['address'] ?? 'Zone 3, Depot Road';
        String dbPincode = userData['pincode'] ?? '201001';

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: kIsWeb && webProfileImageBytes != null
                        ? MemoryImage(webProfileImageBytes!)
                        : profileImage != null
                        ? FileImage(profileImage!) as ImageProvider
                        : const AssetImage('assets/Ecotrack.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF2E7D32),
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                        onPressed: _pickProfileImage,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),

            ListTile(
              tileColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              leading: const Icon(Icons.person, color: Color(0xFF2E7D32)),
              title: const Text("Full Name", style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(dbName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.edit, color: Colors.grey),
              onTap: () => _editFieldDialog("Full Name", dbName, 'fullName'),
            ),
            const SizedBox(height: 10),

            ListTile(
              tileColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              leading: const Icon(Icons.email, color: Color(0xFF2E7D32)),
              title: const Text("Email Address", style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(dbEmail, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: TextButton(
                onPressed: () => _changeEmailDialog(dbEmail),
                child: const Text("Change", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
              ),
            ),
            const SizedBox(height: 10),

            ListTile(
              tileColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              leading: const Icon(Icons.location_on, color: Color(0xFF2E7D32)),
              title: const Text("Assigned Address / Depot", style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(dbAddress, style: const TextStyle(fontSize: 15)),
              trailing: const Icon(Icons.edit, color: Colors.grey),
              onTap: () => _editFieldDialog("Address", dbAddress, 'address'),
            ),
            const SizedBox(height: 10),

            ListTile(
              tileColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              leading: const Icon(Icons.pin_drop, color: Color(0xFF2E7D32)),
              title: const Text("Pincode / Zone", style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(dbPincode, style: const TextStyle(fontSize: 15)),
              trailing: const Icon(Icons.edit, color: Colors.grey),
              onTap: () => _editFieldDialog("Pincode", dbPincode, 'pincode'),
            ),
            const SizedBox(height: 10),

            ListTile(
              tileColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              leading: Icon(Icons.work, color: _isOnDuty ? Colors.green : Colors.orange),
              title: const Text("Duty Status", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(_isOnDuty ? "On Duty (Active)" : "Off Duty (Break)", style: TextStyle(color: _isOnDuty ? Colors.green : Colors.orange)),
              trailing: Switch(
                value: _isOnDuty,
                activeColor: Colors.green,
                onChanged: (val) {
                  setState(() {
                    _isOnDuty = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            ListTile(
              tileColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              leading: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode, color: const Color(0xFF2E7D32)),
              title: const Text("Dark Theme", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: Switch(
                value: widget.isDarkMode,
                onChanged: widget.onThemeChanged,
              ),
            ),
            const SizedBox(height: 10),

            ListTile(
              tileColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Log Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }
}