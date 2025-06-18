import 'dart:async';
import 'package:audio_player/screens/audio_player_screen.dart';
import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AudioPlayerScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset(
           'assets/logo.png',
            height: 350,
            width: 250,
            //fit: BoxFit.cover,
          ),
          SizedBox(height: 2,),
          CircularProgressIndicator(color: Colors.blueAccent,)
            ],
          ),
        ),
      ),
    );
  }
}
