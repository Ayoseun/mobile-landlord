import 'dart:convert';

import 'package:abjalandlord/components/buttons.dart';
import 'package:abjalandlord/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_routes.dart';
import '../../utils/app_utils.dart';
import '../../utils/local_storage.dart';

class Property extends StatefulWidget {
  const Property({Key? key}) : super(key: key);

  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  int _tabIndex = 0;
  bool loaded = false;
  List property = [];
  getPropertyItems() async {
    var propertyString = await showPropertyItem();
   
    var getproperty =
        List<Map<String, dynamic>>.from(jsonDecode(propertyString));
    if (getproperty.isEmpty) {
      setState(() {
        property = [];
    

        loaded = true;
      });
    } else {
      setState(() {
        property = getproperty;
     
        loaded = true;
      });
    }
  }

  @override
  void initState() {
    getPropertyItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                children: const [Text(""), Icon(Icons.filter_list)],
              ),
              SizedBox(
                height: _getSize.height * 0.035,
              ),
              Container(
                height: _getSize.height * 0.055,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Color(0xFF949494),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextField(
                          onChanged: (value) => _runFilter(value),
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                          style: AppFonts.body1.copyWith(fontSize: 14),
                          // Add any necessary event handlers for text changes or submission.
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var searchItem;
                        if (searchItem.isEmpty) {
                          AppUtils.showSnackBarMessage(
                              'Enter an item to search for', context);
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
                        padding: EdgeInsets.all(12.0),
                        child: Image.asset(AppImages.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              SizedBox(
                height: _getSize.height * 0.76,
                child: Stack(children: [
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabNavBar(
                          tabIndex: _tabIndex,
                          tabTextList: [
                            'Leased (${property.length})',
                            'Vacant (${property.length})',
                          ],
                          onTap: (index) {
                            setState(() {
                              _tabIndex = index;
                            });
                          },
                        ),
                        !loaded
                            ? Container(
                                margin: EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF6F9F5),
                                    borderRadius: BorderRadius.circular(10)),
                                width: _getSize.width,
                                height: _getSize.height * 0.38,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                            : Column(
                                children: [
                                  property.isEmpty
                                      ? Container(
                                          margin: EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF6F9F5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: _getSize.width,
                                          height: _getSize.height * 0.38,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Image.asset(
                                                  AppImages.no_prop,
                                                  width: _getSize.width * 0.6,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "You currently have no added property",
                                                      style: AppFonts.body1,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      _getSize.height * 0.01,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ) // Widget to show when many is 0
                                      : SizedBox(
                                          height: _getSize.height * 0.6795,
                                          child: TabBarView(
                                            // physics: const NeverScrollableScrollPhysics(),
                                            children: <Widget>[
                                              tabContent(
                                                propertyData: property,
                                                getSize: _getSize,
                                                items: 5,
                                              ),
                                              tabContent(
                                                propertyData: property,
                                                getSize: _getSize,
                                                items: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    child: ButtonWithFuction(
                        text: 'Add Property',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.addProperty);
                        }),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class tabContent extends StatelessWidget {
  tabContent(
      {super.key,
      required Size getSize,
      required this.items,
      required this.propertyData})
      : _getSize = getSize;

  final Size _getSize;
  final int items;
  List propertyData;

  /**
   *     PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: MainScreen(),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
   */
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _getSize.height * 0.25,
        child: ListView.builder(
            itemCount: propertyData.length + 1,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => (index != propertyData.length)
                ? GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      AppRoutes.propDetails,
                      arguments: {
                        'data': propertyData[index]['propertyID'],
                      },
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                propertyData[index]['photo'],
                                fit: BoxFit.cover,
                                width: _getSize.width * 0.45,
                                height: _getSize.width * 0.35,
                              ),
                              Positioned(
                                left: _getSize.width * 0.03,
                                bottom: _getSize.height * 0.105,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(137, 246, 249, 245),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              104, 246, 249, 245),
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
                                        vertical: 4.0, horizontal: 14),
                                    child: Row(
                                      children: [
                                        Text(
                                          propertyData[index]['unitData']
                                              .length
                                              .toString(),
                                          style: AppFonts.body1.copyWith(
                                            color: Pallete.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: _getSize.height * 0.017,
                                          ),
                                        ),
                                        SizedBox(width: _getSize.width * 0.01),
                                        Text("Unit",
                                            style: AppFonts.body1.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Pallete.primaryColor,
                                              fontSize: _getSize.height * 0.017,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: _getSize.width * 0.03,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    propertyData[index]['name'],
                                    style: AppFonts.boldText.copyWith(
                                        fontSize: _getSize.height * 0.017,
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromARGB(255, 12, 12, 12)),
                                  ),
                                  SizedBox(
                                    height: _getSize.height * 0.005,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImages.estate,
                                        width: _getSize.width * 0.04,
                                      ),
                                      SizedBox(
                                        width: _getSize.width * 0.008,
                                      ),
                                      Text(
                                        propertyData[index]['type'],
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.fade,
                                            fontSize: _getSize.height * 0.015),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: _getSize.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImages.location,
                                        width: _getSize.width * 0.04,
                                        color: Pallete.primaryColor,
                                      ),
                                      SizedBox(
                                        width: _getSize.width * 0.008,
                                      ),
                                      SizedBox(
                                        width: _getSize.width * 0.38,
                                        child: Text(
                                          propertyData[index]['location'],
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.body1.copyWith(
                                              color: Pallete.fade,
                                              fontSize:
                                                  _getSize.height * 0.015),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.01,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Description",
                                      style: AppFonts.boldText.copyWith(
                                          fontSize: _getSize.height * 0.017,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF333436))),
                                  SizedBox(
                                    height: _getSize.height * 0.0025,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.38,
                                    child: Text(
                                      propertyData[index]['description'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFonts.body1.copyWith(
                                          fontSize: _getSize.height * 0.015),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: _getSize.height * 0.15,
                  )));
  }
}

_runFilter(String value) {}

class TabNavBar extends StatefulWidget {
  const TabNavBar({
    Key? key,
    required this.tabIndex,
    required this.tabTextList,
    required this.onTap,
  }) : super(key: key);

  final int tabIndex;
  final List<String> tabTextList;
  final Function(int)? onTap;

  @override
  _TabNavBarState createState() => _TabNavBarState();
}

class _TabNavBarState extends State<TabNavBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      decoration: BoxDecoration(
        color: Pallete.backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        onTap: widget.onTap,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Pallete.fade,
        indicator: BoxDecoration(
          color: Pallete.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        tabs: widget.tabTextList
            .map((tabText) => TabBarItem(
                  text: tabText,
                  count: widget.tabTextList.length,
                ))
            .toList(),
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    Key? key,
    required this.count,
    required this.text,
  }) : super(key: key);

  final String text;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: count == 5 ? 9 : 12,
          ),
        ),
      ),
    );
  }
}
