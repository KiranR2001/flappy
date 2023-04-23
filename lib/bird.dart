import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdY;

  MyBird({this.birdY});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0, birdY),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Image.asset(
            'lib/images/bird.png',
          ),
        ));
  }
}
