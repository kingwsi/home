import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home/entity/sensor.dart';
import 'package:home/widget/sensor_tick.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SensorTemperaturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SensorTemperatureState();
  }
}

class _SensorTemperatureState extends State<SensorTemperaturePage> {
  SensorData sensorData;

  @override
  void initState() {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "温度",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        Center(
          child: Container(
              constraints: new BoxConstraints.expand(
                height: 200.0,
              ),
              child: sensorData == null
                  ? SpinKitThreeBounce(
                      color: Colors.white,
                    )
                  : SensorTick(
                      data: _createSampleData(),
                      unit: "℃",
                    )),
        ),
      ],
    );
  }

  List<charts.Series<Feed, DateTime>> _createSampleData() {
    return [
      new charts.Series<Feed, DateTime>(
        id: 'Cost',
        colorFn: (_, __) => charts.MaterialPalette.white,
        domainFn: (Feed feed, _) => DateTime.parse(feed.created_at),
        measureFn: (Feed feed, _) => double.parse(feed.field1),
        data: sensorData.feeds,
      )
    ];
  }

  _getData() async {
    Dio dio = new Dio();
    try {
      var response = await dio.get<String>(
          "https://api.thingspeak.com/channels/784382/feeds.json?timezone=Asia%2FShanghai");
      if (response.statusCode == 200) {
        print("请求成功，响应码${response.statusCode}");
        SensorData sensor = SensorData.fromJson(json.decode(response.data));
        setState(() {
          sensorData = sensor;
        });
      } else {
        print("请求失败，响应码${response.statusCode}");
      }
    } on DioError catch (e) {
      print("请求错误！");
    }
  }
}
