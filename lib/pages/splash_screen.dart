import 'dart:async';

import 'package:ecommerce/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _data() async {
    try {
      Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())));
    } catch (e) {
      Exception(e);
    }
  }

  @override
  void initState() {
    _data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.white, size: 100),
                  Text('Shopping Mall', style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center)
                ],
              ),
            ),
            Text(
              'Made with ❤ ️ in India',
              style: GoogleFonts.lato(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
