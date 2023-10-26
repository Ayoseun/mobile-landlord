import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../models/dashItem.dart';
import '../../models/pharm.dart';
import '../../utils/app_utils.dart';
import '../../utils/local_storage.dart';
import '../../utils/location.dart';
import '../../utils/permissions.dart';

import '../drawer_menu/sidebar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CarouselController carouselController = CarouselController();
  int _sliderIndex = 0;

  final _sliderItemLength = DashItems.loadItems().length;
  final _sliderItem = DashItems.loadItems();
  // final Size = MediaQuery.of(context).size;
  var photo = 'https://picsum.photos/200';

  bool loaded = false;

  var _serviceEnabled;

  var _permissionGranted;

  var fullAddress = 'fetching your location ...';
  getData() async {
    email = await showEmail();
    var mlocate =
        await getAddress(getUserLocation(_serviceEnabled, _permissionGranted));
    print(mlocate['fullAddress'].toString());
    fullAddress = mlocate['fullAddress'].toString();
    await saveUserState(mlocate['state']);
    await saveCity(mlocate['city']);
    setState(() {
      email;
      fullAddress;
    });
  }

  String searchItem = '';

  static const alarmValueKey = ValueKey('Alarm');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<Key> valueNotifier = ValueNotifier<Key>(alarmValueKey);
  void toggleDrawer() {
    setState(() {
      if (_scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.openEndDrawer();
      } else {
        _scaffoldKey.currentState!.openDrawer();
      }
    });
  }

  List<Map> ListItem = [
    {'image': "assets/images/icons/pills.png", 'text': 'Get medications.'},
    {
      'image': "assets/images/icons/textrack.png",
      'text': 'Order for a lab test'
    },
    {'image': "assets/images/icons/upload.png", 'text': 'Upload Prescription'},
    {'image': "assets/images/images/support_doc.jpeg", 'text': 'Ask Pharm Josy'},
  ];
  List<Map> med = [
    {
      'image': "assets/images/images/pharmplug_icon_row3.png",
      'header': "Instant Home Deliveries",
      'text': 'Enjoy Home deliveries on products and prescriptions '
    },
    {
      'image': "assets/images/images/pharmplug_icon_row4.png",
      'header': "24/7 Customer support",
      'text': "Call, chat or reach a pharmacist anytime anyday"
    },
    {
      'image': "assets/images/images/pharmplug_icon_row1.png",
      'header': "PharmPlug Special",
      'text': 'Special programs and services are available from time to time.'
    },
    {
      'image': "assets/images/images/pharmplug_icon_row2.png",
      'header': 'Instant Discounts',
      'text': 'Instant discounts are available on products and prescriptions'
    },
  ];
  var fullname = "";
  var name = "";
  var surname = "";
  var email = "";
  getName() async {
    name = await showName();
    surname = await showSurname();

    setState(() {
      name;
      surname;
      fullname = "$name $surname";
    });
  }

  _runFilter(value) {
    setState(() {
      searchItem = value;
    });
  }

  @override
  void initState() {
    getName();
    getData();
     
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final _getSize = MediaQuery.of(context).size;
    final _sliderItemLength = DashItems.loadItems().length;
    final _sliderItem = DashItems.loadItems();
    final Size = MediaQuery.of(context).size;
    final walkThroughItem = PharmItems.loadItems();
    List<Widget> items = [];
    for (var item in _sliderItem) {
      items.add(SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _getSize.height * 0.21,
              child: ClipRRect(
                child: Image.asset(
                  item.image,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(
              height: _getSize.height * 0.005,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Get',
                      style: AppFonts.body1.copyWith(
                        color: Pallete.black,
                        fontSize: _getSize.height * 0.015,
                      )),
                  TextSpan(
                      text: ' prescribed medications',
                      style: AppFonts.body1.copyWith(
                          color: Pallete.black,
                          fontSize: _getSize.height * 0.02,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: ' catered for you',
                      style: AppFonts.body1.copyWith(
                        color: Pallete.black,
                        fontSize: _getSize.height * 0.015,
                      )),
                ],
              ),
            ),
          ],
        ),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(
        email: email,
        fullname: fullname,
        photo: photo,
      ),
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      toggleDrawer();
                                    },
                                    child: ClipOval(
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Pallete.primaryColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Pallete.black,
                                                    blurRadius: 15,
                                                    spreadRadius: 7,
                                                    offset: Offset(11, 3))
                                              ]),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.menu_sharp,
                                                color: Pallete.whiteColor),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Hi ',
                                              style: AppFonts.boldTextPrimary
                                                  .copyWith(
                                                      color: Pallete.black,
                                                      fontSize: 18),
                                            ),
                                            Text(
                                              name,
                                              style: AppFonts.boldTextPrimary
                                                  .copyWith(
                                                      color: Pallete.black,
                                                      fontSize: 18),
                                            ),
                                            Image.asset(
                                              AppImages.waver,
                                              height: 25,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.location,
                                              height: 10,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              fullAddress,
                                              style: AppFonts.bodyThinColoured
                                                  .copyWith(
                                                      fontSize: 10,
                                                      color: Pallete.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.ordersScreen);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 212, 216, 211),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            AppImages.order,
                                            width: 16,
                                            height: 16,
                                            color: Pallete.primaryColor,
                                          ),
                                          Text(
                                            'Orders',
                                            style: AppFonts.bodyThinColoured
                                                .copyWith(
                                                    fontSize: 8,
                                                    color: Pallete.black),
                                          )
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.03,
                          ),
                          Container(
                            height: _getSize.height * 0.055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Color(0xFF949494),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: TextField(
                                      onChanged: (value) => _runFilter(value),
                                      decoration: const InputDecoration(
                                        hintText: 'Search for any drugs',
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          AppFonts.body1.copyWith(fontSize: 14),
                                      // Add any necessary event handlers for text changes or submission.
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (searchItem.isEmpty) {
                                      AppUtils.showSnackBarMessage(
                                          'Enter an item to search for',
                                          context);
                                    } else {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.randomSearch,
                                        arguments: {
                                          'search': searchItem,
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Pallete.secondaryColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.025,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: _getSize.height * 0.25,
                            width: Size.width,
                            child: CarouselSlider(
                              carouselController: carouselController,
                              items: items,
                              //Slider Container properties
                              options: CarouselOptions(
                                reverse: true,
                                autoPlay: true,
                                height: _getSize.height * 0.3,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _sliderIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 16),
                            child: SizedBox(
                              height: 8,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _sliderItemLength,
                                itemBuilder: (BuildContext context, int i) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      child: Container(
                                        width: _sliderIndex == i ? 50 : 8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: _sliderIndex == i
                                                ? Pallete.text
                                                : Color(0xFFC2C2C2)),
                                      ));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.045,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'What do you need today?',
                          style: AppFonts.boldText.copyWith(
                              fontSize: _getSize.height * 0.02,
                              fontWeight: FontWeight.w600,
                              color: Pallete.black),
                        ),
                      ),
                      SizedBox(
                          height: _getSize.height * 0.15,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: ListItem.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Navigator.of(context)
                                            .pushNamed(AppRoutes.storeScreen);
                                      } else if (i == 1) {
                                        Navigator.of(context)
                                            .pushNamed(AppRoutes.bookATest);
                                      } else if (i == 2) {
                                       // openWhatsAppChatPrescription();
                                      } else if (i == 3) {
                                        Navigator.of(context)
                                            .pushNamed(AppRoutes.speakWithDoc);
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: _getSize.height * 0.12,
                                          width: _getSize.width * 0.27,
                                          decoration: const BoxDecoration(
                                              color: Pallete.whiteColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xACE7E7E7),
                                                  blurRadius: 11,
                                                  spreadRadius: 1,
                                                  offset: Offset(0, 5),
                                                )
                                              ],
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 8, right: 8),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  ListItem[i]['image'],
                                                  height:
                                                      _getSize.height * 0.04,
                                                ),
                                                SizedBox(
                                                  height:
                                                      _getSize.height * 0.007,
                                                ),
                                                SizedBox(
                                                    width:
                                                        _getSize.width * 0.17,
                                                    child: Text(
                                                      ListItem[i]['text'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppFonts.bodyText
                                                          .copyWith(
                                                              fontSize: _getSize
                                                                      .height *
                                                                  0.011),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.025,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.refer);
                    },
                    child: Image.asset(
                      AppImages.refer,
                      width: _getSize.width,
                      height: _getSize.height * 0.15,
                    ),
                  ),
                  SizedBox(
                    height: _getSize.height * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: _getSize.height * 0.2,
                          child: ListView.builder(
                              itemCount: med.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Image.asset(
                                                    med[i]['image'],
                                                    height: 40,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      med[i]['header'],
                                                      style: AppFonts.bodyText
                                                          .copyWith(
                                                              color: Pallete
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              SizedBox(
                                                  width: _getSize.width * 0.35,
                                                  child: Text(
                                                    med[i]['text'],
                                                    textAlign: TextAlign.start,
                                                    style: AppFonts.bodyText
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
