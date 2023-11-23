import 'package:abjalandlord/components/buttons.dart';
import 'package:abjalandlord/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_routes.dart';
import '../../utils/app_utils.dart';

class Property extends StatefulWidget {
  const Property({Key? key}) : super(key: key);

  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: _getSize.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(""), Icon(Icons.filter_list)],
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
                   height: _getSize.height * 0.7412,
                child: Stack(children: [
                    
                  SizedBox(
                      height: _getSize.height*0.9,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabNavBar(
                              tabIndex: _tabIndex,
                              tabTextList: const [
                                'Leased (5)',
                                'Vacant (2)',
                              ],
                              onTap: (index) {
                                setState(() {
                                  _tabIndex = index;
                                });
                              },
                            ),
                            SizedBox(
                              height: _getSize.height * 0.6781,
                              child: TabBarView(
                                // physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  tabContent(
                                    getSize: _getSize,
                                    items: 5,
                                  ),
                                  tabContent(
                                    getSize: _getSize,
                                    items: 2,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                           Positioned(
                    bottom: 60,
                    child: ButtonWithFuction(
                      text: 'Add Property',
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.addProperty);
                      }),
                  ) , ]),
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
           
            ],
          ),
        ),
      ),
    ));
  }
}

class tabContent extends StatelessWidget {
  const tabContent({super.key, required Size getSize, required this.items})
      : _getSize = getSize;

  final Size _getSize;
  final int items;

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
        child: ListView.builder(
            itemCount: items,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {

              if (items==items) {
                
              } else {
                   return GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.propDetails),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            AppImages.condo1,
                            fit: BoxFit.contain,
                            width: _getSize.width * 0.45,
                          ),
                          Positioned(
                            left: _getSize.width * 0.03,
                            bottom: _getSize.height * 0.105,
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
                                    vertical: 4.0, horizontal: 14),
                                child: Row(
                                  children: [
                                    Text(
                                      "7",
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.primaryColor,
                                          fontSize: 14),
                                    ),
                                    SizedBox(width: _getSize.width * 0.01),
                                    Text("Rentals",
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.primaryColor,
                                            fontSize: 14))
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
                                "The Spring Lounge",
                                style: AppFonts.boldText.copyWith(
                                    fontSize: 13,
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
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.008,
                                  ),
                                  Text(
                                    "Condo Apartment",
                                    style: AppFonts.body1.copyWith(
                                        color: Pallete.fade, fontSize: 12),
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
                                    width: 15,
                                    color: Pallete.primaryColor,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.008,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.4,
                                    child: Text(
                                      "24 commercial avenue Kampal",
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.fade, fontSize: 12),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.015,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description",
                                  style: AppFonts.boldText.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF333436))),
                              SizedBox(
                                height: _getSize.height * 0.0025,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.35,
                                child: Text(
                                  "Bright, spacious 2-bedroom apartment in a quiet neighborhood. Close to shops, restau...",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.body1.copyWith(fontSize: 12),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
           
              }
            }));
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
        physics: BouncingScrollPhysics(),
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
