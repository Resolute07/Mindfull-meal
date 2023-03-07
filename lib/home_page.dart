import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();
  CountDownController _controller = CountDownController();
  bool isStared = false;
  bool sound = true;
  double pagePos = 0;
  int _duration = 30;

  Future<void> playBeep() async {
    sound
        ? player.play(
            AssetSource("countdown_tick.mp3"),
          )
        : null;
  }

  void startCountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration > 0) {
        setState(() {
          _duration--;
        });

        if (_duration < 5) {
          playBeep();
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff1C1728),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text(
          "Mindful Meal Timer ",
          style: TextStyle(color: Color(0xff6E6980)),
        ),
        backgroundColor: Color(0xff1C1728),
      ),
      body: Column(
        children: [
          Container(
            height: height / 28.13,
            child: DotsIndicator(
              decorator: DotsDecorator(activeColor: Colors.white),
              dotsCount: 3,
              position: pagePos,
            ),
          ),
          Container(
            height: height / 2.0,
            child: Column(
              children: [
                Text(
                  pagePos == 0
                      ? isStared
                          ? "Nom nom :)"
                          : "Time to eat mindfully"
                      : pagePos == 1
                          ? "Break Time"
                          : "Finish your meal",
                  style:
                      TextStyle(color: Colors.white, fontSize: height / 33.76),
                ),
                SizedBox(
                  height: height / 42.2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 19.5),
                  child: Text(
                    pagePos == 0
                        ? isStared
                            ? "You have 10 minutes to eat before the pause \nFocus on eating slowly"
                            : "It's Simple: eat for ten minutes, rest for five, then finish your meal"
                        : pagePos == 1
                            ? "Take a five minute break to check on your level of fullness"
                            : "You can eat until you feel full",
                    style: TextStyle(
                        color: Color(0xff6E6980), fontSize: height / 56.26),
                  ),
                ),
                SizedBox(
                  height: height / 28.13,
                ),
                CircleAvatar(
                    backgroundColor: Color(0xffA4A2A7),
                    radius: height / 6.02,
                    child: CircularCountDownTimer(
                      onComplete: () => setState(() {
                        if (pagePos < 2) {
                          pagePos++;
                        } else {
                          pagePos = 0;
                        }
                        _controller.reset();
                        isStared = false;
                      }),
                      autoStart: false,
                      controller: _controller,
                      width: width / 1.69,
                      height: height / 3.67,
                      duration: 30,
                      fillColor: Color(0xff26CD66),
                      backgroundColor: Colors.white,
                      ringColor: Colors.white,
                      isReverse: true,
                      isReverseAnimation: true,
                      onStart: () {
                        startCountDown();
                      },
                    ))
              ],
            ),
          ),
          Container(
            height: height / 10.55,
            child: Column(
              children: [
                Switch(
                    hoverColor: Colors.white,
                    activeTrackColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    activeColor: Color(0xff26CD66),
                    value: sound,
                    onChanged: (val) {
                      setState(() {
                        sound = val;
                      });
                    }),
                Text(
                  "Sound On",
                  style:
                      TextStyle(color: Colors.white, fontSize: height / 56.66),
                )
              ],
            ),
          ),
          SizedBox(
            height: height / 84.4,
          ),
          !isStared
              ? GestureDetector(
                  onTap: () {
                    _controller.start();
                    setState(() {
                      isStared = true;
                      _duration = 30;
                    });
                  },
                  child: CustomButton(
                    text: "Start",
                    color: Color(0xffD6EFE0),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    if (!_controller.isPaused) {
                      setState(() {
                        _controller.pause();
                      });
                    } else {
                      setState(() {
                        _controller.resume();
                      });
                    }
                  },
                  child: CustomButton(
                    text: _controller.isPaused ? "Resume" : "Pause",
                    color: Color(0xffD6EFE0),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isStared = false;
                _controller.reset();
                pagePos = 0;
              });
            },
            child: CustomButton(
              text: "LET'S STOP I'M FULL NOW",
              textcolor: Colors.white,
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
