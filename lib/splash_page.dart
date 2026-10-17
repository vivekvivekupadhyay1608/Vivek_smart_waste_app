import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // 3 सेकंड बाद लॉगिन पेज पर ले जाएं
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        bool isDarkMode = currentMode == ThemeMode.dark;

        return Scaffold(
          backgroundColor: isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // स्प्लैश लोगो (एसेट इमेज + फॉलबैक आइकॉन)
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: Image.asset(
                      'assets/ecotrack.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.eco_rounded,
                            size: 50,
                            color: Color(0xFF6366F1),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'ECO TRACK',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6366F1),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Smart Waste Management System',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 36),
                  const CircularProgressIndicator(
                    color: Color(0xFF6366F1),
                  ),

                  const Spacer(),

                  // डेवलपर क्रेडिट
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.code_rounded, size: 16, color: Color(0xFF6366F1)),
                      const SizedBox(width: 6),
                      Text(
                        'DEVELOPED BY VIVEK UPADHYAY',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}