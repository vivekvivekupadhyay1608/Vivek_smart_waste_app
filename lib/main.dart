import 'package:flutter/material.dart';
import 'splash_page.dart'; // शुरुआत स्प्लैश से होगी

// यह ग्लोबल नोटिफायर पूरी ऐप की थीम को कंट्रोल करेगा
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentThemeMode, child) {
        return MaterialApp(
          title: 'EcoTrack Smart Waste Management',
          debugShowCheckedModeBanner: false,

          // लाइट थीम
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          ),

          // डार्क थीम
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF0F172A),
          ),

          themeMode: currentThemeMode,

          // ऐप हमेशा पहले स्प्लैश पेज से शुरू होगी
          home: const SplashPage(),
        );
      },
    );
  }
}