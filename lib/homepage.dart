// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bird/bird.dart';
import 'package:flutter/material.dart';
import 'package:bird/barriers.dart';

class homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _homepagelayout();
  }
}

class _homepagelayout extends State<homepage> {
  //bird variables
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -10;
  double velocity = 3;

//game settings
  bool gameHasStarted = false;

  //barrier variables
  double barrierXone = 1.7;
  double barrierXtwo = 3.2;
  double barrierXthree = 4.7;

  //THIS FOR THE FUTURE
  var text = {'Tap to play', '3', '2', '1', ''};
  int i = 0;

  //TO reset the game
  void _resetGame() {
    Navigator.pop(context);
    setState(() {
      barrierXone = 1.7;
      barrierXtwo = barrierXone + 1.5;
      barrierXthree = barrierXtwo + 1.5;
      gameHasStarted = false;
      birdY = 0;
      initialPos = 0;
      height = 0;
      time = 0;
    });
  }

  //to start the timer of the game
  void _startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;
      });

      if (barrierXone < -1.7) {
        barrierXone = barrierXthree + 1.5;
      } else {
        barrierXone -= 0.05;
      }

      if (barrierXtwo < -1.7) {
        barrierXtwo = barrierXone + 1.5;
      } else {
        barrierXtwo -= 0.05;
      }

      if (barrierXthree < -1.7) {
        barrierXthree = barrierXtwo + 1.5;
      } else {
        barrierXthree -= 0.05;
      }

      if (_birdIsDead()) {
        timer.cancel();
        _showDialog();
      }

      time += 0.02;
    });
  }

  //to check if bird is alive
  bool _birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    return false;
  }

  //for jumping
  void _jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  //shows game over screen not complete
  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Center(
            child: Text(
              'G A M E  O V E R',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: _resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(7),
                  color: Colors.white,
                  child: const Text(
                    'Play again',
                    style: TextStyle(
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? _jump : _startGame,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue,
              child: Stack(
                children: [
                  MyBird(birdY: birdY),
                  Container(
                    alignment: const Alignment(0, -0.5),
                    child: Text(
                      gameHasStarted ? '' : 'Tap to play',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  //FIRST SET OF BARRIERS
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: Mybarriers(200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: Mybarriers(200.0),
                  ),
                  //SECOND SET OF BARRIERS
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: Mybarriers(150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: Mybarriers(250.0),
                  ),
                  //THIRD SET OF BARRIERS
                  AnimatedContainer(
                    alignment: Alignment(barrierXthree, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: Mybarriers(250.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXthree, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: Mybarriers(250.0),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
            ),
          )
        ],
      ),
    );
  }
}
