// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, non_constant_identifier_names, prefer_final_fields

import 'dart:convert';

import 'package:deliveryboy/Api/Config.dart';
import 'package:deliveryboy/controller/priscription_controller.dart';
import 'package:deliveryboy/helpar/fontfamily_model.dart';
import 'package:deliveryboy/screen/dashboard_screen.dart';
import 'package:deliveryboy/screen/orderdetails_screen.dart';
import 'package:deliveryboy/utils/Colors.dart';
import 'package:deliveryboy/utils/Custom_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'dart:ui' as ui;

class MyPriscriptionInfo extends StatefulWidget {
  const MyPriscriptionInfo({super.key});

  @override
  State<MyPriscriptionInfo> createState() => _MyPriscriptionInfoState();
}

class _MyPriscriptionInfoState extends State<MyPriscriptionInfo> {
  PreScriptionControllre preScriptionControllre = Get.find();
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  String oID = Get.arguments["oID"];
  String oRef = Get.arguments["oRef"];
  final note = TextEditingController();
  final Montant = TextEditingController(); // new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ''); //TextEditingController();
  var selectedRadioTile;
  String ? rejectmsg = '';
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
          "Commade: #$oRef",
          style: TextStyle(
              fontFamily: FontFamily.gilroyBold,
              color: BlackColor,
              fontSize: 17),
        ),
        elevation: 0,
        backgroundColor: WhiteColor,
      ),
      bottomNavigationBar:
          GetBuilder<PreScriptionControllre>(builder: (context) {
        return preScriptionControllre
                    .preDetailsInfo?.pOrderProductList.flowId ==
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
                                "$currency${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderTotal}",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: BlackColor,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Image.asset(
                                "assets/downarrow.png",
                                height: 14,
                                width: 14,
                              )
                            ],
                          ),
                          SizedBox(height: Get.height * 0.005),
                          Text(
                            "Peyment Required",
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: greyColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        child: InkWell(
                          onTap: () {
                            preScriptionControllre.mackDecisionApi(
                                orderID: oID, status: "1", reson: "n/a");
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
            : preScriptionControllre.preDetailsInfo?.pOrderProductList.flowId ==
                    "4"
                ? Container(
                    color: WhiteColor,
                    height: Get.height * 0.10,
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
                                    "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderTotal} $currency",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: BlackColor,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "* Paiement Requis",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyMedium,
                                  color: RedColor,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            child: InkWell(
                              onTap: () {
                                // showToastMessage(Montant.text);
                                if (Montant.text != "") {
                                  preScriptionControllre.onrouteOrderApi(
                                      orderID: oID, montant: Montant);
                                  // montant = "0";
                                } else {
                                  showToastMessage("Entrez le prix total des médicaments");
                                }
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
                                  "En route",
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
                : preScriptionControllre.preDetailsInfo?.pOrderProductList.flowId ==
                    "5"
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderTotal} $currency",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: BlackColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Image.asset(
                                    "assets/downarrow.png",
                                    height: 14,
                                    width: 14,
                                  )
                                ],
                              ),
                              /** SizedBox(height: Get.height * 0.005),
                              Text(
                                "Peyment Required",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyMedium,
                                  color: greyColor,
                                  fontSize: 16,
                                ),
                              ), **/
                            ],
                          ),
                          InkWell(
                            child: InkWell(
                              onTap: () {
                                if (imageEncoded != "") {
                                  preScriptionControllre.completeOrderApi(
                                      orderID: oID, image: imageEncoded);
                                  imageEncoded = "";
                                } else {
                                  showToastMessage("Please Signature");
                                }
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
                                  "Liver",
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
      }),
      body: GetBuilder<PreScriptionControllre>(builder: (context) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: preScriptionControllre.isLoading
                ? Column(
                    children: [
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
                              "Ordonnance téléchargée",
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
                                itemCount: preScriptionControllre
                                    .preDetailsInfo
                                    ?.pOrderProductList
                                    .orderPrescription
                                    .length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        FullScreenImage(
                                          imageUrl:
                                              "${Config.imageurlPriscription}${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderPrescription[index] ?? ""}",
                                          tag: "generate_a_unique_tag",
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: Get.height * 0.2,
                                      width: Get.width * 0.4,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/ezgif.com-crop.gif",
                                          placeholderFit: BoxFit.cover,
                                          image:
                                              "${Config.imageurlPriscription}${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderPrescription[index]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: transparent,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: Get.height * 0.02),
                      preScriptionControllre.preDetailsInfo!.pOrderProductList
                              .orderProductData.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: WhiteColor),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        "Total Item ${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderProductData.length}",
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
                                    itemCount: preScriptionControllre
                                        .preDetailsInfo
                                        ?.pOrderProductList
                                        .orderProductData
                                        .length,
                                    itemBuilder: (context, index) {
                                      return bgdecoration(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      preScriptionControllre
                                                              .preDetailsInfo
                                                              ?.pOrderProductList
                                                              .orderProductData[
                                                                  index]
                                                              .productName ??
                                                          "",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .gilroyBold,
                                                        color: BlackColor,
                                                        fontSize: 15,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //     height: Get.height * 0.006),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderProductData[index].productQuantity}x",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: BlackColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.03),
                                                Text(
                                                  "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderProductData[index].productPrice}${currency}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: BlackColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Text(
                                                  "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderProductData[index].productDiscount}${currency}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: greyColor
                                                        .withOpacity(0.5),
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: Get.height * 0.02),
                      preScriptionControllre.preDetailsInfo?.pOrderProductList
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
                                    preScriptionControllre
                                            .preDetailsInfo
                                            ?.pOrderProductList
                                            .additionalNote ??
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
                      preScriptionControllre.preDetailsInfo?.pOrderProductList
                                  .pMethodName !=
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
                                  Text("Informations de paiement",
                                      style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: BlackColor,
                                          fontSize: 16)),
                                  SizedBox(height: Get.height * 0.02),
                                  bgdecoration(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Commande: #${oRef}",
                                            style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                color: BlackColor,
                                                fontSize: 16)),
                                        SizedBox(height: Get.height * 0.015),
                                        Paymentinfo(
                                            text: "Statut",
                                            infotext: preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .orderStatus ??
                                                ""),
                                        /** Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Order Type",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyMedium,
                                                    color: Colors.grey.shade400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  preScriptionControllre
                                                          .preDetailsInfo
                                                          ?.pOrderProductList
                                                          .orderType ??
                                                      "",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color:
                                                        gradient.defoultColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.015),
                                          ],
                                        ), 
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .orderType ==
                                                "Self"
                                            ? Paymentinfo(
                                                text: "Time Slot",
                                                infotext: preScriptionControllre
                                                        .preDetailsInfo
                                                        ?.pOrderProductList
                                                        .orderTimeslot ??
                                                    "",
                                              )
                                            : SizedBox(),**/
                                        Paymentinfo(
                                          text: "Mode",
                                          infotext: preScriptionControllre
                                                  .preDetailsInfo
                                                  ?.pOrderProductList
                                                  .pMethodName ??
                                              "",
                                        ),
                                        /**
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .orderTransactionId !=
                                                ""
                                            ? Paymentinfo(
                                                text: "Transaction ID",
                                                infotext: preScriptionControllre
                                                        .preDetailsInfo
                                                        ?.pOrderProductList
                                                        .orderTransactionId ??
                                                    "",
                                              )
                                            : SizedBox(), **/
                                        Paymentinfo(
                                          text: "Date",
                                          infotext: preScriptionControllre
                                                  .preDetailsInfo
                                                  ?.pOrderProductList
                                                  .orderDate
                                                  .toString()
                                                  .split(" ")
                                                  .first ??
                                              "",
                                        ),
                                        preScriptionControllre.preDetailsInfo
                                                    ?.pOrderProductList
                                                    .flowId == "5"
                                        ? Paymentinfo(
                                            text: "Sous total",
                                            infotext:
                                                "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderSubTotal} ${currency}") : SizedBox(),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .couponAmount !=
                                                "0"
                                            ? Paymentinfo(
                                                text: "Coupons",
                                                infotext:
                                                    "${preScriptionControllre.preDetailsInfo?.pOrderProductList.couponAmount} ${currency}")
                                            : SizedBox(),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .wallAmt !=
                                                "0"
                                            ? Paymentinfo(
                                                text: "Wallet",
                                                infotext:
                                                    "${preScriptionControllre.preDetailsInfo?.pOrderProductList.wallAmt} ${currency}")
                                            : SizedBox(),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .orderType ==
                                                "Delivery"
                                            ? Paymentinfo(
                                                text: "Frais de livraison",
                                                infotext:
                                                    "${preScriptionControllre.preDetailsInfo?.pOrderProductList.deliveryCharge} ${currency}")
                                            : SizedBox(),
                                        /** Paymentinfo(
                                            text: "Tax",
                                            infotext:
                                                "${preScriptionControllre.preDetailsInfo?.pOrderProductList.storeCharge} ${currency}"), **/
                                        SizedBox(height: Get.height * 0.02),
                                        preScriptionControllre.preDetailsInfo
                                                    ?.pOrderProductList
                                                    .flowId == "4"
                                        ? DottedLine(
                                          dashColor: greyColor,
                                        ) : SizedBox(),
                                        SizedBox(height: Get.height * 0.02),
                                        preScriptionControllre.preDetailsInfo
                                                    ?.pOrderProductList
                                                    .flowId == "4"
                                        ? numberfield(
                                          controller: Montant,
                                          lebaltext: "Montant",
                                          obscureText: false,
                                          validator: (value) { return null; },
                                        ) : SizedBox(),
                                        preScriptionControllre.preDetailsInfo
                                                    ?.pOrderProductList
                                                    .flowId == "5"
                                        ? SizedBox(height: Get.height * 0.02)
                                        : SizedBox(),
                                        preScriptionControllre.preDetailsInfo
                                                    ?.pOrderProductList
                                                    .flowId == "5"
                                        ? DottedLine(
                                          dashColor: greyColor,
                                        ) : SizedBox(),
                                        SizedBox(height: Get.height * 0.02),
                                        preScriptionControllre.preDetailsInfo
                                                    ?.pOrderProductList
                                                    .flowId == "5"
                                        ? Paymentinfo(
                                            text: "Montant total",
                                            infotext:
                                                "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderTotal} ${currency}") : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: Get.height * 0.02),
                      preScriptionControllre.preDetailsInfo?.pOrderProductList
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
                                              preScriptionControllre.preDetailsInfo?.pOrderProductList
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
                                          preScriptionControllre.preDetailsInfo?.pOrderProductList
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
                            Text("Client",
                                style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: BlackColor,
                                    fontSize: 16)),
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
                                            preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
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
                                preScriptionControllre.preDetailsInfo
                                            ?.pOrderProductList.flowId !=
                                        "7"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(color: Colors.grey.shade300),
                                          Text(
                                              preScriptionControllre
                                                      .preDetailsInfo
                                                      ?.pOrderProductList
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
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      preScriptionControllre
                                  .preDetailsInfo?.pOrderProductList.flowId ==
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
                                      imageEncoded = "";
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
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      }),
    );
  }

  Widget numberfield(
      {Widget? suffixIcon,
      String? lebaltext,
      double? width,
      bool? obscureText,
      String? Function(String?)? validator,
      TextEditingController? controller}) {
    return Container(
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText!,
        keyboardType: TextInputType.number,
        readOnly: false,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Gilroy Medium",
          color: BlackColor,
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: lebaltext,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: gradient.defoultColor),
            borderRadius: BorderRadius.circular(15),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: greyColor.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(15)),
        ),
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
