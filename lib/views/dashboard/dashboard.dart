import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
    {
      'image': "assets/images/images/support_doc.jpeg",
      'text': 'Ask Pharm Josy'
    },
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

    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(
        email: "ayoseunsolomon@gmai.com",
        fullname: "ayo solomon",
        photo: photo,
      ),
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Container(
              width: _getSize.width,
              height: _getSize.height,
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
                                              'Hello ',
                                              style: AppFonts.bodyText.copyWith(
                                                  color: Pallete.primaryColor,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "Daniel",
                                              style: AppFonts.bodyText.copyWith(
                                                  color: Pallete.primaryColor,
                                                  fontSize: 18),
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
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.boy,
                                      width: 56,
                                      height: 56,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.003,
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
                                        hintText: 'Search',
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
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.search,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Properties',
                        style: AppFonts.boldText.copyWith(
                            fontSize: _getSize.height * 0.018,
                            fontWeight: FontWeight.w300,
                            color: Pallete.text),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.01,
                      ),
                      properties(getSize: _getSize),
                      middle(getSize: _getSize),
                      SizedBox(
                        height: _getSize.height * 0.035,
                      ),
                      bottom(getSize: _getSize)
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

class properties extends StatelessWidget {
  const properties({
    super.key,
    required Size getSize,
  }) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _getSize.width,
        height: _getSize.height * 0.41,
        child: ListView.builder(
            itemCount: 5,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.propDetails);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: _getSize.width * 0.02),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            AppImages.condo1,
                            fit: BoxFit.contain,
                            width: _getSize.width * 0.5,
                          ),
                          Positioned(
                            left: _getSize.width * 0.03,
                            bottom: _getSize.height * 0.11,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(47, 101, 105, 100),
                                      blurRadius: 11,
                                      spreadRadius: 1,
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  border: Border.all(
                                      width: 0.3, color: Pallete.fade),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      "7",
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.primaryColor,
                                          fontSize: 16),
                                    ),
                                    SizedBox(width: _getSize.width * 0.01),
                                    Text("Rentals",
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.primaryColor,
                                            fontSize: 16))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.01,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The Spring Lounge",
                            style: AppFonts.boldText.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF333436)),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.005,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.estate,
                                width: 20,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.008,
                              ),
                              Text(
                                "Condo Apartment",
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade, fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.01,
                          ),
                          Row(
                            children: [
                              Image.asset(AppImages.location, width: 14),
                              SizedBox(
                                width: _getSize.width * 0.008,
                              ),
                              Text(
                                "24 commercial avenue Kampal",
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade, fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description",
                                style: AppFonts.boldText.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF333436))),
                            SizedBox(
                              height: _getSize.height * 0.0025,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.5,
                              child: Text(
                                "Bright, spacious 2-bedroom apartment in a quiet neighborhood. Close to shops, restaurants, and public transportation.",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.body1.copyWith(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}

class middle extends StatelessWidget {
  const middle({
    super.key,
    required Size getSize,
  }) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: _getSize.height * 0.07,
          width: _getSize.width * 0.28,
          decoration: BoxDecoration(
              color: Color.fromARGB(97, 29, 89, 103),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(68, 85, 80, 80),
                  blurRadius: 11,
                  spreadRadius: 1,
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("05",
                        style: AppFonts.boldText.copyWith(
                          fontSize: 16,
                          color: Color(0xFF1D5A67),
                        )),
                    Image.asset(
                      AppImages.estate,
                      width: 24,
                      color: Color(0xFF1D5A67),
                    ),
                  ],
                ),
                SizedBox(
                  width: _getSize.width * 0.04,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFF1D5A67),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Property",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFF1D5A67,
                          ),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: _getSize.height * 0.07,
          width: _getSize.width * 0.28,
          decoration: BoxDecoration(
              color: Color(0xFFFCDBB5),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(68, 85, 80, 80),
                  blurRadius: 11,
                  spreadRadius: 1,
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("02",
                        style: AppFonts.boldText
                            .copyWith(fontSize: 18, color: Color(0xFFF58807))),
                    Image.asset(
                      AppImages.house,
                      color: Color(0xFFF58807),
                    ),
                  ],
                ),
                SizedBox(
                  width: _getSize.width * 0.04,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Vacant",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFFF58807),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Property",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFFF58807,
                          ),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: _getSize.height * 0.07,
          width: _getSize.width * 0.28,
          decoration: BoxDecoration(
              color: Color(0xFFD6B5DE),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(68, 85, 80, 80),
                  blurRadius: 11,
                  spreadRadius: 1,
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.rent,
                      color: Color(0xFF750790),
                    ),
                  ],
                ),
                SizedBox(
                  width: _getSize.width * 0.04,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Add",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFF750790),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Tenant",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFF750790,
                          ),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class bottom extends StatelessWidget {
  const bottom({
    super.key,
    required Size getSize,
  }) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: _getSize.height * 0.25,
        width: _getSize.width,
        decoration: BoxDecoration(
            color: Pallete.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(89, 113, 109, 109),
                blurRadius: 7,
                spreadRadius: 1,
                offset: Offset(1, 2),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: _getSize.width,
              height: _getSize.height * 0.13,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 88, 108, 84),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Explore our different plans for ",
                    style: AppFonts.body1
                        .copyWith(fontSize: 20, color: Pallete.whiteColor),
                  ),
                  Text(
                    "advanced features and benefits!",
                    style: AppFonts.body1
                        .copyWith(fontSize: 20, color: Pallete.whiteColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Abja",
                style: AppFonts.boldText.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(49, 40, 54, 36)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
