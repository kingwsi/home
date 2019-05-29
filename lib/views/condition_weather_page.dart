import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home/entity/weather.dart';

class ConditionWeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ConditionWeatherState();
  }
}

class _ConditionWeatherState extends State<ConditionWeatherPage> {
  Weather weather;
  Condition condition;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return weather == null
        ? SpinKitThreeBounce(
            color: Colors.white,
          )
        : ListView(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    weather.data.city.name,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              Center(
                  child: Text(
                    condition.condition,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                      child: new SizedBox(
                        width: 100,
                        child: Row(
                          children: <Widget>[
                            Text(
                              condition.temp,
                              style: TextStyle(fontSize: 60, color: Colors.white),
                            ),
                            Text(
                              "℃",
                              style: TextStyle(fontSize: 30, color: Colors.white),
                            )
                          ],
                        ),
                      )
                  ),
              ),
            ],
          );
  }

  @override
  void initState() {
    _initData();
  }

  _initData() async {
    FormData data = new FormData.from({"cityId": "1185"});
    Dio dio = new Dio();
    try {
      Options options = Options(headers: {
        "Authorization": "APPCODE 9ac68038cf2240c1aff45006b915679e"
      });
      var response = await dio.post<String>(
          "http://aliv18.data.moji.com/whapi/json/alicityweather/condition",
          options: options,
          data: data);
      if (response.statusCode == 200) {
        print("请求成功，响应码${response.statusCode}");
        setState(() {
          weather = Weather.fromJson(json.decode(response.data));
          condition = weather.data.condition;
        });
      } else {
        print("请求失败，响应码${response.statusCode}");
      }
    } on DioError catch (e) {
      print("请求错误！$e");
    }
  }
}
