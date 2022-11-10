import 'dart:async';
import 'dart:convert';
import 'package:customer_steam_wash_app/Models/UserInfo.dart';
import 'package:customer_steam_wash_app/Models/loginCustomer_httpException.dart';
import 'package:customer_steam_wash_app/Models/registerCustomer_httpException.dart';
import 'package:customer_steam_wash_app/Models/sms_httpException.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _token;

//Checking Authentication Function>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  bool checkauthentication() {
    if (_token != null) {
      print('reached here');
      return true;
    }
    return false;
  }

  //Function for getting the TOKEN,i may need the token from  somewhere else
  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  //Register Customer>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<void> registerCustomer() async {
    String registerUrl = 'https://car-spa.io/api/auth/customers/sign-up';
    String sendSMSUrl =
        'https://car-spa.io/api/auth/customers/phone-number/verification-code';

    try {
      final smsResponse = await http.post(
        sendSMSUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {"customerPhoneNumber": '+2' + userPhone},
        ),
      );

      final smsResponseData = json.decode(smsResponse.body);

      if (smsResponseData['accepted'] != true) {
        throw SMSHttpException('error sending verification code');
      }

      final response = await http.post(registerUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "customerName": userName,
            "customerEmail": userEmail,
            "customerPassword": userPassword,
            "customerConfirmPassword": userPassword,
            "customerPhoneNumber": userPhone,
          }));

      final responseData = json.decode(response.body);

      if (responseData['accepted'] != true) {
        throw registerCustomerHttpException(responseData);
      }

      _token = responseData['token'];
      userAuthToken = responseData['token'];

      UserInfo userInfo = UserInfo();
      userInfo.userName = responseData['customer']['username'];
      userInfo.userId = responseData['customer']['id'];
      userInfo.email = responseData['customer']['email'];
      userInfo.password = responseData['customer']['password'];
      userInfo.phoneNumber = responseData['customer']['phonenumber'];
      userInfo.accountCreationDate =
          responseData['customer']['accountcreationdate'];

      currentCustomerData = userInfo;

      final prefs = await SharedPreferences.getInstance();

      final customerData = json.encode({
        'token': _token,
        'userName': userInfo.userName,
        'userId': userInfo.userId,
        'email': userInfo.email,
        'password': userInfo.password,
        'phoneNumber': userInfo.phoneNumber,
        'accountCreationDate': userInfo.accountCreationDate,
      });

      prefs.setString('customerData', customerData);
    } catch (error) {
      print('Register Customer ERROR: $error');
      throw error;
    }
  }

  //Login Customer>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<void> loginCustomerWithEmailAndPassword(
      String email, String password) async {
    String url = 'https://car-spa.io/api/auth/customers/login';

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'customerEmail': email,
            'customerPassword': password,
          },
        ),
      );

      final responseData = json.decode(response.body);

      print('message: ${responseData['message']}');
      print('accepted: ${responseData['accepted']}');

      if (responseData['accepted'] != true) {
        throw loginCustomerHttpException(responseData);
      }

      _token = responseData['token'];
      userAuthToken = responseData['token'];

      notifyListeners();

      UserInfo userInfo = UserInfo();
      userInfo.userName = responseData['customer']['username'];
      userInfo.userId = responseData['customer']['id'];
      userInfo.email = responseData['customer']['email'];
      userInfo.password = responseData['customer']['password'];
      userInfo.phoneNumber = responseData['customer']['phonenumber'];
      userInfo.accountCreationDate =
          responseData['customer']['accountcreationdate'];

      currentCustomerData = userInfo;

      final prefs = await SharedPreferences.getInstance();

      final customerData = json.encode({
        'token': _token,
        'userName': userInfo.userName,
        'userId': userInfo.userId,
        'email': userInfo.email,
        'password': userInfo.password,
        'phoneNumber': userInfo.phoneNumber,
        'accountCreationDate': userInfo.accountCreationDate,
      });

      prefs.setString('customerData', customerData);
    } catch (error) {
      print('Login Customer ERROR: $error');
      throw error;
    }
  }

  //Auto Sigin>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<bool> tryAutoSignIn() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('customerData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('customerData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    userAuthToken = extractedUserData['token'];

    notifyListeners();

    UserInfo userInfo = UserInfo();
    userInfo.userName = extractedUserData['userName'];
    userInfo.userId = extractedUserData['userId'];
    userInfo.email = extractedUserData['email'];
    userInfo.password = extractedUserData['password'];
    userInfo.phoneNumber = extractedUserData['phoneNumber'];
    userInfo.accountCreationDate = extractedUserData['accountCreationDate'];

    currentCustomerData = userInfo;

    return true;
  }

  //Signout Function>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<void> SignOut() async {
    _token = null;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    prefs.remove('customerData');
  }
}
