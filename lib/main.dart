import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:home/test/hero_animation.dart';
import 'package:home/views/condition_weather_page.dart';
import 'package:home/views/hour_weather_page.dart';
import 'package:home/views/sensor_humidity_page.dart';
import 'package:home/views/sensor_temperature_page.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageState();
  }
}

class _HomePageState extends State<Home> with TickerProviderStateMixin {
  var _pageList = [
    new HeroAnimation(),
    new ConditionWeatherPage(),
    new SensorTemperaturePage(),
    new SensorHumidityPage(),
    new HourWeatherPage()
  ];

  PageController _pageController = PageController(viewportFraction: 0.9);
  AnimationController _controller;
  Animation<Color> backgroundColorAnimation;
  Color backgroundColor = Color(0xFF50409A);

  Offset dragStart;
  double slidePercent = 0.0;

  onDragStart(DragStartDetails details){
    print("dragStart->${details.globalPosition}");
  }

  onDragUpdate(DragUpdateDetails details) {
    print("DragUpdate->${details.globalPosition}");
  }

  onDragEnd(DragEndDetails details){
    print("DragEnd->${details}");
  }

  @override
  Widget build(BuildContext context) {
    Widget _rendRow(BuildContext context, int index) {
      return new Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                    begin: const Alignment(0.0, -1.0),
                    end: const Alignment(0.0, 0.6),
                    colors: [
                      Color(0xFF50409A),
                      Colors.blue,
                    ]),
              ),
              child: _pageList[index],
            ),
          ));
    }

    _updateColor(Color begin, Color end) {
      backgroundColorAnimation = ColorTween(
        begin: begin,
        end: end,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.5,
            0.75,
            curve: Curves.linear,
          ),
        ),
      )..addListener(() {
        print("update${backgroundColorAnimation.value}");
          setState(() {
            backgroundColor = backgroundColorAnimation.value;
          });
        });
    }

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    return MaterialApp(
      home: Scaffold(
          backgroundColor: backgroundColor,
          body: PageView.builder(
            itemCount: _pageList.length,
            itemBuilder: (BuildContext context, int index) {
              _updateColor(backgroundColor, Colors.blue);
              return _rendRow(context, index);
            },
            scrollDirection: Axis.horizontal,
          )),
    );
  }

  @override
  void initState() {
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }
}
