import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      print('print');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const MyHomePage(
          title: 'home page',
        ),
      ));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 230, 223, 241),
        Color.fromARGB(255, 239, 211, 183),
        Color.fromARGB(255, 70, 172, 176),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    ));
  }
}
