import 'dart:convert';

import 'package:customer_steam_wash_app/Models/address.dart';
import 'package:customer_steam_wash_app/Models/placePridictions.dart';
import 'package:customer_steam_wash_app/Models/prevLocations.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getRequest(String url) async {
  try {
    var response = await http.get(url);

    print('from here');
    print(response.body);

    if (response.statusCode == 200) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      return decodeData;
    } else {
      return "failed";
    }
  } catch (exp) {
    return "failed";
  }
}

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
Future<List<PlacePredictions>> findNearByPlaces(String placeName) async {
  List<PlacePredictions> placesList = [];
  if (placeName.length > 1) {
    String autoCompleteUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$key&sessiontoken=1234567890&components=country:eg';

    var res = await getRequest(autoCompleteUrl);

    if (res['status'] == 'OK') {
      var predictions = res['predictions'];

      placesList = (predictions as List)
          .map((index) => PlacePredictions.fromjson(index))
          .toList();
    }
  }

  return placesList;
}

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
Future<void> getPickedAddressDetaila(String placeId) async {
  String placeDetailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

  var res = await getRequest(placeDetailsUrl);

  if (res == 'failed') {
    return 'failed';
  }

  if (res['status'] == 'OK') {
    Address address = Address();
    address.placeName = res['result']['name'];
    address.placeId = placeId;
    address.latitude = res['result']['geometry']['location']['lat'];
    address.longitude = res['result']['geometry']['location']['lng'];

    pickedAddress = address;
  }
}

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
Future<List<PrevLocations>> getCustomerPrevLocations() async {
  List<PrevLocations> placesList = [];
  String url =
      'https://car-spa.io/api/customers/${currentCustomerData.userId}/done-orders/location';

  print('tokenn $userAuthToken');

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
    var prevLocations = decodeData['previousLocations'];

//to convert the json file which contain list of maps to normal list
    placesList = (prevLocations as List)
        .map((index) => PrevLocations.fromjson(index))
        .toList();
  }

  return placesList;
}
