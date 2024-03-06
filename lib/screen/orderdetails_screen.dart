// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, unnecessary_brace_in_string_interps, sort_child_properties_last, use_key_in_widget_constructors, must_be_immutable, unused_local_variable, prefer_final_fields

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryboy/Api/Config.dart';
import 'package:deliveryboy/controller/myorder_controller.dart';
import 'package:deliveryboy/helpar/fontfamily_model.dart';
import 'package:deliveryboy/screen/dashboard_screen.dart';
import 'package:deliveryboy/utils/Colors.dart';
import 'package:deliveryboy/utils/Custom_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  MyOrderController myOrderController = Get.find();
  String oID = Get.arguments["oID"];
  String oRef = Get.arguments["oRef"];
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  String imageEncoded = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _signaturePadKey.currentState?.clear();
      imageEncoded = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        leading: BackButton(
          color: BlackColor,
        ),
        title: Text(
          "Commande: #${oRef}",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            color: BlackColor,
            fontSize: 17,
          ),
        ),
        elevation: 0,
        backgroundColor: WhiteColor,
      ),
      bottomNavigationBar: GetBuilder<MyOrderController>(
        builder: (controller) {
          return myOrderController
                      .orderInformetionInfo?.orderProductList.flowId ==
                  "5"
              ? Container(
                  color: WhiteColor,
                  height: Get.height * 0.09,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "$currency${myOrderController.orderInformetionInfo?.orderProductList.orderTotal}",
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: BlackColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                        InkWell(
                          child: InkWell(
                            onTap: () {
                              // if (imageEncoded != "") {
                              //  myOrderController.completeOrderApi(
                              //    orderID: oID,
                              //  );
                              //  imageEncoded = "";
                              // } else {
                              //  showToastMessage("Veuillez signer");
                              // }

                              myOrderController.completeOrderApi( orderID: oID  );
                              imageEncoded = "";
                            },
                            child: Container(
                              height: 50,
                              width: Get.width * 0.45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: gradient.btnGradient,
                              ),
                              child: Text(
                                "Livré",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: WhiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : myOrderController
                          .orderInformetionInfo?.orderProductList.flowId ==
                      "4"
                      ? Container(
                      color: WhiteColor,
                      height: Get.height * 0.09,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("$currency${myOrderController.orderInformetionInfo?.orderProductList.orderTotal}",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        color: Greycolor,
                                        fontSize: 20,
                                      ),
                                    )
                                    // SizedBox(
                                    //   width: Get.width * 0.02,
                                    // ),
                                    // Image.asset(
                                    //  "assets/downarrow.png",
                                    //  height: 14,
                                    //  width: 14,
                                    // )
                                  ],
                                ),
                                
                              ],
                            ),
                            InkWell(
                              child: InkWell(
                                onTap: () {
                                  myOrderController.mackDecisionApi(
                                      orderID: oID, status: "4", reson: "n/a");
                                },
                                child: Container(
                                  height: 50,
                                  width: Get.width * 0.45,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: gradient.btnGradientPrimary,
                                  ),
                                  child: Text(
                                    "En Route",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: WhiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
              : myOrderController
                          .orderInformetionInfo?.orderProductList.flowId ==
                      "0"
                  ? Container(
                      color: WhiteColor,
                      height: Get.height * 0.09,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "$currency${myOrderController.orderInformetionInfo?.orderProductList.orderTotal}",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        color: Greycolor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: Get.width * 0.02,
                                    // ),
                                    // Image.asset(
                                    //   "assets/downarrow.png",
                                    //   height: 14,
                                    //   width: 14,
                                    // )
                                  ],
                                ),
                                
                              ],
                            ),
                            InkWell(
                              child: InkWell(
                                onTap: () {
                                  myOrderController.mackDecisionApi(
                                      orderID: oID, status: "1", reson: "n/a");
                                },
                                child: Container(
                                  height: 50,
                                  width: Get.width * 0.45,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: gradient.btnGradientPrimary,
                                  ),
                                  child: Text(
                                    "Accepter",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: WhiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox();
        },
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<MyOrderController>(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: myOrderController.isLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.02),
                      myOrderController.orderInformetionInfo!.orderProductList
                              .orderPrescription.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: WhiteColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Uploaded Prescription",
                                    style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        color: BlackColor,
                                        fontSize: 17),
                                  ),
                                  SizedBox(height: Get.height * 0.02),
                                  SizedBox(
                                    height: Get.height * 0.22,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: myOrderController
                                          .orderInformetionInfo
                                          ?.orderProductList
                                          .orderPrescription
                                          .length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(
                                              FullScreenImage(
                                                imageUrl:
                                                    "${Config.imageurl}${myOrderController.orderInformetionInfo?.orderProductList.orderPrescription[index] ?? ""}",
                                                tag: "generate_a_unique_tag",
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: Get.height * 0.2,
                                            width: Get.width * 0.4,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    "assets/ezgif.com-crop.gif",
                                                placeholderFit: BoxFit.cover,
                                                image:
                                                    "${Config.imageurl}${myOrderController.orderInformetionInfo?.orderProductList.orderPrescription[index]}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: transparent,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: Get.height * 0.02),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: WhiteColor),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Articles",
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: BlackColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Total ${myOrderController.orderInformetionInfo?.orderProductList.orderProductData.length}",
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: gradient.defoultColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.02),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: myOrderController.orderInformetionInfo
                                  ?.orderProductList.orderProductData.length,
                              itemBuilder: (context, index) {
                                return bgdecoration(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                myOrderController
                                                        .orderInformetionInfo
                                                        ?.orderProductList
                                                        .orderProductData[index]
                                                        .productName ??
                                                    "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  color: BlackColor,
                                                  fontSize: 13,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.005),
                                      Row(
                                        children: [
                                          Image.network(
                                              "${myOrderController.orderInformetionInfo?.orderProductList.orderProductData[index].productImg ?? ""}",
                                              height: 20,
                                              width: 20,
                                            ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "${myOrderController.orderInformetionInfo?.orderProductList.orderProductData[index].productQuantity}x",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "${myOrderController.orderInformetionInfo?.orderProductList.orderProductData[index].productPrice}${currency}",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          /** SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "${myOrderController.orderInformetionInfo?.orderProductList.orderProductData[index].productDiscount}${currency}",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: greyColor.withOpacity(0.5),
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 15,
                                            ),
                                          ), **/
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      myOrderController.orderInformetionInfo?.orderProductList
                                  .additionalNote !=
                              ""
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: WhiteColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Note",
                                      style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: BlackColor,
                                          fontSize: 16)),
                                  SizedBox(height: Get.height * 0.02),
                                  Text(
                                    myOrderController.orderInformetionInfo
                                            ?.orderProductList.additionalNote ??
                                        "",
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyMedium,
                                      color: BlackColor,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: Get.height * 0.02),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: WhiteColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Information de Paiement",
                                style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: BlackColor,
                                    fontSize: 16)),
                            SizedBox(height: Get.height * 0.02),
                            bgdecoration(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Commande: #${oRef}",
                                      style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: BlackColor,
                                          fontSize: 16)),
                                  SizedBox(height: Get.height * 0.015),
                                  Paymentinfo(
                                      text: "Statut",
                                      infotext: myOrderController
                                              .orderInformetionInfo
                                              ?.orderProductList
                                              .orderStatus ??
                                          ""),
                                  myOrderController.orderInformetionInfo
                                              ?.orderProductList.orderType ==
                                          "Self"
                                      ? Paymentinfo(
                                          text: "Time Slot",
                                          infotext: myOrderController
                                                  .orderInformetionInfo
                                                  ?.orderProductList
                                                  .orderTimeslot ??
                                              "",
                                        )
                                      : SizedBox(),
                                  Paymentinfo(
                                    text: "Mode",
                                    infotext: myOrderController
                                            .orderInformetionInfo
                                            ?.orderProductList
                                            .pMethodName ??
                                        "",
                                  ),
                                  myOrderController
                                              .orderInformetionInfo
                                              ?.orderProductList
                                              .orderTransactionId !=
                                          "0"
                                      ? Paymentinfo(
                                          text: "Transaction ID",
                                          infotext: myOrderController
                                                  .orderInformetionInfo
                                                  ?.orderProductList
                                                  .orderTransactionId ??
                                              "",
                                        )
                                      : SizedBox(),
                                  Paymentinfo(
                                    text: "Date",
                                    infotext: myOrderController
                                            .orderInformetionInfo
                                            ?.orderProductList
                                            .orderDate
                                            .toString()
                                            .split(" ")
                                            .first ??
                                        "",
                                  ),
                                  Paymentinfo(
                                      text: "Sous total",
                                      infotext:
                                          "${myOrderController.orderInformetionInfo?.orderProductList.orderSubTotal}${currency}"),
                                  myOrderController.orderInformetionInfo
                                              ?.orderProductList.couponAmount !=
                                          "0"
                                      ? Paymentinfo(
                                          text: "Coupons",
                                          infotext:
                                              "${myOrderController.orderInformetionInfo?.orderProductList.couponAmount}${currency}")
                                      : SizedBox(),
                                  myOrderController.orderInformetionInfo
                                              ?.orderProductList.wallAmt !=
                                          "0"
                                      ? Paymentinfo(
                                          text: "Wallet",
                                          infotext:
                                              "${myOrderController.orderInformetionInfo?.orderProductList.wallAmt}${currency}")
                                      : SizedBox(),
                                  myOrderController.orderInformetionInfo
                                              ?.orderProductList.orderType ==
                                          "Delivery"
                                      ? Paymentinfo(
                                          text: "Frais de livraison",
                                          infotext:
                                              "${myOrderController.orderInformetionInfo?.orderProductList.deliveryCharge}${currency}")
                                      : SizedBox(),
                                  DottedLine( dashColor: greyColor,),
                                  SizedBox(height: Get.height * 0.02),
                                  Paymentinfo(
                                      text: "Montant total",
                                      infotext:
                                          "${myOrderController.orderInformetionInfo?.orderProductList.orderTotal}${currency}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      myOrderController.orderInformetionInfo?.orderProductList
                                  .orderType ==
                              "Delivery"
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: WhiteColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adresse de livraison",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: BlackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  bgdecoration(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/location-pin.png",
                                              height: 20,
                                              width: 20,
                                              color: gradient.defoultColor,
                                            ),
                                            SizedBox(width: Get.width * 0.02),
                                            Text(
                                              myOrderController
                                                      .orderInformetionInfo
                                                      ?.orderProductList
                                                      .customerAddressType ??
                                                  "",
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                color: BlackColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(color: Colors.grey.shade300),
                                        Text(
                                          myOrderController
                                                  .orderInformetionInfo
                                                  ?.orderProductList
                                                  .customerAddress ??
                                              "",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyMedium,
                                            color: greycolor,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: Get.height * 0.02),
                      Container(
                        padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: WhiteColor),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Information Client", 
                                style: TextStyle( fontFamily: FontFamily.gilroyBold, color: BlackColor, fontSize: 16)
                              ),
                              SizedBox(height: Get.height * 0.02),
                              bgdecoration(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   usercontect = !usercontect;
                                        // });
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset("assets/Profile.png",
                                              height: 20,
                                              width: 20,
                                              color: greyColor),
                                          SizedBox(width: Get.width * 0.02),
                                          SizedBox(
                                            width: Get.width * 0.65,
                                            child: Text(
                                                myOrderController
                                                        .orderInformetionInfo
                                                        ?.orderProductList
                                                        .customerName ??
                                                    "",
                                                style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: BlackColor,
                                                    fontSize: 16)),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Image.asset("assets/rightarrow.png",
                                              height: 15,
                                              width: 15,
                                              color: gradient.defoultColor),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    myOrderController.orderInformetionInfo
                                                ?.orderProductList.flowId !=
                                            "0"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Divider(color: Colors.grey.shade300),
                                              Text(
                                                  myOrderController
                                                          .orderInformetionInfo
                                                          ?.orderProductList
                                                          .customerMobile ??
                                                      "",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.gilroyMedium,
                                                      color: greyColor,
                                                      fontSize: 16)),
                                            ],
                                          )
                                        : SizedBox()
                                  ],
                                )
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      myOrderController.orderInformetionInfo?.orderProductList
                                  .flowId ==
                              "10"
                          ? Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SfSignaturePad(
                                      key: _signaturePadKey,
                                      minimumStrokeWidth: 1,
                                      maximumStrokeWidth: 3,
                                      strokeColor: Colors.blue,
                                      backgroundColor: WhiteColor,
                                      onDrawEnd: () async {
                                        ui.Image signatureData =
                                            await _signaturePadKey.currentState!
                                                .toImage();
                                        ByteData? byteData =
                                            await signatureData.toByteData(
                                                format: ui.ImageByteFormat.png);
                                        imageEncoded = base64.encode(
                                            byteData!.buffer.asUint8List());
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  height: 200,
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                    color: WhiteColor,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: InkWell(
                                    onTap: () {
                                      _signaturePadKey.currentState?.clear();
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/Thrash.png",
                                            height: 20,
                                            width: 20,
                                            color: WhiteColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Clear",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: WhiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: gradient.btnGradient,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  )
                : Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ), 
          );
        }),
      ),
    );
  }
  Paymentinfo({String? text, infotext}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text!,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),
            Text(
              infotext,
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                color: BlackColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.015),
      ],
    );
  }
}

class FullScreenImage extends StatelessWidget {
  String? imageUrl;
  String? tag;
  FullScreenImage({this.imageUrl, this.tag});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag ?? "",
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
              imageUrl: imageUrl ?? "",
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
