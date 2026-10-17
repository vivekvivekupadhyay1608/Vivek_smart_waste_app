import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'citizen_dashboard.dart';
import 'employee_dashboard.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onThemeChanged);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [const Color(0xFF0F172A), const Color(0xFF1E293B)]
                : [const Color(0xFFE0F2FE), const Color(0xFFF1F5F9)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // 1. ऊपर दाईं ओर थीम टॉगल बटन (सूरज/चाँद आइकॉन)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF334155) : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                      color: isDarkMode ? Colors.amber : const Color(0xFF6366F1),
                    ),
                    onPressed: () {
                      if (themeNotifier.value == ThemeMode.dark) {
                        themeNotifier.value = ThemeMode.light;
                      } else {
                        themeNotifier.value = ThemeMode.dark;
                      }
                    },
                  ),
                ),
              ),

              // मुख्य लॉगिन कंटेंट्स
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // लोगो
                      SizedBox(
                        height: 65,
                        width: 65,
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
                                size: 35,
                                color: Color(0xFF6366F1),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'ECO TRACK',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6366F1),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // टेस्टिंग हिंट (थीम के हिसाब से टेक्स्ट कलर बदलेगा)
                      Text(
                        '💡 Tip: Tap Login for Citizen | Double Tap for Employee',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 2. प्रीमियम ग्लासमॉर्फिज़्म लॉगिन फॉर्म बॉक्स
                      Container(
                        constraints: const BoxConstraints(maxWidth: 420),
                        padding: const EdgeInsets.all(28.0),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF1E293B).withOpacity(0.9)
                              : Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                // थीम बदलते ही लेबल का रंग सफेद या डार्क ग्रे हो जाएगा
                                color: isDarkMode ? Colors.grey.shade200 : const Color(0xFF475569),
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                  color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade400,
                                ),
                                filled: true,
                                fillColor: isDarkMode ? const Color(0xFF0F172A) : Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.grey.shade200 : const Color(0xFF475569),
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(
                                  color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade400,
                                ),
                                filled: true,
                                fillColor: isDarkMode ? const Color(0xFF0F172A) : Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // स्मार्ट बाईपास जेस्चर ऑन लॉगिन बटन
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('🚀 Entering Citizen Dashboard...'),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CitizenDashboard()),
                                );
                              },
                              onDoubleTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('⚡ Entering Employee Dashboard...'),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const EmployeeDashboard()),
                                );
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: AbsorbPointer(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6366F1),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      elevation: 2,
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignupPage()),
                                  );
                                },
                                child: const Text(
                                  "Don't have an account? Register",
                                  style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // डेवलपर क्रेडिट (थीम के अनुसार रंग बदलेगा)
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
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                              letterSpacing: 0.5,
                            ),
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
      ),
    );
  }
}