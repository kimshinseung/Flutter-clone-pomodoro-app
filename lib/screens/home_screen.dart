import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer){ //인자로 timer를 넣어줘야 함
    if(totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    }else{
      setState(() {
        totalSeconds -= 1;
      });
    }
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

  void reStartPressed(){
    setState(() {
      totalSeconds = twentyFiveMinutes;
    });

  }

  String format(int seconds){
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").
    first.substring(2,7);
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
              child: Text(format(totalSeconds),
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
                        Text('$totalPomodoros',style: TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                        ),
                        IconButton(
                            iconSize: 32,
                            color: Theme.of(context).backgroundColor,
                            onPressed: reStartPressed
                            , icon: Icon(Icons.restart_alt_outlined)),
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
