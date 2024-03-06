// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, must_be_immutable, file_names

import 'package:deliveryboy/controller/myorder_controller.dart';
import 'package:deliveryboy/helpar/fontfamily_model.dart';
import 'package:deliveryboy/helpar/routes_helper.dart';
import 'package:deliveryboy/screen/dashboard_screen.dart';
import 'package:deliveryboy/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookingScreen extends StatefulWidget {
  String? isBack;
  MyBookingScreen({super.key, this.isBack});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  MyOrderController myOrderController = Get.find();
  final note = TextEditingController();
  var selectedRadioTile;
  String? rejectmsg = '';

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _tabController?.index == 0;
    if (_tabController?.index == 0) {
      myOrderController.myOrderHistory(statusWise: "Current");
    }

  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        centerTitle: true,
        elevation: 0,
        leading: widget.isBack == "1"
            ? BackButton(
                color: Grey2color,
                onPressed: () {
                  Get.back();
                },
              )
            : SizedBox(),
        title: Text(
          "Commandes",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 20,
            color: Grey2color,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox( height: 10, ),
          SizedBox(
            height: 40,
            width: Get.size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TabBar.secondary(
                controller: _tabController,
                unselectedLabelColor: greyColor,
                labelStyle: const TextStyle(
                  fontFamily: FontFamily.gilroyBold,
                  fontSize: 15,
                ),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  color: WhiteColor,
                ),
                labelColor: gradient.defoultColor,
                onTap: (value) {
                  if (value == 0) {
                    myOrderController.myOrderHistory(statusWise: "Current");
                  } else {
                    myOrderController.crOrderHistory(statusWise: "MyOrder");
                  }
                },
                tabs: [
                  Tab(
                    text: "A proximité".tr,
                  ),
                  Tab(
                    text: "Mes livraisons".tr,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                currentOrder(),
                pastOrder(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget currentOrder() {
    return GetBuilder<MyOrderController>(builder: (context) {
      return SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: myOrderController.isLoading
            ? myOrderController.orderInfo!.orderHistory.isNotEmpty
                ? ListView.builder(
                    itemCount: myOrderController.orderInfo?.orderHistory.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          myOrderController.getOrderInformetion(
                            orderID: myOrderController
                                    .orderInfo?.orderHistory[index].id ??
                                "",
                          );
                          Get.toNamed(Routes.orderDetailsScreen, arguments: {
                            "oID": myOrderController
                                    .orderInfo?.orderHistory[index].id ??
                                "",
                            "oRef": myOrderController
                                    .orderInfo?.orderHistory[index].ref ??
                                "",
                          });
                        },
                        child: Container(
                          width: Get.size.width,
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    myOrderController.orderInfo
                                            ?.orderHistory[index].orderDate
                                            .toString()
                                            .split(" ")
                                            .first ??
                                        "",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyLight,
                                      color: Color(0xFF212529),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/order-new.png",
                                        height: 18,
                                        width: 18,
                                      ),
                                      Text("Nouvelle",
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: Color(0xFFfab005),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text(
                                    "Commande: #${myOrderController.orderInfo?.orderHistory[index].ref ?? ""}",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: Grey2color,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox()
                                  /** Spacer(),
                                  Text(
                                    myOrderController.orderInfo
                                            ?.orderHistory[index].orderType ??
                                        "",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 13,
                                      color: gradient.defoultColor,
                                    ),
                                  ), **/
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      myOrderController
                                              .orderInfo
                                              ?.orderHistory[index]
                                              .customerName[0] ??
                                          "",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        fontSize: 17,
                                        color: gradient.defoultColor,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFe5f6f1),
                                      // image: DecorationImage(
                                      //   image: NetworkImage(
                                      //       "${Config.imageurl}${myOrderController.orderInfo?.orderHistory[index].storeImg ?? ""}"),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                  ),
                                  SizedBox(width: 2,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                myOrderController
                                                        .orderInfo
                                                        ?.orderHistory[index]
                                                        .customerName ??
                                                    "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  fontSize: 13,
                                                  color: Grey2color,
                                                  // overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${myOrderController.orderInfo?.orderHistory[index].paymentTitle ?? ""}",
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: FontFamily.gilroyRegular,
                                                  fontSize: 12,
                                                  color: Grey2color,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox( height: 2 ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                myOrderController
                                                        .orderInfo
                                                        ?.orderHistory[index]
                                                        .customerAddress ??
                                                    "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: FontFamily.gilroyLight,
                                                  fontSize: 12,
                                                  color: Grey2color,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${myOrderController.orderInfo?.orderHistory[index].total ?? "0.00"} ${currency}",
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: FontFamily.gilroyBold,
                                                  fontSize: 15,
                                                  color: Grey2color,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox( height: 5, ),
                              Row(
                                children: [
                                  
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        myOrderController.getOrderInformetion(
                                          orderID: myOrderController.orderInfo
                                                  ?.orderHistory[index].id ??
                                              "",
                                        );
                                        Get.toNamed(Routes.orderDetailsScreen,
                                            arguments: {
                                              "oID": myOrderController
                                                      .orderInfo
                                                      ?.orderHistory[index]
                                                      .id ??
                                                  "",
                                              "oRef": myOrderController
                                                      .orderInfo
                                                      ?.orderHistory[index]
                                                      .ref ??
                                                  "",
                                            });
                                      },
                                      child: Container(
                                        height: 35,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.all(5),
                                        child: Text(
                                          "Plus de détails".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyMedium,
                                            color: WhiteColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: gradient.greyGradient,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/emptyOrder.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No orders placed!",
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            color: Grey2color,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Currently you don’t have any orders.",
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyMedium,
                            color: greytext,
                          ),
                        ),
                      ],
                    ),
                  )
            : Center(child: CircularProgressIndicator(),),
      );
    });
  }

  Widget pastOrder() {

    return GetBuilder<MyOrderController>(builder: (context) {
      return SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: myOrderController.isLoading
            ? myOrderController.orderInfo!.orderHistory.isNotEmpty
                ? ListView.builder(
                    itemCount: myOrderController.orderInfo?.orderHistory.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          myOrderController.getOrderInformetion(
                            orderID: myOrderController
                                    .orderInfo?.orderHistory[index].id ??
                                "",
                          );
                          Get.toNamed(Routes.orderDetailsScreen, arguments: {
                            "oID": myOrderController
                                    .orderInfo?.orderHistory[index].id ??
                                "",
                            "oRef": myOrderController
                                    .orderInfo?.orderHistory[index].ref ??
                                "",
                          });
                        },
                        child: Container(
                          width: Get.size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    myOrderController.orderInfo
                                            ?.orderHistory[index].orderDate
                                            .toString()
                                            .split(" ")
                                            .first ??
                                        "",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyLight,
                                      color: Color(0xFF212529),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Spacer(),
                                  myOrderController.orderInfo
                                              ?.orderHistory[index].rstatus == "Cancelled"
                                      ? Row(
                                          children: [
                                            Image.asset("assets/order-cancel.png",
                                              height: 18,
                                              width: 18,
                                            ),
                                            Text(
                                              myOrderController
                                                      .orderInfo
                                                      ?.orderHistory[index]
                                                      .rstatusTxt ??
                                                  "",
                                              style: TextStyle(
                                                fontFamily: FontFamily.gilroyBold,
                                                color: Color(0xFF06B730),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        )
                                      : myOrderController
                                                  .orderInfo
                                                  ?.orderHistory[index]
                                                  .rstatus == "Processing"
                                          ? Row(
                                              children: [
                                                Image.asset(
                                                  "assets/order-processing.png",
                                                  height: 18,
                                                  width: 18,
                                                ),
                                                Text(
                                                  myOrderController
                                                          .orderInfo
                                                          ?.orderHistory[index]
                                                          .rstatusTxt ??
                                                      "",
                                                  style: TextStyle(
                                                    fontFamily: FontFamily.gilroyBold,
                                                    color: Color(0xFFffc107),
                                                    fontSize: 15,
                                                    backgroundColor: Color(0xfff3ecce)
                                                  ),
                                                ),
                                              ],
                                            )
                                          : myOrderController
                                                  .orderInfo
                                                  ?.orderHistory[index]
                                                  .rstatus == "On route"
                                          ? Row(
                                              children: [
                                                Image.asset(
                                                  "assets/order-on-route.png",
                                                  height: 18,
                                                  width: 18,
                                                ),
                                                Text(
                                                  myOrderController
                                                          .orderInfo
                                                          ?.orderHistory[index]
                                                          .rstatusTxt ??
                                                      "",
                                                  style: TextStyle(
                                                    fontFamily: FontFamily.gilroyBold,
                                                    color: Color(0xFF7367f0),
                                                    fontSize: 15,
                                                    backgroundColor: Color(0xffe5f6f1)
                                                  ),
                                                ),
                                              ],
                                            )
                                      : Row(
                                          children: [
                                            Image.asset("assets/order-completed.png",
                                              height: 18,
                                              width: 18,
                                            ),
                                            Text(
                                              myOrderController
                                                      .orderInfo
                                                      ?.orderHistory[index]
                                                      .rstatusTxt ??
                                                  "",
                                              style: TextStyle(
                                                fontFamily: FontFamily.gilroyBold,
                                                color: Color(0xFF28c66f),
                                                fontSize: 15,
                                                backgroundColor: Color(0xffd4efe9)
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Commande: #${myOrderController.orderInfo?.orderHistory[index].ref ?? ""}",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: Grey2color,
                                      fontSize: 15,
                                    ),
                                  ),
                                  /**Spacer(),
                                  Text(
                                    myOrderController.orderInfo
                                            ?.orderHistory[index].orderType ??
                                        "",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 13,
                                      color: gradient.defoultColor,
                                    ),
                                  ), **/
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      myOrderController
                                              .orderInfo
                                              ?.orderHistory[index]
                                              .customerName[0] ??
                                          "",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        fontSize: 17,
                                        color: gradient.defoultColor,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xfff0f1f3), // Colors.grey.shade200,
                                      // image: DecorationImage(
                                      //   image: NetworkImage(
                                      //       "${Config.imageurl}${myOrderController.orderInfo?.orderHistory[index].storeImg ?? ""}"),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                myOrderController
                                                        .orderInfo
                                                        ?.orderHistory[index]
                                                        .customerName ??
                                                    "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  fontSize: 13,
                                                  color: Grey2color,
                                                  // overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${myOrderController.orderInfo?.orderHistory[index].paymentTitle ?? ""}",
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  fontSize: 13,
                                                  color: Grey2color,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                myOrderController
                                                        .orderInfo
                                                        ?.orderHistory[index]
                                                        .customerAddress ??
                                                    "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily:FontFamily.gilroyLight,
                                                  fontSize: 12,
                                                  color: Grey2color,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${myOrderController.orderInfo?.orderHistory[index].total ?? "0.00"} ${currency}",
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  fontSize: 15,
                                                  color: Grey2color,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(children: [
                              myOrderController.orderInfo
                                              ?.orderHistory[index].flowId ==
                                          "4"
                                      ? Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              ticketCancell(myOrderController
                                                      .orderInfo
                                                      ?.orderHistory[index]
                                                      .id ??
                                                  "");
                                            },
                                            child: Container(
                                              height: 35,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.all(10),
                                              child: Text(
                                                "Annuler".tr,
                                                style: TextStyle(
                                                  fontFamily: FontFamily.gilroyMedium,
                                                  color: WhiteColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: RedColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                myOrderController.orderInfo
                                              ?.orderHistory[index].flowId ==
                                          "5"
                                      ? Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              ticketDone(myOrderController
                                                      .orderInfo
                                                      ?.orderHistory[index]
                                                      .id ??
                                                  "");
                                            },
                                            child: Container(
                                              height: 35,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.all(10),
                                              child: Text(
                                                "Terminer".tr,
                                                style: TextStyle(
                                                  fontFamily: FontFamily.gilroyMedium,
                                                  color: WhiteColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: greenColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      myOrderController.getOrderInformetion(
                                        orderID: myOrderController.orderInfo
                                                ?.orderHistory[index].id ??
                                            "",
                                      );
                                      Get.toNamed(Routes.orderDetailsScreen,
                                          arguments: {
                                            "oID": myOrderController.orderInfo
                                                    ?.orderHistory[index].id ??
                                                "",
                                            "oRef": myOrderController.orderInfo
                                                      ?.orderHistory[index].ref ??
                                                "",
                                          });
                                    },
                                    child: Container(
                                      height: 35,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        "Plus de détails".tr,
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyMedium,
                                          color: WhiteColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: gradient.greyGradient,
                                      ),
                                    ),
                                  ),
                                ),
                              ])
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/emptyOrder.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No orders placed!",
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            color: Grey2color,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Currently you don’t have any orders.",
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyMedium,
                            color: greytext,
                          ),
                        ),
                      ],
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }

  ticketDone(orderId) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: WhiteColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    Container(
                        height: 6,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(25))),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Livraison terminée".tr,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Gilroy Bold',
                          color: Grey2color),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "la livraison est terminée ?".tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Gilroy Medium',
                          color: Grey2color),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.35,
                          height: Get.height * 0.05,
                          child: ticketbutton(
                            title: "Non".tr,
                            bgColor: RedColor,
                            titleColor: Colors.white,
                            ontap: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.35,
                          height: Get.height * 0.05,
                          child: ticketbutton(
                            title: "Oui".tr,
                            gradient1: gradient.btnGradient,
                            titleColor: Colors.white,
                            ontap: () {
                              myOrderController.mackDecisionApi(
                                orderID: orderId,
                                status: "6",
                                reson: "Others",
                              );
                              Get.back();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ),
            );
          });
        });
  }

  ticketCancell(orderId) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: WhiteColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    Container(
                        height: 6,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(25))),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Sélectionnez la raison".tr,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Gilroy Bold',
                          color: Grey2color),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Veuillez sélectionner le motif de l'annulation:".tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Gilroy Medium',
                          color: Grey2color),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    ListView.builder(
                      itemCount: cancelList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return RadioListTile(
                          dense: true,
                          value: i,
                          activeColor: Color(0xFF246BFD),
                          tileColor: Grey2color,
                          selected: true,
                          groupValue: selectedRadioTile,
                          title: Text(
                            cancelList[i]["title"],
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Gilroy Medium',
                                color: Grey2color),
                          ),
                          onChanged: (val) {
                            setState(() {});
                            selectedRadioTile = val;
                            rejectmsg = cancelList[i]["title"];
                          },
                        );
                      },
                    ),
                    rejectmsg == "Others".tr
                        ? SizedBox(
                            height: 50,
                            width: Get.width * 0.85,
                            child: TextField(
                              controller: note,
                              decoration: InputDecoration(
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF246BFD), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF246BFD), width: 1),
                                  ),
                                  hintText: 'Entrez la raison'.tr,
                                  hintStyle: TextStyle(
                                      fontFamily: 'Gilroy Medium',
                                      fontSize: Get.size.height / 55,
                                      color: Colors.grey)),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.35,
                          height: Get.height * 0.05,
                          child: ticketbutton(
                            title: "Fermer".tr,
                            bgColor: RedColor,
                            titleColor: Colors.white,
                            ontap: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.35,
                          height: Get.height * 0.05,
                          child: ticketbutton(
                            title: "Confirmer".tr,
                            gradient1: gradient.btnGradient,
                            titleColor: Colors.white,
                            ontap: () {
                              myOrderController.mackDecisionApi(
                                orderID: orderId,
                                status: "7",
                                reson: rejectmsg == "Others".tr
                                    ? note.text
                                    : rejectmsg,
                              );
                              Get.back();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ),
            );
          });
        });
  }

  List cancelList = [
    {"id": 1, "title": "Problèmes Livraison".tr},
    {"id": 2, "title": "Problèmes d'inspection".tr},
    {"id": 3, "title": "Problèmes d'adresse".tr},
    {"id": 4, "title": "Raisons personnelles".tr},
    {"id": 5, "title": "Autres".tr},
  ];

  ticketbutton(
      {Function()? ontap,
      String? title,
      Color? bgColor,
      titleColor,
      Gradient? gradient1}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: Get.height * 0.04,
        width: Get.width * 0.40,
        decoration: BoxDecoration(
          color: bgColor,
          gradient: gradient1,
          borderRadius: (BorderRadius.circular(18)),
        ),
        child: Center(
          child: Text(title!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: titleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  fontFamily: 'Gilroy Medium')),
        ),
      ),
    );
  }
}
