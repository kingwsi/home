import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:home/entity/sensor.dart';
import 'package:home/widget/detail_dialog.dart';

class SensorTick extends StatefulWidget {

  final String unit;

  final List<charts.Series<Feed, DateTime>> data;

  const SensorTick({Key key, this.data, this.unit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SensorTickState();
  }
}

class _SensorTickState extends State<SensorTick> {
  @override
  Widget build(BuildContext context) {
    _onSelectionChanged(data) {
      Feed feed = data.selectedDatum[0].datum;
      showDialog<Null>(
          context: context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new DetailDialog(
              title: "详情",
              date: feed.created_at,
              detail: feed.field1 + widget.unit,
            );
          });
    }

    return charts.TimeSeriesChart(
      widget.data,
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
              zeroBound: false, dataIsInWholeNumbers: false)),
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
              minute: new charts.TimeFormatterSpec(
                  format: 'm', transitionFormat: 'hh:mm:ss'))),
      selectionModels: [
        // 设置点击选中事件
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
    );
  }
}
