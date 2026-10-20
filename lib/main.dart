import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // FirebaseAuth इम्पोर्ट किया
import 'login_page.dart';
import 'citizen_dashboard.dart'; // अपने Citizen Dashboard या होम पेज की सही फाइल का नाम यहाँ दें

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCknD9Qi0XuicEmTjCmrlZgd7ewsGF5BCY",
          authDomain: "vivek-sentyria-smart-waste.firebaseapp.com",
          projectId: "vivek-sentyria-smart-waste",
          storageBucket: "vivek-sentyria-smart-waste.firebasestorage.app",
          messagingSenderId: "955994283079",
          appId: "1:955994283079:web:9d3cc579f02c967dfda562",
        ),
      );
    }
    print("🔥 Firebase initialized successfully!");
  } catch (e) {
    print("⚠️ Firebase initialization error: $e");
  }

  runApp(const EcoTrackApp());
}

class EcoTrackApp extends StatelessWidget {
  const EcoTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoTrack - Smart Waste Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        fontFamily: 'Roboto',
      ),
      home: const AuthCheckScreen(), // सीधा SplashScreen की जगह AuthCheck पर जाएगा
    );
  }
}

// यह स्क्रीन चेक करेगी कि यूजर पहले से लॉग-इन है या नहीं
class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // जब तक कनेक्शन लोड हो रहा है, तब तक SplashScreen दिखाएं
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        // अगर यूजर लॉग-इन है, तो सीधे डैशबोर्ड पर भेजें
        if (snapshot.hasData && snapshot.data != null) {
          return const CitizenDashboard(); // अपना सही डैशबोर्ड क्लास नेम यहाँ रखें
        }

        // अगर लॉग-इन नहीं है, तो SplashScreen के बाद Login Page दिखाएं
        return const SplashScreen();
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // यह चेक करेगा कि अगर यूजर पहले से ऑथेंटिकेटेड नहीं है तभी लॉगिन पेज पर जाए
      if (mounted) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CitizenDashboard()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/Ecotrack.png',
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.eco_rounded, size: 80, color: Color(0xFF3B82F6));
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'EcoTrack Ghaziabad',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 8),
            const Text(
              'Smart Waste Management System',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Color(0xFF3B82F6)),
          ],
        ),
      ),
    );
  }
}