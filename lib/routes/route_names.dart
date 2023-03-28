import 'package:flutter/material.dart';
import 'package:hotel_booking/models/hotel_list_data.dart';
import 'package:hotel_booking/modules/hotel_booking/filter_screen/filters_screen.dart';
import 'package:hotel_booking/modules/hotel_details/hotel_details.dart';
import 'package:hotel_booking/modules/hotel_details/room_booking_screen.dart';
import 'package:hotel_booking/modules/hotel_details/search_screen.dart';
import 'package:hotel_booking/modules/login/login_Screen.dart';
import 'package:hotel_booking/modules/login/sign_up_Screen.dart';
import 'package:hotel_booking/routes/routes.dart';

import '../modules/bottom_tab/bottomTabScreen.dart';
import '../modules/hotel_booking/hotel_home_screen.dart';
import '../modules/login/forgot_password.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog: false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  void gotoSplashScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.Splash, (Route<dynamic> route) => false);
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.IntroductionScreen,
        (Route<dynamic> route) => false);
  }
  
  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(LoginScreen());
  }

  Future<dynamic> gotoForgotPasswordScreen() async {
    return await _pushMaterialPageRoute(ForgotPassword());
  }

  Future<dynamic> gotoSignUpScreen() async {
    return await _pushMaterialPageRoute(SignUpScreen());
  }

  Future<dynamic> gotoBottomTabScreen() async {
    return await _pushMaterialPageRoute(BottomTabScreen());
  }

  Future<dynamic> gotoSearchScreen() async {
    return await _pushMaterialPageRoute(SearchScreen());
  }

  Future<dynamic> gotoHotelHomeScreen() async {
    return await _pushMaterialPageRoute(HotelHomeScreen());
  }
  
  Future<dynamic> gotoFillerScreen() async {
    return await _pushMaterialPageRoute(FiltterScreen());
  }

  Future<dynamic> gotoRoomBookingScreen(String hotelName) async {
    return await _pushMaterialPageRoute(RoomBookingScreen(
        hotelName: hotelName,
    ));
  }

  Future<dynamic> gotoHotelDetails(HotelListData hotelData) async {
    return await _pushMaterialPageRoute(HotelDetailes(
        hotelData:hotelData,
    ));
  }

}
