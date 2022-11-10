import 'dart:convert';

import 'package:customer_steam_wash_app/Models/placePridictions.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:http/http.dart' as http;

Future<bool> checkValidEmail(String email) async {
  print('emaiwwwwwl $email');
  String url = 'https://car-spa.io/api/auth/customers/check-email';

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
        }));

    final responseData = json.decode(response.body);

    print('message ${responseData['message']}');

    if (responseData['accepted'] == true) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Check Valid Email ERROR: $error');
    rethrow;
  }
}

////////////////////////////////////////////////////////////////////////////////

Future<bool> checkValidPhone(String phone) async {
  String url = 'https://car-spa.io/api/auth/check-phone-number';

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "phoneNumber": phone,
        }));

    final responseData = json.decode(response.body);

    if (responseData['accepted'] == true) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Check Valid Phone ERROR: $error');
    rethrow;
  }
}

Future<bool> checkVerificationCOde(String code) async {
  String url = 'https://car-spa.io/api/auth/customers/check-verification-code';

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "phoneNumber": '+2' + currentCustomerData.phoneNumber,
          "code": code
        }));

    final responseData = json.decode(response.body);

    if (responseData['accepted'] == true) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Check Valid Code ERROR: $error');
    rethrow;
  }
}
