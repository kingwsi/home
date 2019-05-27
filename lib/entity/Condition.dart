import 'dart:convert' show json;

/**
 * 实时天气
 */
class Condition {

  int code;
  Data data;

  Condition.fromParams({this.code, this.data});

  factory Condition(jsonStr) => jsonStr == null ? null : jsonStr is String ? new Condition.fromJson(json.decode(jsonStr)) : new Condition.fromJson(jsonStr);

  Condition.fromJson(jsonRes) {
    code = jsonRes['code'];
    data = jsonRes['data'] == null ? null : new Data.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": $code,"data": $data}';
  }
}

class Data {

  City city;
  Detail condition;

  Data.fromParams({this.city, this.condition});

  Data.fromJson(jsonRes) {
    city = jsonRes['city'] == null ? null : new City.fromJson(jsonRes['city']);
    condition = jsonRes['condition'] == null ? null : new Detail.fromJson(jsonRes['condition']);
  }

  @override
  String toString() {
    return '{"city": $city,"condition": $condition}';
  }
}

class Detail {

  String condition;
  String conditionId;
  String humidity;
  String icon;
  String pressure;
  String realFeel;
  String sunRise;
  String sunSet;
  String temp;
  String tips;
  String updatetime;
  String uvi;
  String vis;
  String windDegrees;
  String windDir;
  String windLevel;
  String windSpeed;

  Detail.fromParams({this.condition, this.conditionId, this.humidity, this.icon, this.pressure, this.realFeel, this.sunRise, this.sunSet, this.temp, this.tips, this.updatetime, this.uvi, this.vis, this.windDegrees, this.windDir, this.windLevel, this.windSpeed});

  Detail.fromJson(jsonRes) {
    condition = jsonRes['condition'];
    conditionId = jsonRes['conditionId'];
    humidity = jsonRes['humidity'];
    icon = jsonRes['icon'];
    pressure = jsonRes['pressure'];
    realFeel = jsonRes['realFeel'];
    sunRise = jsonRes['sunRise'];
    sunSet = jsonRes['sunSet'];
    temp = jsonRes['temp'];
    tips = jsonRes['tips'];
    updatetime = jsonRes['updatetime'];
    uvi = jsonRes['uvi'];
    vis = jsonRes['vis'];
    windDegrees = jsonRes['windDegrees'];
    windDir = jsonRes['windDir'];
    windLevel = jsonRes['windLevel'];
    windSpeed = jsonRes['windSpeed'];
  }

  @override
  String toString() {
    return '{"condition": ${condition != null?'${json.encode(condition)}':'null'},"conditionId": ${conditionId != null?'${json.encode(conditionId)}':'null'},"humidity": ${humidity != null?'${json.encode(humidity)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"pressure": ${pressure != null?'${json.encode(pressure)}':'null'},"realFeel": ${realFeel != null?'${json.encode(realFeel)}':'null'},"sunRise": ${sunRise != null?'${json.encode(sunRise)}':'null'},"sunSet": ${sunSet != null?'${json.encode(sunSet)}':'null'},"temp": ${temp != null?'${json.encode(temp)}':'null'},"tips": ${tips != null?'${json.encode(tips)}':'null'},"updatetime": ${updatetime != null?'${json.encode(updatetime)}':'null'},"uvi": ${uvi != null?'${json.encode(uvi)}':'null'},"vis": ${vis != null?'${json.encode(vis)}':'null'},"windDegrees": ${windDegrees != null?'${json.encode(windDegrees)}':'null'},"windDir": ${windDir != null?'${json.encode(windDir)}':'null'},"windLevel": ${windLevel != null?'${json.encode(windLevel)}':'null'},"windSpeed": ${windSpeed != null?'${json.encode(windSpeed)}':'null'}}';
  }
}

class City {

  int cityId;
  String counname;
  String ianatimezone;
  String name;
  String pname;
  String secondaryname;
  String timezone;

  City.fromParams({this.cityId, this.counname, this.ianatimezone, this.name, this.pname, this.secondaryname, this.timezone});

  City.fromJson(jsonRes) {
    cityId = jsonRes['cityId'];
    counname = jsonRes['counname'];
    ianatimezone = jsonRes['ianatimezone'];
    name = jsonRes['name'];
    pname = jsonRes['pname'];
    secondaryname = jsonRes['secondaryname'];
    timezone = jsonRes['timezone'];
  }

  @override
  String toString() {
    return '{"cityId": $cityId,"counname": ${counname != null?'${json.encode(counname)}':'null'},"ianatimezone": ${ianatimezone != null?'${json.encode(ianatimezone)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"pname": ${pname != null?'${json.encode(pname)}':'null'},"secondaryname": ${secondaryname != null?'${json.encode(secondaryname)}':'null'},"timezone": ${timezone != null?'${json.encode(timezone)}':'null'}}';
  }
}
