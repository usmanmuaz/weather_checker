import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgets_practice/splash_screen.dart';
import 'package:widgets_practice/theme_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ThemeProvider())
      ],
      child: Builder(
        builder:(BuildContext context){
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: themeProvider.darkTheme ? ThemeMode.dark: ThemeMode.light,
          home: const SplashScreen(),
        );
        }
      ),
    );
  }
}

