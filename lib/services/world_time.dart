import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // location name for UI
  late String time; // the time in that loc
  late String flag; // url to an asset flag
  late String url; // loc url for api endpoint
  late bool isDaytime; // true or false for day time

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try{
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      // create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // set time prop
      isDaytime = now.hour > 6 && now.hour < 20  ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Could not get time';
    }

  }

}