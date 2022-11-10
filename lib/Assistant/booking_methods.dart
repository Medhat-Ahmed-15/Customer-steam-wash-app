import 'dart:convert';

import 'package:customer_steam_wash_app/Models/availableTime.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:http/http.dart' as http;

Future<List<AvailableTime>> getAvailableTime() async {
  List<AvailableTime> availableTimesList = [];
  String url = 'https://car-spa.io/api/booking-times';

  var res = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-access-token': userAuthToken
    },
  );

  String jSonData = res.body;
  var decodeData = jsonDecode(jSonData);

  if (decodeData['accepted'] == true) {
    var availableTimeListData = decodeData['availableTimes'];

//to convert the json file which contain list of maps to normal list
    availableTimesList = (availableTimeListData as List)
        .map((index) => AvailableTime.fromjson(index))
        .toList();
  }

  return availableTimesList;
}

/////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

Future<bool> bookOrderLater() async {
  print('pickedCategory.id  ' + pickedCategory.id);
  print('pickedDay  ' + pickedDay[0]);
  print('pickedTime  ' + pickedTime[0]);
  print('pickedAddress  ' + pickedAddress.placeName);
  print('pickedAddress  ' + pickedAddress.latitude.toString());
  print('pickedAddress  ' + pickedAddress.longitude.toString());

  String url = 'https://car-spa.io/api/beta/orders/book-later/book-order';

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': userAuthToken
        },
        body: json.encode({
          "serviceID": pickedCategory.id,
          "bookDate": pickedDay[0],
          "bookTime": pickedTime[0],
          "locationName": pickedAddress.placeName,
          "longitude": pickedAddress.latitude,
          "latitude": pickedAddress.longitude
        }));

    print("reached here");

    final responseData = json.decode(response.body);

    print('response $responseData');

    if (responseData['accepted'] == true) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Check bookOrderLater ERROR: $error');
    rethrow;
  }
}
