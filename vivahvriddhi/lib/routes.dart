import 'package:flutter/cupertino.dart';
import 'package:vivahvriddhi/loginscreen/login.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen1.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen2.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen3.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen4.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen5.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen6.dart';
import 'package:vivahvriddhi/splashscreen/splashscreen.dart';
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LogIn.routeName: (context) => LogIn(),
  RegistrationScreen1.routeName:(context) => RegistrationScreen1(),
  RegistrationScreen2.routeName:(context) => RegistrationScreen2(),
  RegistrationScreen3.routeName:(context) => RegistrationScreen3(),
  RegistrationScreen4.routeName:(context) => RegistrationScreen4(),
  RegistrationScreen5.routeName:(context) => RegistrationScreen5(),
  RegistrationScreen6.routeName:(context) => RegistrationScreen6(),
  // RegistrationScreen7.routeName:(context) => RegistrationScreen7(),
  // SubscriptionsTab.routeName:(context) => SubscriptionsTab()
  //
};


