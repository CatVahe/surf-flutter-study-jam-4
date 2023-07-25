import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/models/data_notifier.dart';

class MagicBallScreen extends StatelessWidget {
  // const MagicBallScreen({Key? key}) : super(key: key);

  final int numberOfStars = 400;
  final Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black,
            Color.fromARGB(255, 29, 0, 59),
            Color.fromARGB(255, 43, 1, 89)
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  context.read<DataNotifier>().getBallResponse();
                },
                child: Stack(children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/ball.png',
                    ),
                  ),
                  context.watch<DataNotifier>().getResponse == ''
                      ? Stack(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/small_star.png',
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/star.png',
                            ),
                          )
                        ])
                      : Align(
                          alignment: Alignment.center,
                          child: Text(context.watch<DataNotifier>().getResponse,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        )
                ])),
            Center(
              child: Text(
                'tap to ball',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
