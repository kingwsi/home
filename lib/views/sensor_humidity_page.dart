import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home/entity/sensor.dart';
import 'package:home/widget/bottom_sheet.dart';
import 'package:home/widget/list_view_item.dart';
import 'package:home/widget/sensor_tick.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SensorHumidityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SensorHumidityPageState();
  }
}

class _SensorHumidityPageState extends State<SensorHumidityPage> {
  SensorData sensorData;
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    _getData(
        "https://api.thingspeak.com/channels/784382/feeds.json?timezone=Asia%2FShanghai");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return sensorData == null
        ? SpinKitSpinningCircle(
            color: Colors.white,
          )
        : ListView(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ListTile(
                      title: Text(
                        "湿度",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new ListTile(
                                      leading: new Icon(Icons.photo_camera),
                                      title: new Text("Camera"),
                                      onTap: () async {
                                        _switchDayChart();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    new ListTile(
                                      leading: new Icon(Icons.photo_library),
                                      title: new Text("Gallery"),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        _switchWeekDayChart();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.menu),
                      )),
                ),
              ),
              Center(
                child: Container(
                    constraints: new BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: SensorTick(
                      data: _createSampleData(),
                      unit: "%",
                    )),
              ),
              // list
              Center(
                child: Container(
                    constraints: new BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: sensorData == null
                        ? SpinKitThreeBounce(
                            color: Colors.white,
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              return ListViewItem(
                                  feed: sensorData.feeds[index]);
                            },
                            itemCount: sensorData.feeds.length)),
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
        measureFn: (Feed feed, _) => double.parse(feed.field2),
        data: sensorData.feeds,
      )
    ];
  }

  _getData(url) async {
    Dio dio = new Dio();
    try {
      var response = await dio.get<String>(url);
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

  _switchDayChart() {
    _getData(
        "https://api.thingspeak.com/channels/784382/feeds.json?api_key=HLV9U3YT83F0HJ9T&average=1440&round=2&timezone=Asia%2FShanghai");
  }

  _switchWeekDayChart() {
    _getData("https://api.thingspeak.com/channels/784382/feeds.json?api_key=HLV9U3YT83F0HJ9T&days=7&average=1440&round=2&timezone=Asia%2FShanghai");
  }
}
