import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_news_apps/pages/News_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Now',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: AnimatedSplashScreen(
        nextScreen: NewsPage(),
        splash: Image.asset('images/news3.png'),
        backgroundColor: Colors.teal,
        duration: 2000,
        splashTransition: SplashTransition.scaleTransition,

      ),
    );
  }
}
