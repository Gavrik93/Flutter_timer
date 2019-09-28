import 'package:flutter/material.dart';
import 'dart:async';
import './custom_text_container.dart';

void main() => runApp(TimerApp(
));

class TimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerAppState();
  }
}

class TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;
  bool unActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    } else {
      setState(() {
        //break count
        secondsPassed = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timer'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                      label: 'HRS', value: hours.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'SEC', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  child: Text(
                    isActive ? 'RESET' : 'START',
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              ),
              /* Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  child: Text('RESET'),
                  onPressed: () {
                    setState(() {
                      unActive = ! unActive;
                    });
                  },
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
