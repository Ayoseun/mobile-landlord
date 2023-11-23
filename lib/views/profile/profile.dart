import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_stack/image_stack.dart';

import '../../components/buttons.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];
  int _tabIndex = 0;
  var photo = 'https://picsum.photos/200';
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: _getSize.width,
            height: _getSize.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          AppImages.back,
                          width: 36,
                        ),
                      ),
                      Text("Profile"),
                      Text("")
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Row(
                  children: [
                    Container(
                      width: _getSize.width * 0.37,
                      height: _getSize.height * 0.0007,
                      color: Pallete.primaryColor,
                    ),
                    Stack(
                      children: [
                        DottedBorder(
                          borderType: BorderType.Circle,
                          strokeWidth: 2,
                          color: Color(0xFF47893F),
                          dashPattern: [10, 16],
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipOval(
                              child: Image.network(
                                photo,
                                width: _getSize.width * 0.24,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 82,
                            bottom: 1,
                            left: 70,
                            right: 0,
                            child: SizedBox(
                                width: 4,
                                child: Image.asset(
                                  AppImages.cam,
                                )))
                      ],
                    ),
                    Container(
                      width: _getSize.width * 0.37,
                      height: _getSize.height * 0.0007,
                      color: Pallete.primaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Ayo Solomon",
                      style: AppFonts.boldText
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.location,
                          width: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "24, Commercial Avenue, Kampala",
                          style: AppFonts.body1.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.joined,
                          width: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Joined: 27th January, 2023",
                          style: AppFonts.body1
                              .copyWith(color: Pallete.text, fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.editProfile);
                  },
                  child: Container(
                    width: _getSize.width * 0.3,
                    decoration: BoxDecoration(
                        color: Color(0xFF382D18),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: AppFonts.smallWhiteBold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                Container(
                  width: _getSize.width,
                  height: _getSize.height * 0.0007,
                  color: Pallete.primaryColor,
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                middle(
                  getSize: _getSize,
                  img: images,
                ),
                SizedBox(
                  height: _getSize.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                      height: _getSize.height * 0.32,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabNavBar(
                              tabIndex: _tabIndex,
                              tabTextList: const [
                                'About',
                                'Reviews',
                              ],
                              onTap: (index) {
                                setState(() {
                                  _tabIndex = index;
                                });
                              },
                            ),
                            SizedBox(
                              height: _getSize.height * 0.2,
                              child: TabBarView(
                                // physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Hi, I’m Tony Ukachukwu. A landlord and property owner within Kampala and it’s districts. I offer premium and the best qualities of luxury living spaces  within affordable rent fees.",
                                          style: AppFonts.body1
                                              .copyWith(color: Pallete.text),
                                        ),
                                        SizedBox(
                                          height: _getSize.height * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            ImageStack(
                                              imageList: images,
                                              backgroundColor: Color.fromARGB(
                                                  49, 209, 209, 209),
                                              extraCountTextStyle:
                                                  AppFonts.body1.copyWith(
                                                      color:
                                                          Pallete.primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              totalCount: images
                                                  .length, // If larger than images.length, will show extra empty circle
                                              imageRadius:
                                                  45, // Radius of each images
                                              imageCount:
                                                  3, // Maximum number of images to be shown in stack
                                              imageBorderWidth:
                                                  0.6, // Border width around the images
                                            ),SizedBox(width: 24,),
                                            ClipOval(
                                              child: Container(
                                                color: Color.fromARGB(48, 142, 141, 141),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                     vertical: 8.0,horizontal: 14),
                                                  child: Text(
                                                    "+",
                                                    style: AppFonts.body1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Pallete.text,
                                                            fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  bottom(getSize: _getSize)
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: ButtonWithFuction(
                      text: 'Logout',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.welcomeScreen, (route) => false);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class middle extends StatelessWidget {
  const middle({
    super.key,
    required this.img,
    required Size getSize,
  }) : _getSize = getSize;

  final Size _getSize;
  final List<String> img;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(
          width: _getSize.width * 0.04,
        ),
        Container(
          height: _getSize.height * 0.07,
          width: _getSize.width * 0.28,
          decoration: BoxDecoration(
              color: Color(0xFFCDF7FD),
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
                            .copyWith(fontSize: 16, color: Pallete.text)),
                    Image.asset(
                      AppImages.request,
                      width: 18,
                      color: Pallete.text,
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
                      "Request",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFF07D9F5),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Recieved",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFF07D9F5,
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
      ],
    );
  }
}

class bottom extends StatelessWidget {
  const bottom({super.key, required Size getSize}) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    List<Map> services = [
      {
        'img': AppImages.fby,
           'icon': AppImages.electrician,
        'color': Color(0xFFFCEADA),
        'color2': Color(0xFFEF9645),
        'text': 'Bryan Umar',
        'job': 'Electrician',
        'desc':
            'I was very impressed with Bryan’s work. He was prompt, professional, and did a great job fixing the electrical problem in my tenant\'s apartment. I would highly recommend him to anyone who needs an electrician.'
      },
         {
        'img': AppImages.agb,
          'icon': AppImages.plumber,
        'color': Color(0xFFEADAFF),
        'color2': Color(0xFF9747FF),
        'text': 'Bryan Umar',
        'job': 'Plumber',
        'desc':
            'I was very impressed with Bryan’s work. He was prompt, professional, and did a great job fixing the electrical problem in my tenant\'s apartment. I would highly recommend him to anyone who needs an electrician.'
      },
      
    ];
    return SizedBox(
        width: _getSize.width * 0.9,
        height: _getSize.height * 0.2,
        child: ListView.builder(
            itemCount: services.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, right: 8, left: 4),
                child: Container(
                  height: _getSize.height * 0.11,
                  width: _getSize.width,
                  decoration: BoxDecoration(
                      color: services[index]['color'],
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(44, 85, 80, 80),
                          blurRadius: 11,
                          spreadRadius: 1,
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Image.asset(
                                  services[index]['img'],
                               
                                  width: _getSize.width*0.15,
                                ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  services[index]['text'],
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.text,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.42,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rate,
                                      size: 18,
                                      color: Color.fromARGB(255, 255, 203, 17),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "4/5",
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.fade,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),  SizedBox(
                              height: _getSize.height * 0.007,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  services[index]['icon'],
                                  color: services[index]['color2'],
                                  width: 24,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  services[index]['job'],
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.text,
                                      fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.005,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.6,
                              child: Text(
                                services[index]['desc'],
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.text,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

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
        indicatorColor: Pallete.primaryColor,
        indicatorSize: TabBarIndicatorSize.label, 
        labelColor: Pallete.text,
        labelStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
        unselectedLabelColor: Pallete.fade,
        
        indicatorWeight: 1, 
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
            fontSize: count == 5 ? 9 : 16,
          ),
        ),
      ),
    );
  }
}
