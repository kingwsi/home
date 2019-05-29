import 'dart:convert' show json;

class Weather {
  int code;
  String msg;
  Data data;

  Weather.fromParams({this.code, this.msg, this.data});

  factory Weather(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Weather.fromJson(json.decode(jsonStr))
          : new Weather.fromJson(jsonStr);

  Weather.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : new Data.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null ? '${json.encode(msg)}' : 'null'},"data": $data}';
  }
}

class Data {
  List<Hourly> hourly;
  City city;
  Condition condition;

  Data.fromParams({this.hourly, this.city, this.condition});

  Data.fromJson(jsonRes) {
    hourly = jsonRes['hourly'] == null ? null : [];

    for (var hourlyItem in hourly == null ? [] : jsonRes['hourly']) {
      hourly.add(hourlyItem == null ? null : new Hourly.fromJson(hourlyItem));
    }

    condition = jsonRes['condition'] == null? null : new Condition.fromJson(jsonRes['condition']);

    city = jsonRes['city'] == null ? null : new City.fromJson(jsonRes['city']);
  }

  @override
  String toString() {
    return '{"hourly": $hourly,"city": $city,"condition": $condition}';
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

  City.fromParams(
      {this.cityId,
      this.counname,
      this.ianatimezone,
      this.name,
      this.pname,
      this.secondaryname,
      this.timezone});

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
    return '{"cityId": $cityId,"counname": ${counname != null ? '${json.encode(counname)}' : 'null'},"ianatimezone": ${ianatimezone != null ? '${json.encode(ianatimezone)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"pname": ${pname != null ? '${json.encode(pname)}' : 'null'},"secondaryname": ${secondaryname != null ? '${json.encode(secondaryname)}' : 'null'},"timezone": ${timezone != null ? '${json.encode(timezone)}' : 'null'}}';
  }
}

class Condition {
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

  Condition.fromParams(
      {this.condition,
      this.conditionId,
      this.humidity,
      this.icon,
      this.pressure,
      this.realFeel,
      this.sunRise,
      this.sunSet,
      this.temp,
      this.tips,
      this.updatetime,
      this.uvi,
      this.vis,
      this.windDegrees,
      this.windDir,
      this.windLevel,
      this.windSpeed});

  factory Condition(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Condition.fromJson(json.decode(jsonStr))
          : new Condition.fromJson(jsonStr);

  Condition.fromJson(jsonRes) {
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
    return '{"condition": ${condition != null ? '${json.encode(condition)}' : 'null'},"conditionId": ${conditionId != null ? '${json.encode(conditionId)}' : 'null'},"humidity": ${humidity != null ? '${json.encode(humidity)}' : 'null'},"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"pressure": ${pressure != null ? '${json.encode(pressure)}' : 'null'},"realFeel": ${realFeel != null ? '${json.encode(realFeel)}' : 'null'},"sunRise": ${sunRise != null ? '${json.encode(sunRise)}' : 'null'},"sunSet": ${sunSet != null ? '${json.encode(sunSet)}' : 'null'},"temp": ${temp != null ? '${json.encode(temp)}' : 'null'},"tips": ${tips != null ? '${json.encode(tips)}' : 'null'},"updatetime": ${updatetime != null ? '${json.encode(updatetime)}' : 'null'},"uvi": ${uvi != null ? '${json.encode(uvi)}' : 'null'},"vis": ${vis != null ? '${json.encode(vis)}' : 'null'},"windDegrees": ${windDegrees != null ? '${json.encode(windDegrees)}' : 'null'},"windDir": ${windDir != null ? '${json.encode(windDir)}' : 'null'},"windLevel": ${windLevel != null ? '${json.encode(windLevel)}' : 'null'},"windSpeed": ${windSpeed != null ? '${json.encode(windSpeed)}' : 'null'}}';
  }
}

class Hourly {
  String condition;
  String conditionId;
  String date;
  String hour;
  String humidity;
  String iconDay;
  String iconNight;
  String pop;
  String pressure;
  String qpf;
  String realFeel;
  String snow;
  String temp;
  String updatetime;
  String uvi;
  String windDegrees;
  String windDir;
  String windSpeed;
  String windlevel;

  Hourly.fromParams(
      {this.condition,
      this.conditionId,
      this.date,
      this.hour,
      this.humidity,
      this.iconDay,
      this.iconNight,
      this.pop,
      this.pressure,
      this.qpf,
      this.realFeel,
      this.snow,
      this.temp,
      this.updatetime,
      this.uvi,
      this.windDegrees,
      this.windDir,
      this.windSpeed,
      this.windlevel});

  Hourly.fromJson(jsonRes) {
    condition = jsonRes['condition'];
    conditionId = jsonRes['conditionId'];
    date = jsonRes['date'];
    hour = jsonRes['hour'];
    humidity = jsonRes['humidity'];
    iconDay = jsonRes['iconDay'];
    iconNight = jsonRes['iconNight'];
    pop = jsonRes['pop'];
    pressure = jsonRes['pressure'];
    qpf = jsonRes['qpf'];
    realFeel = jsonRes['realFeel'];
    snow = jsonRes['snow'];
    temp = jsonRes['temp'];
    updatetime = jsonRes['updatetime'];
    uvi = jsonRes['uvi'];
    windDegrees = jsonRes['windDegrees'];
    windDir = jsonRes['windDir'];
    windSpeed = jsonRes['windSpeed'];
    windlevel = jsonRes['windlevel'];
  }

  @override
  String toString() {
    return '{"condition": ${condition != null ? '${json.encode(condition)}' : 'null'},"conditionId": ${conditionId != null ? '${json.encode(conditionId)}' : 'null'},"date": ${date != null ? '${json.encode(date)}' : 'null'},"hour": ${hour != null ? '${json.encode(hour)}' : 'null'},"humidity": ${humidity != null ? '${json.encode(humidity)}' : 'null'},"iconDay": ${iconDay != null ? '${json.encode(iconDay)}' : 'null'},"iconNight": ${iconNight != null ? '${json.encode(iconNight)}' : 'null'},"pop": ${pop != null ? '${json.encode(pop)}' : 'null'},"pressure": ${pressure != null ? '${json.encode(pressure)}' : 'null'},"qpf": ${qpf != null ? '${json.encode(qpf)}' : 'null'},"realFeel": ${realFeel != null ? '${json.encode(realFeel)}' : 'null'},"snow": ${snow != null ? '${json.encode(snow)}' : 'null'},"temp": ${temp != null ? '${json.encode(temp)}' : 'null'},"updatetime": ${updatetime != null ? '${json.encode(updatetime)}' : 'null'},"uvi": ${uvi != null ? '${json.encode(uvi)}' : 'null'},"windDegrees": ${windDegrees != null ? '${json.encode(windDegrees)}' : 'null'},"windDir": ${windDir != null ? '${json.encode(windDir)}' : 'null'},"windSpeed": ${windSpeed != null ? '${json.encode(windSpeed)}' : 'null'},"windlevel": ${windlevel != null ? '${json.encode(windlevel)}' : 'null'}}';
  }
}
