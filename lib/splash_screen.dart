import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgets_practice/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
late AnimationController _animationController;

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
       );
       _animationController.forward().then((_){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
        
       });
    

  }
  @override
  void dispose() {
    
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/weather_animation.json",
          controller: _animationController,
          height: 300,
          
          
          ),
      ),
    );
  }
}