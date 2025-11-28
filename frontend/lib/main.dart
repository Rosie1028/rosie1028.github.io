import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
    final fallbackFonts = <String>[
      GoogleFonts.notoSans().fontFamily ?? 'NotoSans',
    ];

    final baseTextTheme = GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ).apply(bodyColor: Colors.black87, displayColor: Colors.black87);

    return MaterialApp(
      title: 'Rosangela Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        fontFamilyFallback: fallbackFonts,
        textTheme: baseTextTheme,
      ),
      home: const HomeScreen(),
    );
  }
}
