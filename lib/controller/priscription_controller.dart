// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:deliveryboy/Api/Config.dart';
import 'package:deliveryboy/Api/data_store.dart';
import 'package:deliveryboy/model/preDetails_info.dart';
import 'package:deliveryboy/model/priscription_info.dart';
import 'package:deliveryboy/utils/Custom_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PreScriptionControllre extends GetxController implements GetxService {
  PriscriptionInfo? priscriptionInfo;
  PreDetailsInfo? preDetailsInfo;
  bool isLoading = false;

  myPriscriptionOrderHistory({String? statusWise}) async {
    try {
      isLoading = false;

      Map map = {
        "rider_id": getData.read("StoreLogin")["id"],
        "status": statusWise,
      };
      Uri uri = Uri.parse(Config.baseUrl + Config.priscriptionHistory);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(":::::::++++++" + response.body.toString());
      // showToastMessage(response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(":::::::++++++" + result.toString());

        priscriptionInfo = PriscriptionInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  myPriscriptionInformetion({String? oID}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "rider_id": getData.read("StoreLogin")["id"],
        "order_id": oID,
      };
      Uri uri = Uri.parse(Config.baseUrl + Config.priscriptionInformetion);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      // showToastMessage(response.body.toString());
      print("!!!!!!!!!!!!!!" + response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("!!!!!!!!!!!!!!" + result.toString());
        preDetailsInfo = PreDetailsInfo.fromJson(result);
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
      Uri uri = Uri.parse(Config.baseUrl + Config.preDecision);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(":::::::::????????" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        // if (result["Result"] == "true") {
        //   if (status == "1") {
        //     completedBottomSheet(oID: orderID);
        //   }
        // }
        if (status == "2") {
          myPriscriptionOrderHistory(statusWise: "Current");
        }
        myPriscriptionInformetion(oID: orderID);
        showToastMessage(result["ResponseMsg"]);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  onrouteOrderApi({String? orderID, montant}) async {
    try {
      Map map = {
        "oid": orderID,
        "rider_id": getData.read("StoreLogin")["id"],
        "status": "4",
        "total": montant.text,
        "comment_reject": "n/a"
      };
      Uri uri = Uri.parse(Config.baseUrl + Config.preDecision);
      var response = await http.post(uri, body: jsonEncode(map),);
      // showToastMessage(response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        myPriscriptionInformetion(oID: orderID);
        showToastMessage(result["ResponseMsg"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
  
  completeOrderApi({String? orderID, image}) async {
    try {
      Map map = {
        "order_id": orderID,
        "rider_id": getData.read("StoreLogin")["id"],
        "img": image,
      };
      Uri uri = Uri.parse(Config.baseUrl + Config.preCompleteOrder);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Dialogbox();
        myPriscriptionInformetion(oID: orderID);
        showToastMessage(result["ResponseMsg"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
