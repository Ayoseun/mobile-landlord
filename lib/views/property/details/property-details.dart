import 'package:abjalandlord/components/buttons.dart';
import 'package:abjalandlord/constants/app_colors.dart';
import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/constants/app_images.dart';
import 'package:abjalandlord/constants/app_routes.dart';
import 'package:abjalandlord/views/property/details/widgets/main_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:image_stack/image_stack.dart';

import '../../../network/property.dart';
import '../../notification/tab_content/all.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  int _currentIndex = 0;
  List<String> imgList = [];
  final CarouselController _carouselController = CarouselController();
  String formattedDate = "";
  void maind() {
    final DateTime now = DateTime.now();
    formattedDate = formatDate(now);
    print(formattedDate);
  }

  List<Map> service = [
    {
      'icon': AppImages.cleaner,
      'text': '2nd Floor- Back',
      'text2': "Mr. Eric is in need of house cleaning."
    },
    {
      'icon': AppImages.movers,
      'color': Color(0xFFFFE4E9),
      'text': '1st Floor- Front',
      'text2': "Miss Susan is in need of  home movers into their apartment."
    },
  ];
  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];

  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM, y').format(dateTime);
  }

  bool isLoadingProperty = true;
  var property = {};
  int unitCount = -1;
  String propID = "";
  bool isUnitAvaialble = false;
  List propertyUnits = [];
  getProperties() async {
    await Future.delayed(const Duration(seconds: 1));
    var res = await PropertyAPI.getProperty(propID);

    isLoadingProperty = true;

    var gotproperties = res['data'];

    if (gotproperties.isNotEmpty) {
      property = gotproperties;
      imgList.add(property['photo']);
      propertyUnits = property['unitData'];
      for (var element in property['unitData']) {
        imgList.add(element["photo"]);
      }
      isLoadingProperty = false;
      setState(() {
        property;
        print(property);
      });
    } else {
      setState(() {
        isLoadingProperty = false;
        // property.length = 0;
      });
    }
  }

  @override
  void initState() {
    maind();
    getProperties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    propID = dataFromRoute["id"];

    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.navbar, (route) => false);
                      },
                      child: Image.asset(
                        AppImages.back,
                        width: 36,
                      ),
                    ),
                    Text("Property Details"),
                    Text("")
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                !isLoadingProperty
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              CarouselSlider(
                                carouselController: _carouselController,
                                options: CarouselOptions(
                                  viewportFraction: 1.0,
                                  height: _getSize.height * 0.28,
                                  //  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                                items: imgList.map((item) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width, // Ensure the container takes the full width
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: Pallete.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                              15), // Provides the curved border
                                        ),
                                        child: ClipRRect(
                                          // Clip the image to match the border radius
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(item,
                                              fit: BoxFit.fill),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              Positioned(
                                left: _getSize.width * 0.13,
                                bottom: _getSize.height * 0.21,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(137, 246, 249, 245),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              113, 246, 249, 245),
                                          blurRadius: 11,
                                          spreadRadius: 2,
                                          offset: Offset(0, 5),
                                        )
                                      ],
                                      border: Border.all(
                                          width: 0.3, color: Pallete.fade),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: _getSize.height * 0.018),
                                      child: !isUnitAvaialble
                                          ? Row(
                                              children: [
                                                Text(
                                                  property['unit'],
                                                  style:
                                                      AppFonts.body1.copyWith(
                                                    color: Pallete.primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        _getSize.height * 0.018,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        _getSize.width * 0.01),
                                                Text("Unit",
                                                    style: AppFonts.body1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Pallete
                                                                .primaryColor,
                                                            fontSize: _getSize
                                                                    .height *
                                                                0.018))
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                !propertyUnits[unitCount]
                                                        ['isTaken']
                                                    ? Text(
                                                        "Available",
                                                        style: AppFonts
                                                            .smallWhiteBold
                                                            .copyWith(
                                                                color: Pallete
                                                                    .primaryColor),
                                                      )
                                                    : Text(
                                                        "Taken",
                                                        style: AppFonts
                                                            .smallWhiteBold
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
                                                      ),
                                              ],
                                            )),
                                ),
                              ),
                              Positioned(
                                bottom: 8, // adjust position as needed
                                left: 0, right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: imgList.map((url) {
                                    int index = imgList.indexOf(url);
                                    return Container(
                                      width: 32.0,
                                      height: 4.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.2, color: Pallete.fade),
                                        borderRadius: BorderRadius.circular(2),
                                        color: _currentIndex == index
                                            ? Colors.white
                                            : Pallete.fade,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Positioned(
                                top: 120, // adjust position as needed
                                left: 10,
                                child: ClipOval(
                                  child: Container(
                                    width: _getSize.width * 0.08,
                                    height: _getSize.height * 0.037,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.2, color: Pallete.fade),
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        print(unitCount);

                                        if (unitCount == 0) {
                                          setState(() {
                                            isUnitAvaialble = false;
                                          });
                                        } else if (unitCount > -1) {
                                          unitCount--;
                                          _carouselController.previousPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 120, // adjust position as needed
                                right: 10,
                                child: ClipOval(
                                  child: Container(
                                    width: _getSize.width * 0.08,
                                    height: _getSize.height * 0.037,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.2, color: Pallete.fade),
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        print(imgList);
                                        if (propertyUnits.isNotEmpty &&
                                            unitCount !=
                                                propertyUnits.length - 1) {
                                          _carouselController.nextPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn,
                                          );
                                          unitCount++;
                                          isUnitAvaialble = true;
                                          setState(() {});
                                        } else {}
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          !isUnitAvaialble
                              ? FullPropertyContent(
                                  getSize: _getSize,
                                  property: property,
                                  images: images,
                                  service: service)
                              : UnitContent(
                                  getSize: _getSize,
                                  property: property,
                                  propertyUnits: propertyUnits,
                                  unitCount: unitCount,
                                  images: images)
                        ],
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F9F5),
                            borderRadius: BorderRadius.circular(10)),
                        width: _getSize.width,
                        height: _getSize.height * 0.38,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SpinKitRing(
                                size: 30,
                                color: Pallete.primaryColor,
                                lineWidth: 2.0,
                              ),
                              Text(
                                "Looking for your property Listing",
                                style: AppFonts.body1,
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UnitContent extends StatelessWidget {
  const UnitContent({
    super.key,
    required Size getSize,
    required this.property,
    required this.propertyUnits,
    required this.unitCount,
    required this.images,
  }) : _getSize = getSize;

  final Size _getSize;
  final Map property;
  final List propertyUnits;
  final int unitCount;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _getSize.height * 0.03,
        ),
        SizedBox(
          height: _getSize.height * 0.43,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property['name'],
                            style: AppFonts.boldText.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            property['created_at'],
                            style: AppFonts.body1,
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.estate,
                                width: 18,
                                color: Pallete.primaryColor,
                              ),
                              Text(
                                property['structure'],
                                style: AppFonts.body1.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(AppImages.location,
                                  width: _getSize.width * 0.037),
                              SizedBox(
                                width: _getSize.width * 0.008,
                              ),
                              Text(
                                property['location'],
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade,
                                    fontSize: _getSize.height * 0.016),
                              )
                            ],
                          ),
                          !propertyUnits[unitCount]['isTaken']
                              ? GestureDetector(
                                  onTap: () {
                                    var tenantInfo = {
                                      "propertyID": property['propertyID'],
                                      "unitID": propertyUnits[unitCount]['id']
                                    };
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.addTenant,
                                      arguments: {
                                        'tenant': tenantInfo,
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFF91B88C),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16),
                                      child: Text(
                                        "Add Tenant",
                                        style: AppFonts.smallWhiteBold.copyWith(
                                            color: Pallete.primaryColor),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: AppFonts.boldText.copyWith(
                                fontWeight: FontWeight.w300,
                                color: Pallete.text,
                                fontSize: 14),
                          ),
                          Text(
                            property['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.body1,
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.bedroom,
                                    width: 24,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.01,
                                  ),
                                  Text(propertyUnits[unitCount]['bedroom'])
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.001,
                              ),
                              Text(
                                "Bedroom",
                                style: AppFonts.bodyText.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            width: _getSize.width * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.toilet,
                                    width: 24,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.01,
                                  ),
                                  Text(
                                    propertyUnits[unitCount]['toilet'],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.001,
                              ),
                              Text(
                                "Toilet",
                                style: AppFonts.bodyText.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            width: _getSize.width * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.bathroom,
                                    width: 24,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.01,
                                  ),
                                  Text(propertyUnits[unitCount]['bathroom'])
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.001,
                              ),
                              Text(
                                "Bathroom",
                                style: AppFonts.bodyText.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            width: _getSize.width * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.store,
                                    width: 24,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.01,
                                  ),
                                  Text(propertyUnits[unitCount]['store'])
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.001,
                              ),
                              Text(
                                "Store",
                                style: AppFonts.bodyText.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            width: _getSize.width * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.nepa,
                                    width: 24,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.01,
                                  ),
                                  Text(propertyUnits[unitCount]['waterMeter'])
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.001,
                              ),
                              Text(
                                "Water Meter",
                                style: AppFonts.bodyText.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.nepa,
                                width: 24,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.01,
                              ),
                              Text(propertyUnits[unitCount]['lightMeter'])
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.003,
                          ),
                          Text(
                            "Light Meter",
                            style: AppFonts.bodyText.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Features",
                            style: AppFonts.boldText.copyWith(
                                fontWeight: FontWeight.w300,
                                color: Pallete.text,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.005,
                          ),
                          Row(
                            children: [
                              propertyUnits[unitCount]['wifi']
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          AppImages.wifi,
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.015,
                                        ),
                                        Text(
                                          "Wifi",
                                          style: AppFonts.body1,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.02,
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                              propertyUnits[unitCount]['power']
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          AppImages.power,
                                          width: 24,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.005,
                                        ),
                                        Text(
                                          "24hrs Power",
                                          style: AppFonts.body1,
                                        )
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      propertyUnits[unitCount]['isTaken']
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tenant",
                                  style: AppFonts.boldText.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Pallete.text,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.005,
                                ),
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        propertyUnits[unitCount]['tenantInfo']['selfie'],
                                        width: _getSize.width * 0.14,
                                        height: _getSize.height * 0.065,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: _getSize.width * 0.03,
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: _getSize.width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  ' ${propertyUnits[unitCount]['tenantInfo']['name']} ${propertyUnits[unitCount]['tenantInfo']['surname']}',
                                                  style: AppFonts.boldText
                                                      .copyWith(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                Text(
                                                  "20 June 2023",
                                                  style:
                                                      AppFonts.body1.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: _getSize.width * 0.25,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: Color(0xFFC8DCC5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color:
                                                            Color(0xFF47893F)),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        _getSize.width * 0.025,
                                                  ),
                                                  Text(
                                                    "Paid",
                                                    style: AppFonts
                                                        .smallWhiteBold
                                                        .copyWith(
                                                            color: Color(
                                                                0xFF47893F)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: _getSize.height * 0.0005,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                height: _getSize.height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Pallete.primaryColor),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.dustbin,
                      width: 18,
                    ),
                    SizedBox(
                      width: _getSize.width * 0.03,
                    ),
                    Text(
                      "Delete Property",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.015,
              ),
              ButtonWithFuction(
                  text: "Request Service Provider", onPressed: () {}),
              SizedBox(
                height: _getSize.height * 0.05,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FullPropertyContent extends StatelessWidget {
  const FullPropertyContent({
    super.key,
    required Size getSize,
    required this.property,
    required this.images,
    required this.service,
  }) : _getSize = getSize;

  final Size _getSize;
  final Map property;
  final List<String> images;
  final List<Map> service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _getSize.height * 0.03,
        ),
        SizedBox(
          height: _getSize.height * 0.43,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property['name'],
                            style: AppFonts.boldText.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            property['created_at'],
                            style: AppFonts.body1,
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.estate,
                                width: 18,
                                color: Pallete.primaryColor,
                              ),
                              Text(
                                property['structure'],
                                style: AppFonts.body1.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            width: _getSize.width * 0.05,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 18,
                                color: Color.fromARGB(255, 252, 212, 51),
                              ),
                              Text(
                                "4.7",
                                style: AppFonts.body1,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(AppImages.location,
                                  width: _getSize.width * 0.037),
                              SizedBox(
                                width: _getSize.width * 0.008,
                              ),
                              Text(
                                property['location'],
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade,
                                    fontSize: _getSize.height * 0.016),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF91B88C),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16),
                              child: Text(
                                "Add More Unit",
                                style: AppFonts.smallWhiteBold
                                    .copyWith(color: Pallete.primaryColor),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.006,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: AppFonts.boldText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Pallete.text,
                                fontSize: 14),
                          ),
                          Text(
                            property['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.body1,
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Features",
                            style: AppFonts.boldText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Pallete.text,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.005,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  property['football']
                                      ? PropertyMainprops(
                                          type: "Football",
                                          width: _getSize.width * 0.025,
                                          img: AppImages.football)
                                      : Container(),
                                  property['pool']
                                      ? PropertyMainprops(
                                          type: "Pool",
                                          width: _getSize.width * 0.025,
                                          img: AppImages.swim)
                                      : SizedBox(),
                                  property['wifi']
                                      ? PropertyMainprops(
                                          width: _getSize.width * 0.025,
                                          type: "Wifi",
                                          img: AppImages.wifi)
                                      : Container(),
                                  SizedBox(
                                    width: _getSize.width * 0.025,
                                  ),
                                  property['laundry']
                                      ? PropertyMainprops(
                                          type: "Laundry",
                                          width: _getSize.width * 0.025,
                                          img: AppImages.laundry)
                                      : Container(),
                                  property['garden']
                                      ? PropertyMainprops(
                                          type: "Garden",
                                          width: _getSize.width * 0.025,
                                          img: AppImages.flower)
                                      : SizedBox(),
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.012,
                              ),
                              Row(
                                children: [
                                  property['fitness']
                                      ? PropertyMainprops(
                                          type: "Fitness",
                                          width: _getSize.width * 0.025,
                                          img: AppImages.weightlifting)
                                      : SizedBox(),
                                  property['power']
                                      ? PropertyMainprops(
                                          type: "24 hrs Power",
                                          width: _getSize.width * 0.025,
                                          img: AppImages.power)
                                      : SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      Column(
                        children: [],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tenants",
                            style: AppFonts.boldText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Pallete.text,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.005,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ImageStack(
                                imageList: images,
                                backgroundColor:
                                    Color.fromARGB(49, 209, 209, 209),
                                extraCountTextStyle: AppFonts.body1.copyWith(
                                    color: Pallete.primaryColor,
                                    fontWeight: FontWeight.w600),
                                totalCount: images
                                    .length, // If larger than images.length, will show extra empty circle
                                imageRadius: 45, // Radius of each images
                                imageCount:
                                    3, // Maximum number of images to be shown in stack
                                imageBorderWidth:
                                    0.6, // Border width around the images
                              ),
                              Text(
                                "See More",
                                style: AppFonts.body1.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Pallete.secondaryColor),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Repairs",
                                style: AppFonts.boldText.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Pallete.text,
                                    fontSize: 14),
                              ),
                              Text(
                                "View Details",
                                style: AppFonts.body1
                                    .copyWith(color: Pallete.secondaryColor),
                              )
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.1,
                            child: ListView.builder(
                                itemCount: service.length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          service[index]['icon'],
                                          width: 24,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.03,
                                        ),
                                        Text(
                                          service[index]['text'],
                                          style: AppFonts.bodyText.copyWith(
                                            fontSize: 12,
                                            color: Pallete.text,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Requests",
                                style: AppFonts.boldText.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Pallete.text,
                                    fontSize: 14),
                              ),
                              Text(
                                "View Details",
                                style: AppFonts.body1
                                    .copyWith(color: Pallete.secondaryColor),
                              )
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.09,
                            child: ListView.builder(
                                itemCount: service.length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          service[index]['icon'],
                                          width: 24,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.03,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.75,
                                          child: RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: service[index]['text'],
                                                  style: TextStyle(
                                                    color: Colors
                                                        .black, // Replace with Pallete.black if defined
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' - ',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .grey, // Replace with Pallete.fade if defined
                                                    fontSize: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' ${service[index]['text2']}',
                                                  style: TextStyle(
                                                    color: Pallete
                                                        .text, // Replace with Pallete.fade if defined
                                                    fontSize: 11,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: _getSize.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                height: _getSize.height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Pallete.primaryColor),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.dustbin,
                      width: 18,
                    ),
                    SizedBox(
                      width: _getSize.width * 0.03,
                    ),
                    Text(
                      "Delete Property",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.015,
              ),
              ButtonWithFuction(
                  text: "Request Service Provider", onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
