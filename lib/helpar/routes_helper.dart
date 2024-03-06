// ignore_for_file: prefer_const_constructors

import 'package:deliveryboy/onbording_screen.dart';
import 'package:deliveryboy/screen/myorder_screen.dart';
import 'package:deliveryboy/screen/orderdetails_screen.dart';
import 'package:deliveryboy/screen/priscription_order.dart';
import 'package:deliveryboy/screen/priscriptiondetails_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String initial = "/";
  static String myBookingScreen = "/myBookingScreen";
  static String orderDetailsScreen = "/orderDetailsScreen";
  static String myPriscriptionOrder = "/MyPriscriptionOrder";
  static String myPriscriptionInfo = "/MyPriscriptionInfo";
}

final getPages = [
  GetPage(
    name: Routes.initial,
    page: () => onbording(),
  ),
  GetPage(
    name: Routes.myBookingScreen,
    page: () => MyBookingScreen(isBack: "1"),
  ),
  GetPage(
    name: Routes.orderDetailsScreen,
    page: () => OrderDetailsScreen(),
  ),
  GetPage(
    name: Routes.myPriscriptionOrder,
    page: () => MyPriscriptionOrder(isBack: "1"),
  ),
  GetPage(
    name: Routes.myPriscriptionInfo,
    page: () => MyPriscriptionInfo(),
  ),
];
