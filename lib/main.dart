import 'package:customer_steam_wash_app/Providers/auth_provider.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/changeLanguage_screen.dart';
import 'package:customer_steam_wash_app/Screens/changeNameSettong_screen.dart';
import 'package:customer_steam_wash_app/Screens/changePhoneSetting_screen.dart';
import 'package:customer_steam_wash_app/Screens/completeProfile_screen.dart';
import 'package:customer_steam_wash_app/Screens/congratulations_screen.dart';
import 'package:customer_steam_wash_app/Screens/createNewPassword_screen.dart';
import 'package:customer_steam_wash_app/Screens/easyToUse_screen.dart';
import 'package:customer_steam_wash_app/Screens/forgotPassword_screen.dart';
import 'package:customer_steam_wash_app/Screens/historyOrders_screen.dart';
import 'package:customer_steam_wash_app/Screens/map_screen.dart';
import 'package:customer_steam_wash_app/Screens/noPackages_screen.dart';
import 'package:customer_steam_wash_app/Screens/noPromoCode_screen.dart';
import 'package:customer_steam_wash_app/Screens/packages_screen.dart';
import 'package:customer_steam_wash_app/Screens/pickedPackageScreen.dart';
import 'package:customer_steam_wash_app/Screens/promoCode_screen.dart';
import 'package:customer_steam_wash_app/Screens/saveMoney_screen.dart';
import 'package:customer_steam_wash_app/Screens/saveTime_screen.dart';
import 'package:customer_steam_wash_app/Screens/scheduledOrders_screen.dart';
import 'package:customer_steam_wash_app/Screens/settings_screen.dart';
import 'package:customer_steam_wash_app/Screens/signin_screen.dart';
import 'package:customer_steam_wash_app/Screens/signup_screen.dart';
import 'package:customer_steam_wash_app/Screens/tabs_screen.dart';
import 'package:customer_steam_wash_app/Screens/termsAndConditions_screen.dart';
import 'package:customer_steam_wash_app/Screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Screens/splash_screen.dart';

void main() {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Providing all Theme Colors Data
        ChangeNotifierProvider(
          create: (context) => ColorProvider(),
        ),

        //Providing Auth Data
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProviderObj, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor:
                const Color.fromRGBO(33, 147, 176, 255).withOpacity(1),
            backgroundColor: Colors.white,
            accentColor: Colors.white,
          ),
          home: authProviderObj.checkauthentication() == true
              ? MapScreen()
              : FutureBuilder(
                  future: authProviderObj.tryAutoSignIn(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : SigninScreen()),
          routes: {
            SigninScreen.routName: (ctx) => SigninScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
            CompleteProfileScreen.routeName: (ctx) => CompleteProfileScreen(),
            VerificationScreen.routeName: (ctx) => VerificationScreen(),
            ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
            CreateNewPasswordScreen.routeName: (ctx) =>
                CreateNewPasswordScreen(),
            CongratulationsScreen.routeName: (ctx) => CongratulationsScreen(),
            SaveTimeScreen.routeName: (ctx) => SaveTimeScreen(),
            SaveMoneyScreen.routeName: (ctx) => SaveMoneyScreen(),
            EasyToUseScreen.routeName: (ctx) => EasyToUseScreen(),
            MapScreen.routeName: (ctx) => MapScreen(),
            TabsScreen.routName: (ctx) => TabsScreen(),
            HistoryOrdersScreen.routeName: (ctx) => HistoryOrdersScreen(),
            ScheduledOrdersScreen.routeName: (ctx) => ScheduledOrdersScreen(),
            PackagesScreen.routeName: (ctx) => PackagesScreen(),
            PickedPackageScreen.routeName: (ctx) => PickedPackageScreen(),
            NoPackagesScreen.routeName: (ctx) => NoPackagesScreen(),
            NoPromoCodeScreen.routeName: (ctx) => NoPromoCodeScreen(),
            PromoCodeScreen.routeName: (ctx) => PromoCodeScreen(),
            SettingsScreen.routeName: (ctx) => SettingsScreen(),
            ChangeNameSettingScreen.routeName: (ctx) =>
                ChangeNameSettingScreen(),
            ChangePhoneSettingScreen.routeName: (ctx) =>
                ChangePhoneSettingScreen(),
            ChangeLanguageScreen.routeName: (ctx) => ChangeLanguageScreen(),
            TermsAndConditionsScreen.routeName: (ctx) =>
                TermsAndConditionsScreen(),
          },
        ),
      ),
    );
  }
}
