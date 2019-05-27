import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailDialog extends Dialog {
  String date;
  String title;
  String detail;

  DetailDialog({Key key, this.title, this.detail, this.date}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: new SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
            child: new Opacity(
                opacity: 0.6,
                child: Container(
                  decoration: ShapeDecoration(
                    color: const Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: new TextStyle(fontSize: 14.0),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: new Text(
                          date,
                          style: new TextStyle(fontSize: 14.0),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: new Text(
                          detail,
                          style: new TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ),
            )
        ),
      ),
    );
  }
}
