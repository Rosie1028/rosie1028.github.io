import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "Rosangela's Portfolio",
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.indigo,r
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //     brightness: Brightness.light,
    //   ),
    //   home: const HomeScreen(),
    // );
    try {
      final baseTextTheme = GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ).apply(bodyColor: Colors.black87, displayColor: Colors.black87);

      return MaterialApp(
        title: 'Rosangela Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF10B981), // Emerald
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF10B981), // Emerald
            secondary: const Color(0xFF059669), // Dark Emerald
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
          scaffoldBackgroundColor: Colors.white, // White background
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, // White
            foregroundColor: Color(0xFF000000), // Black text
            elevation: 0,
          ),
          textTheme: baseTextTheme,
          fontFamilyFallback: const ['Noto Sans', 'Arial', 'sans-serif'],
        ),
        home: const HomeScreen(),
      );
    } catch (e) {
      // Fallback if GoogleFonts fails
      return MaterialApp(
        title: 'Rosangela Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF10B981), // Emerald
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF10B981), // Emerald
            secondary: const Color(0xFF059669), // Dark Emerald
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
          scaffoldBackgroundColor: Colors.white, // White background
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, // White
            foregroundColor: Color(0xFF000000), // Black text
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
      );
    }
  }
}
