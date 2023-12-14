import 'package:abjalandlord/views/tenant/widget.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';


class Tenants extends StatefulWidget {
  const Tenants({ Key? key }) : super(key: key);

  @override
  _TenantsState createState() => _TenantsState();
}

class _TenantsState extends State<Tenants> {
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
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
                    const Text("Tenants"),
                    const Text("")
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              SizedBox(
                height: _getSize.height * 0.9,
                child: DefaultTabController(
                  length: 6,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        height: _getSize.height * 0.03,
                        buttonMargin: EdgeInsets.symmetric(
                            horizontal: _getSize.height * 0.025),
                        borderWidth: 0.5,
                        borderColor: Pallete.primaryColor,
                        backgroundColor: Pallete.primaryColor,
                        unselectedBackgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        unselectedLabelStyle:
                            const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "All",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Payments",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Rent",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Service Task",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                             Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Property",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                             Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Tenant Request",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                     
                            TenantsContent(getSize: _getSize),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
