import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.red,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: Svg(
              'assets/get_started3.svg',
            ),
          ),
        ],
      ),
    ));
  }
}
