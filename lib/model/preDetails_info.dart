// To parse this JSON data, do
//
//     final preDetailsInfo = preDetailsInfoFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PreDetailsInfo preDetailsInfoFromJson(String str) =>
    PreDetailsInfo.fromJson(json.decode(str));

String preDetailsInfoToJson(PreDetailsInfo data) => json.encode(data.toJson());

class PreDetailsInfo {
  PreDetailsInfo({
    required this.pOrderProductList,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  OrderProductList pOrderProductList;
  String responseCode;
  String result;
  String responseMsg;

  factory PreDetailsInfo.fromJson(Map<String, dynamic> json) => PreDetailsInfo(
        pOrderProductList: OrderProductList.fromJson(json["OrderProductList"]),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "OrderProductList": pOrderProductList.toJson(),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class OrderProductList {
  OrderProductList({
    required this.orderDate,
    required this.pMethodName,
    required this.deliveryCharge,
    required this.couponAmount,
    required this.orderTotal,
    required this.orderSubTotal,
    required this.commentReject,
    required this.customerName,
    required this.customerAddress,
    required this.customerAddressType,
    required this.customerMobile,
    required this.orderType,
    required this.orderTimeslot,
    required this.orderPrescription,
    required this.wallAmt,
    required this.orderTransactionId,
    required this.additionalNote,
    required this.orderStatus,
    required this.flowId,
    required this.storeCharge,
    required this.orderProductData,
  });

  DateTime orderDate;
  String pMethodName;
  String deliveryCharge;
  String couponAmount;
  String orderTotal;
  String orderSubTotal;
  String commentReject;
  String customerName;
  String customerAddress;
  String customerAddressType;
  String customerMobile;
  String orderType;
  String orderTimeslot;
  List<String> orderPrescription;
  String wallAmt;
  String orderTransactionId;
  String additionalNote;
  String orderStatus;
  String flowId;
  String storeCharge;
  List<OrderProductDatum> orderProductData;

  factory OrderProductList.fromJson(Map<String, dynamic> json) =>
      OrderProductList(
        orderDate: DateTime.parse(json["order_date"]),
        pMethodName: json["p_method_name"],
        deliveryCharge: json["Delivery_charge"],
        couponAmount: json["Coupon_Amount"],
        orderTotal: json["Order_Total"],
        orderSubTotal: json["Order_SubTotal"],
        commentReject: json["comment_reject"],
        customerName: json["customer_name"],
        customerAddress: json["customer_address"],
        customerAddressType: json["customer_address_type"],
        customerMobile: json["customer_mobile"],
        orderType: json["order_type"],
        orderTimeslot: json["order_timeslot"],
        orderPrescription:
            List<String>.from(json["order_prescription"].map((x) => x)),
        wallAmt: json["wall_amt"],
        orderTransactionId: json["Order_Transaction_id"],
        additionalNote: json["Additional_Note"],
        orderStatus: json["Order_Status"],
        flowId: json["Flow_id"],
        storeCharge: json["store_charge"],
        orderProductData: List<OrderProductDatum>.from(
            json["Order_Product_Data"]
                .map((x) => OrderProductDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "p_method_name": pMethodName,
        "Delivery_charge": deliveryCharge,
        "Coupon_Amount": couponAmount,
        "Order_Total": orderTotal,
        "Order_SubTotal": orderSubTotal,
        "comment_reject": commentReject,
        "customer_name": customerName,
        "customer_address": customerAddress,
        "customer_address_type": customerAddressType,
        "customer_mobile": customerMobile,
        "order_type": orderType,
        "order_timeslot": orderTimeslot,
        "order_prescription":
            List<dynamic>.from(orderPrescription.map((x) => x)),
        "wall_amt": wallAmt,
        "Order_Transaction_id": orderTransactionId,
        "Additional_Note": additionalNote,
        "Order_Status": orderStatus,
        "Flow_id": flowId,
        "store_charge": storeCharge,
        "Order_Product_Data":
            List<dynamic>.from(orderProductData.map((x) => x.toJson())),
      };
}

class OrderProductDatum {
  OrderProductDatum({
    required this.productId,
    required this.productQuantity,
    required this.productName,
    required this.productDiscount,
    required this.productPrice,
    required this.productTotal,
  });

  String productId;
  String productQuantity;
  String productName;
  int productDiscount;
  String productPrice;
  int productTotal;

  factory OrderProductDatum.fromJson(Map<String, dynamic> json) =>
      OrderProductDatum(
        productId: json["Product_id"],
        productQuantity: json["Product_quantity"],
        productName: json["Product_name"],
        productDiscount: json["Product_discount"],
        productPrice: json["Product_price"],
        productTotal: json["Product_total"],
      );

  Map<String, dynamic> toJson() => {
        "Product_id": productId,
        "Product_quantity": productQuantity,
        "Product_name": productName,
        "Product_discount": productDiscount,
        "Product_price": productPrice,
        "Product_total": productTotal,
      };
}
