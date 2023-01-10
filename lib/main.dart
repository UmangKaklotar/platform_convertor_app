import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'Home Page.dart';
import 'Story View.dart';
import 'archive.dart';
import 'chat.dart';
import 'profile.dart';

void main()
{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        'home': (context) => const HomePage(),
        'archive': (context) => const Archive(),
        'chat': (context) => const Chat(),
        'story': (context) => const StoryPageView(),
        'profile': (context) => const ProfileImage(),
      },
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Colors.black,
        animationDuration: const Duration(seconds: 2),
        splash: const Icon(Icons.whatsapp_rounded, size: 100, color: Colors.white,),
        nextScreen: const HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}