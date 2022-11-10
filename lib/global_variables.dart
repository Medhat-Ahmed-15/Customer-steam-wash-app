import 'package:customer_steam_wash_app/Models/UserInfo.dart';
import 'package:customer_steam_wash_app/Models/availableTime.dart';
import 'package:customer_steam_wash_app/Models/categoryBlueprint.dart';
import 'package:customer_steam_wash_app/Models/prevLocations.dart';
import 'package:customer_steam_wash_app/Models/promoCodeDetails.dart';

import 'Models/address.dart';
import 'Models/placePridictions.dart';

String key = 'AIzaSyDQ3YKGLH2oaNycSa9HmZitVeUxtZbIEVQ';

String userEmail;
String userPassword;
String userName;
String userPhone;
String userAuthToken;

UserInfo currentCustomerData;

List<String> pickedDay = [];
List<String> pickedTime = [];

Address pickedAddress;
PrevLocations pickedPrevLoc;

CategoryBlueprint pickedCategory;

PromoCodeDetails pickedPromoCode;
