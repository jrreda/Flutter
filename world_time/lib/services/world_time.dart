import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart' as intl;

class WorldTime {

  String location; // location name for UI
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  String time; // the time in that location
  bool isDaytime; // true or false if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {
      // make the request
      http.Response response = await http.get(Uri.https("worldtimeapi.org", "api/timezone/$url"));
      Map data = jsonDecode(response.body);

      // get properties from json
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = (now.hour > 6 && now.hour < 19) ? true : false;
      time = intl.DateFormat.jm().format(now);
    }
    catch (e) {
      print(e);
      time = 'could not get time';
    }

  }
}

// WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
