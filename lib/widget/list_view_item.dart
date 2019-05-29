import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/entity/sensor.dart';
import 'package:date_format/date_format.dart';

class ListViewItem extends StatelessWidget {
  final Feed feed;

  const ListViewItem({Key key, this.feed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // _launchURL(itemUrl, context);
//        Application.router.navigateTo(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(itemTitle)}&url=${Uri.encodeComponent(itemUrl)}');
        print("onclick item");
      },
      title: Padding(
        child: Text(
          feed.field1,
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        padding: EdgeInsets.only(top: 10.0),
      ),
      subtitle: Row(
        children: <Widget>[
          Padding(
            child: Text(formatDate(DateTime.parse(feed.created_at), [yyyy, '-', mm, '-', dd, ' ', hh,':',MM,':',ss]),
                style: TextStyle(color: Colors.white, fontSize: 10.0)),
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          )
        ],
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    );
  }
}
