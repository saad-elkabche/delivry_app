// ignore_for_file: camel_case_types, use_key_in_widget_constructors, annotate_overrides, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:async';

import 'package:deliveryboy/Api/data_store.dart';
import 'package:deliveryboy/helpar/fontfamily_model.dart';
import 'package:deliveryboy/screen/bottombar_screen.dart';
import 'package:deliveryboy/screen/login_Screen.dart';
import 'package:deliveryboy/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class onbording extends StatefulWidget {
  const onbording({Key? key}) : super(key: key);

  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () => getData.read("Firstuser") != true
          ? Get.to(() => BoardingPage())
          : getData.read("Remember") != true
              ? Get.to(() => const Loginscreen())
              : Get.to(() => BottoBarScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WhiteColor,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/Splash.png"), fit: BoxFit.fill),
              gradient: gradient.btnGradient3),
          child: Center( child: Image.asset("assets/logo-light.png", height: 128, width: 128) ),
        ));
  }
}

class BoardingPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BoardingPageState createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  // creating all the widget before making our home screeen
  // SubscribeController subscribeController = Get.find();
  // ListOfPropertiController listOfPropertiController = Get.find();

  void initState() {
    // getdarkmodepreviousstate();
    super.initState();

    _currentPage = 0;

    _slides = [
      Slide("assets/addintro1.png", "Devenez livreur Daway",
          "Vous souhaitez devenir livreur pour Daway ?"),
      Slide("assets/addintro2.png", "Acceptez une commande",
          "Si vous êtes disponible, appuyez pour accepter la livraison.."),
      Slide("assets/addintro3.png", "Livrez la commande au client",
          "Vous aurez accès à l’adresse du client afin d’effectuer la livraison."),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  // the list which contain the build slides
  List<Widget> _buildSlides() {
    return _slides.map(_buildSlide).toList();
  }

  Widget _buildSlide(Slide slide) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.07), //upar thi jagiya mukeli che
          Container(
            height: MediaQuery.of(context).size.height * 0.5, //imagee size
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topRight,
            child: Image.asset(
              slide.image,
              fit: BoxFit.cover,
            ),
            // color: BlackColor,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          SizedBox(
            width: Get.width * 0.7,
            child: Text(
              slide.heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Gilroy Bold",
                  color: BlackColor), //heding Text
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            slide.subtext,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                color: greyColor,
                fontFamily: "Gilroy Medium"), //subtext
          ),
        ],
      ),
    );
  }

  // handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  // building page indicator
  Widget _buildPageIndicator() {
    Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for (int i = 0; i < _slides.length; i++) {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1)
        // ignore: curly_braces_in_flow_control_structures
        row.children.add(
          const SizedBox(
            width: 10,
          ),
        );
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      padding: EdgeInsets.all(2),
      width: index == _currentPage ? 14 : 12,
      height: index == _currentPage ? 14 : 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: index == _currentPage
                ? Color(0xff042628)
                : greyColor.withOpacity(0.8)),
      ),
      child: Container(
        width: index == _currentPage ? 14 : 10,
        height: index == _currentPage ? 14 : 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPage
                ? Color(0xff042628)
                : greyColor.withOpacity(0.8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: const BouncingScrollPhysics(),
            children: _buildSlides(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                _buildPageIndicator(),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.33, //indicator set screen
                ),
                _currentPage == 2
                    ? GestureDetector(
                        onTap: () {
                          Get.to(() => const Loginscreen());
                          // listOfPropertiController.getPropertiList();
                          // subscribeController.getSubscribeDetailsList();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              gradient: gradient.btnGradient,
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Get Started".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: WhiteColor,
                                  fontFamily: "Gilroy Bold"),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              gradient: gradient.btnGradient,
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Suivant".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: WhiteColor,
                                  fontFamily: "Gilroy Bold"),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.012, //indicator set screen
                ),
                // GestureDetector(
                //   onTap: () {},
                //   child: Text(
                //     "Skip",
                //     style: TextStyle(
                //       fontSize: 18,
                //       color: Darkblue,
                //       fontFamily: "Gilroy Bold",
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20)
              ],
            ),
          )
        ],
      ),
    );
  }

//   getdarkmodepreviousstate() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? previusstate = prefs.getBool("setIsDark");
//     if (previusstate == null) {
//       notifire.setIsDark = false;
//     } else {
//       notifire.setIsDark = previusstate;
//     }
//   }
}

class Slide {
  String image;
  String heading;
  String subtext;

  Slide(this.image, this.heading, this.subtext);
}
