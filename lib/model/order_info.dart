// To parse this JSON data, do
//
//     final orderInfo = orderInfoFromJson(jsonString);

import 'dart:convert';

OrderInfo orderInfoFromJson(String str) => OrderInfo.fromJson(json.decode(str));

String orderInfoToJson(OrderInfo data) => json.encode(data.toJson());

class OrderInfo {
  OrderInfo({
    required this.orderHistory,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<OrderHistory> orderHistory;
  String responseCode;
  String result;
  String responseMsg;

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        orderHistory: List<OrderHistory>.from(
            json["OrderHistory"].map((x) => OrderHistory.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "OrderHistory": List<dynamic>.from(orderHistory.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class OrderHistory {
  OrderHistory({
    required this.id,
    required this.ref,
    required this.status,
    required this.statusTxt,
    required this.rstatus,
    required this.rstatusTxt,
    required this.orderType,
    required this.flowId,
    required this.customerName,
    required this.customerAddress,
    required this.customerAddressType,
    required this.customerMobile,
    required this.paymentTitle,
    required this.orderDate,
    required this.total,
  });

  String id;
  String ref;
  String status;
  String statusTxt;
  String rstatus;
  String rstatusTxt;
  String orderType;
  String flowId;
  String customerName;
  String customerAddress;
  String customerAddressType;
  String customerMobile;
  String paymentTitle;
  DateTime orderDate;
  String total;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        id: json["id"],
        ref: json["order_ref"],
        status: json["status"],
        statusTxt: json["order_status"],
        rstatus: json["order_r_status"],
        rstatusTxt: json["order_r_status_txt"],
        orderType: json["order_type"],
        flowId: json["Flow_id"],
        customerName: json["customer_name"],
        customerAddress: json["customer_address"],
        customerAddressType: json["customer_address_type"],
        customerMobile: json["customer_mobile"],
        paymentTitle: json["payment_title"],
        orderDate: DateTime.parse(json["order_date"]),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_ref": ref,
        "status": status,
        "statusTxt": statusTxt,
        "rstatus": rstatus,
        "rstatusTxt": rstatusTxt,
        "order_type": orderType,
        "Flow_id": flowId,
        "customer_name": customerName,
        "customer_address": customerAddress,
        "customer_address_type": customerAddressType,
        "customer_mobile": customerMobile,
        "payment_title": paymentTitle,
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "total": total,
      };
}
