import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home/entity/weather.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:home/widget/detail_dialog.dart';

class HourWeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HourWeatherState();
  }
}

class _HourWeatherState extends State<HourWeatherPage> {
  Weather weather;

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
                child: Container(
                    constraints: new BoxConstraints.expand(
                      height: 200.0,
                    ),
                    child: BuildTick(
                      data: _createSampleData(),
                    )),
              ),
            ],
          );
  }

  @override
  void initState() {
    _initData();
  }

  _initData() async {
    FormData data = new FormData.from(
        {"cityId": "1185", "token": "008d2ad9197090c5dddc76f583616606"});
    Dio dio = new Dio();
    try {
      Options options = Options(headers: {
        "Authorization": "APPCODE 9ac68038cf2240c1aff45006b915679e"
      });
      var response = await dio.post<String>(
          "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours",
          options: options,
          data: data);
      if (response.statusCode == 200) {
        print("请求成功，响应码${response.statusCode}");
        setState(() {
          weather = Weather.fromJson(json.decode(response.data));
        });
      } else {
        print("请求失败，响应码${response.statusCode}");
      }
    } on DioError catch (e) {
      print("请求错误！$e");
    }
  }

  List<charts.Series<Hourly, DateTime>> _createSampleData() {
    return [
      new charts.Series<Hourly, DateTime>(
        id: 'Cost',
        colorFn: (_, __) => charts.MaterialPalette.white,
        domainFn: (Hourly hourly, _) {
          DateTime day = DateTime.parse(hourly.date);
          return new DateTime(
              day.year, day.month, day.day, int.parse(hourly.hour));
        },
        measureFn: (Hourly hourly, _) => double.parse(hourly.temp),
        data: weather.data.hourly,
      )
    ];
  }
}

class BuildTick extends StatelessWidget {
  final List<charts.Series<Hourly, DateTime>> data;

  const BuildTick({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _tickListener(data) {
      Hourly hourly = data.selectedDatum[0].datum;
      showDialog<Null>(
          context: context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new DetailDialog(
              title: "温度详情",
              date: hourly.date+""+hourly.hour+"00:00",
              detail: hourly.temp+"℃",
            );
          });
    }

    return charts.TimeSeriesChart(
      data,
      animate: true,
      defaultRenderer: charts.LineRendererConfig(
        // 折线图绘制的配置
        includeArea: true,
        includePoints: false,
        includeLine: true,
        stacked: false,
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          showAxisLine: false, // 显示轴线
          renderSpec: charts.SmallTickRendererSpec(
            // 主轴绘制的配置
            tickLengthPx: 0, // 刻度标识突出的长度
            labelOffsetFromAxisPx: 12, // 刻度文字距离轴线的位移
            labelStyle: charts.TextStyleSpec(
              // 刻度文字的样式
              color: charts.Color.white,
              fontSize: 10,
            ),
            axisLineStyle: charts.LineStyleSpec(
                // 轴线的样式
                color: charts.Color.white),
          ),
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
              desiredTickCount: 5,
              zeroBound: false,
              dataIsInWholeNumbers: false)),
      domainAxis: new charts.DateTimeAxisSpec(
        showAxisLine: false, // 显示轴线
        renderSpec: charts.SmallTickRendererSpec(
          // 主轴绘制的配置
          tickLengthPx: 0, // 刻度标识突出的长度
          labelOffsetFromAxisPx: 12, // 刻度文字距离轴线的位移
          labelStyle: charts.TextStyleSpec(
            // 刻度文字的样式
            color: charts.Color.white,
            fontSize: 10,
          ),
          axisLineStyle: charts.LineStyleSpec(
              // 轴线的样式
              color: charts.Color.white),
        ),
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
            hour: new charts.TimeFormatterSpec(
                format: 'h', transitionFormat: 'yyyy/MM/dd hh')),
      ),
      selectionModels: [
        // 设置点击选中事件
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _tickListener,
        )
      ],
    );
  }
}
