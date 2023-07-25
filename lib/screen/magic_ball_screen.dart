import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/models/data_notifier.dart';
import 'package:shake/shake.dart';

class MagicBallScreen extends StatefulWidget {
  MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  // const MagicBallScreen({Key? key}) : super(key: key);
  final int numberOfStars = 400;

  final Random random = Random();
  void initState() {
    super.initState();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        context.read<DataNotifier>().getBallResponse();
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

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
                child: context.watch<DataNotifier>().getResponse == ''
                    ? bollFirstFrame()
                    : context.watch<DataNotifier>().getResponse == 'error'
                        ? bollErrorFrame()
                        : bollTextFrame()),
            const SizedBox(
              width: 300,
              child: Center(
                child: Text(
                  'Нажимте на шар или потрясите телефон',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bollFirstFrame() {
    return CircleAvatar(
      maxRadius: context.watch<DataNotifier>().getOrientation(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height) ==
              'LANDSCAPE'
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.width * 0.6,
      minRadius: 1,
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage('assets/ball.png'),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
              maxRadius: context.watch<DataNotifier>().getOrientation(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height) ==
                      'LANDSCAPE'
                  ? MediaQuery.of(context).size.height * 0.45
                  : MediaQuery.of(context).size.width * 0.45,
              minRadius: 1,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/small_star.png')),
        ),
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
              maxRadius: context.watch<DataNotifier>().getOrientation(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height) ==
                      'LANDSCAPE'
                  ? MediaQuery.of(context).size.height * 0.4
                  : MediaQuery.of(context).size.width * 0.4,
              minRadius: 1,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/star.png')),
        ),
      ]),
    );
  }

  Widget bollTextFrame() {
    return CircleAvatar(
        maxRadius: context.watch<DataNotifier>().getOrientation(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height) ==
                'LANDSCAPE'
            ? MediaQuery.of(context).size.height * 0.4
            : MediaQuery.of(context).size.width * 0.6,
        minRadius: 1,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('assets/ball.png'),
        child: Stack(children: [
          Text(
            context.watch<DataNotifier>().getResponse,
            style: TextStyle(color: Colors.white),
          )
        ]));
  }

  Widget bollErrorFrame() {
    return CircleAvatar(
      maxRadius: context.watch<DataNotifier>().getOrientation(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height) ==
              'LANDSCAPE'
          ? MediaQuery.of(context).size.height * 0.6
          : MediaQuery.of(context).size.width * 0.6,
      minRadius: 1,
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage('assets/ball_red.png'),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
              maxRadius: context.watch<DataNotifier>().getOrientation(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height) ==
                      'LANDSCAPE'
                  ? MediaQuery.of(context).size.height * 0.45
                  : MediaQuery.of(context).size.width * 0.45,
              minRadius: 1,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/small_star.png')),
        ),
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
              maxRadius: context.watch<DataNotifier>().getOrientation(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height) ==
                      'LANDSCAPE'
                  ? MediaQuery.of(context).size.height * 0.4
                  : MediaQuery.of(context).size.width * 0.4,
              minRadius: 1,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/star.png')),
        ),
      ]),
    );
  }
}
