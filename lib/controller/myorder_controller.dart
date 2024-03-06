// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:deliveryboy/Api/Config.dart';
import 'package:deliveryboy/Api/data_store.dart';
import 'package:deliveryboy/model/order_info.dart';
import 'package:deliveryboy/model/orderinformetion_info.dart';
import 'package:deliveryboy/utils/Custom_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyOrderController extends GetxController implements GetxService {
  OrderInfo? orderInfo;
  OrderInformetionInfo? orderInformetionInfo;
  bool isLoading = false;

  myOrderHistory({String? statusWise}) async {
    try {
      Map map = {
        "rider_id": getData.read("StoreLogin")["id"],
        "status": statusWise,
      };
      Uri uri = Uri.parse(Config.baseUrl + Config.myOrderApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        orderInfo = OrderInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  crOrderHistory({String? statusWise}) async {
    try {
      Map map = {
        "rider_id": getData.read("StoreLogin")["id"],
        "status": statusWise,
      };
      Uri uri = Uri.parse(Config.baseUrl + Config.myOrderApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        orderInfo = OrderInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getOrderInformetion({String? orderID}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "order_id": orderID,
        "rider_id": getData.read("StoreLogin")["id"],
      };
      Uri uri = Uri.parse(Config.baseUrl + Config.orderInformetion);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        orderInformetionInfo = OrderInformetionInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  mackDecisionApi({String? orderID, status, reson}) async {
    try {
      Map map = {
        "oid": orderID,
        "rider_id": getData.read("StoreLogin")["id"],
        "status": status,
        "comment_reject": reson,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseUrl + Config.makeDecision);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("****************" + response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        showToastMessage(result["ResponseMsg"]);
      }
      getOrderInformetion(orderID: orderID);
      crOrderHistory(statusWise: "MyOrder");
      update();
    } catch (e) {
      print(e.toString());
    }
  }
  completeOrderApi({String? orderID, image}) async {
    try {
      Map map = {
        "order_id": orderID,
        "rider_id": getData.read("StoreLogin")["id"],
        // "img": image,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseUrl + Config.completeOrder);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("****************" + response.body.toString());
      // showToastMessage(response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        showToastMessage(result["ResponseMsg"]);
        Dialogbox();
        getOrderInformetion(orderID: orderID);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
