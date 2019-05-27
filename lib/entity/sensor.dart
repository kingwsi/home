import 'dart:convert' show json;

class SensorData {

  List<Feed> feeds;
  Channel channel;

  SensorData.fromParams({this.feeds, this.channel});

  factory SensorData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SensorData.fromJson(json.decode(jsonStr)) : new SensorData.fromJson(jsonStr);

  SensorData.fromJson(jsonRes) {
    feeds = jsonRes['feeds'] == null ? null : [];

    for (var feedsItem in feeds == null ? [] : jsonRes['feeds']){
      feeds.add(feedsItem == null ? null : new Feed.fromJson(feedsItem));
    }

    channel = jsonRes['channel'] == null ? null : new Channel.fromJson(jsonRes['channel']);
  }

  @override
  String toString() {
    return '{"feeds": $feeds,"channel": $channel}';
  }
}

class Channel {

  int id;
  int last_entry_id;
  String created_at;
  String field1;
  String field2;
  String latitude;
  String longitude;
  String name;
  String updated_at;

  Channel.fromParams({this.id, this.last_entry_id, this.created_at, this.field1, this.field2, this.latitude, this.longitude, this.name, this.updated_at});

  Channel.fromJson(jsonRes) {
    id = jsonRes['id'];
    last_entry_id = jsonRes['last_entry_id'];
    created_at = jsonRes['created_at'];
    field1 = jsonRes['field1'];
    field2 = jsonRes['field2'];
    latitude = jsonRes['latitude'];
    longitude = jsonRes['longitude'];
    name = jsonRes['name'];
    updated_at = jsonRes['updated_at'];
  }

  @override
  String toString() {
    return '{"id": $id,"last_entry_id": $last_entry_id,"created_at": ${created_at != null?'${json.encode(created_at)}':'null'},"field1": ${field1 != null?'${json.encode(field1)}':'null'},"field2": ${field2 != null?'${json.encode(field2)}':'null'},"latitude": ${latitude != null?'${json.encode(latitude)}':'null'},"longitude": ${longitude != null?'${json.encode(longitude)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"updated_at": ${updated_at != null?'${json.encode(updated_at)}':'null'}}';
  }
}

class Feed {

  int entry_id;
  String created_at;
  String field1;
  String field2;

  Feed.fromParams({this.entry_id, this.created_at, this.field1, this.field2});

  Feed.fromJson(jsonRes) {
    entry_id = jsonRes['entry_id'];
    created_at = jsonRes['created_at'];
    field1 = jsonRes['field1'];
    field2 = jsonRes['field2'];
  }

  @override
  String toString() {
    return '{"entry_id": $entry_id,"created_at": ${created_at != null?'${json.encode(created_at)}':'null'},"field1": ${field1 != null?'${json.encode(field1)}':'null'},"field2": ${field2 != null?'${json.encode(field2)}':'null'}}';
  }
}

