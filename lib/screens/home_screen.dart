import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int totalSeconds = 1500;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer){ //인자로 timer를 넣어줘야 함
    setState(() {
      totalSeconds -= 1;
    });
  }

  void onStartPressed(){
    timer = Timer.periodic(
        Duration(seconds: 1) //매 1초마다 함수 실행
        , onTick,); //()를 넣으면 함수를 실행하는것이므로 넣으면 안됨
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              //그래비티 정함.
              alignment: Alignment.bottomCenter,
              child: Text('$totalSeconds',
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 89,
                fontWeight: FontWeight.w600,
              ),),

          ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning? onPausePressed
                    :onStartPressed,
                icon: Icon(isRunning
                    ? Icons.pause_circle_outline
                    :Icons.play_circle_outline),
              ),
          ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pomodoros',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        Text('0',style: TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                        ),
                      ],
                    ),
          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
