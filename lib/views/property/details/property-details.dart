import 'package:abjalandlord/constants/app_colors.dart';
import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/constants/app_images.dart';
import 'package:abjalandlord/constants/app_routes.dart';
import 'package:abjalandlord/constants/resources.dart';
import 'package:abjalandlord/views/property/details/widgets/full_property.dart';
import 'package:abjalandlord/views/property/details/widgets/unit_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../../../network/property.dart';
import '../../../utils/backpressed.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  List<String> items = List.generate(20, (index) => 'Item $index');

  int _currentIndex = 0;
  List<String> imgList = [];
  final CarouselController _carouselController = CarouselController();
  String formattedDate = "";
  void maind() {
    final DateTime now = DateTime.now();
    formattedDate = formatDate(now);
    print(formattedDate);
  }

  int currentIndexs = 0;
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
  int unitIndex = -1;
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
      imgList.add(property['photo'] ?? imgHolder);
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
     print(unitIndex);
    _scrollController.addListener(() {
      setState(() {
        _currentPage = (_scrollController.offset / 100).round();
      });
    });
    super.initState();
  }

  ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  void scrollToNextItem() {
    _scrollController.animateTo(
      _scrollController.offset +
          400, // Adjust this value based on your item size
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    if (_currentIndex == imgList.length) {
    } else {
      _currentIndex++;
    }
  }

  void scrollToPreviousItem() {
    _scrollController.animateTo(
      _scrollController.offset -
          400, // Adjust this value based on your item size
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    if (_currentIndex == 0) {
    } else {
      _currentIndex--;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    propID = dataFromRoute["data"];

    final _getSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
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
                      const Text("Property Details"),
                      const Text("")
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
                                SizedBox(
                                  height: _getSize.height * 0.3,
                                  width: _getSize.width,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,

                                    itemCount: imgList
                                        .length, // Change this based on your actual item count
                                    itemBuilder: (context, index) {
                                      // Replace this with your actual ListView item
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          // Clip the image to match the border radius
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                              height: _getSize.height * 0.25,
                                              width: _getSize.width * 0.9,
                                              imgList[index] != null
                                                  ? imgList[index]
                                                  : imgHolder,
                                              fit: BoxFit.fill),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                property['structure'] != "Standalone"
                                    ?
                                     Positioned(
                                        left: _getSize.width * 0.07,
                                        bottom: _getSize.height * 0.24,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  137, 246, 249, 245),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      113, 246, 249, 245),
                                                  blurRadius: 11,
                                                  spreadRadius: 2,
                                                  offset: Offset(0, 5),
                                                )
                                              ],
                                              border: Border.all(
                                                  width: 0.3,
                                                  color: Pallete.fade),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal:
                                                      _getSize.height * 0.018),
                                              child: !isUnitAvaialble
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          property['unitData']
                                                              .length
                                                              .toString(),
                                                          style: AppFonts.body1
                                                              .copyWith(
                                                            color: Pallete
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: _getSize
                                                                    .height *
                                                                0.018,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                _getSize.width *
                                                                    0.01),
                                                        Text("Unit",
                                                            style: AppFonts.body1.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Pallete
                                                                    .primaryColor,
                                                                fontSize: _getSize
                                                                        .height *
                                                                    0.018))
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        !propertyUnits[
                                                                    unitIndex]
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
                                                                        color: Colors
                                                                            .red),
                                                              ),
                                                      ],
                                                    )),
                                        ),
                                      )
                                    : SizedBox(),
                                property['structure'] != "Standalone"
                                    ? Positioned(
                                        bottom: 40, // adjust position as needed
                                        left: 0, right: 0,
                                        child: _buildDotsIndicator(),
                                      )
                                    : Text(''),
                                property['structure'] != "Standalone"
                                    ? 
                                    Positioned(
                                        top: 130, // adjust position as needed
                                        left: 30,
                                        child: SizedBox(
                                          width: _getSize.width * 0.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ClipOval(
                                                child: Container(
                                                  width: _getSize.width * 0.08,
                                                  height:
                                                      _getSize.height * 0.037,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 0.2,
                                                        color: Pallete.fade),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.arrow_back,
                                                      size: 16,
                                                    ),
                                                    onPressed: () {
                                                      //  print(unitCount);
                                                      scrollToPreviousItem();
                                                      if (unitIndex == 0) {
                                                        setState(() {
                                                          isUnitAvaialble =
                                                              false;
                                                        });
                                                      } else if (unitIndex >
                                                          -1) {
                                                        unitIndex--;
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              ClipOval(
                                                child: Container(
                                                  width: _getSize.width * 0.08,
                                                  height:
                                                      _getSize.height * 0.037,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 0.2,
                                                        color: Pallete.fade),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.arrow_forward,
                                                      size: 16,
                                                    ),
                                                    onPressed: () {
                                            
                                                      print(
                                                          propertyUnits.length-1);
                                                      print(unitIndex);
                                                      if (unitIndex ==
                                                          propertyUnits
                                                              .length-1) {
                                                                      
                                                      } else {
                                                   print(
                                                          propertyUnits.length);
                                                      print(unitIndex);
                                                        scrollToNextItem();
                                                        unitIndex++;
                                                        isUnitAvaialble = true;
                                                      }

                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Text(''),
                              ],
                            ),
                            !isUnitAvaialble
                                //Main property view
                                ? FullPropertyContent(
                                    getSize: _getSize,
                                    property: property,
                                     propertyUnits: propertyUnits,
                                       unitCount: unitIndex,
                                    images: images,
                                    service: service)
                                //Individual unit view
                                : UnitContent(
                                    getSize: _getSize,
                                    property: property,
                                    propertyUnits: propertyUnits,
                                    unitCount: unitIndex,
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
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        imgList.length, // Change this based on your actual item count
        (index) => Container(
          width: 32.0,
          height: 4.0,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: Pallete.fade),
            borderRadius: BorderRadius.circular(2),
            color: _currentIndex == index ? Colors.white : Pallete.fade,
          ),
        ),
      ),
    );
  }
}
