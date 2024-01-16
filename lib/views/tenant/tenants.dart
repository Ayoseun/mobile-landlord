import 'dart:convert';

import 'package:abjalandlord/utils/local_storage.dart';
import 'package:abjalandlord/views/tenant/widget.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../network/property.dart';

class Tenants extends StatefulWidget {
  const Tenants({Key? key}) : super(key: key);

  @override
  _TenantsState createState() => _TenantsState();
}

class _TenantsState extends State<Tenants> {
  bool isLoadingProperty = true;
  List property = [];
  List propertyName = [];

  getPropertyNameItems() async {
    isLoadingProperty = true;
    var propertyString = await showPropertyNameItem();
    var m = List<Map<String, dynamic>>.from(jsonDecode(propertyString));
    if (m.isEmpty) {
    } else {
      setState(() {
        propertyName = m;
        isLoadingProperty = false;
            getAllPropertiesTenants(
                              propertyName[0]['propertyID']);
      });
    }
  }

  bool isLoadingTenants = true;
  List tenants = [];
  getAllPropertiesTenants(propID) async {
    isLoadingTenants = true;
    await Future.delayed(Duration(seconds: 1));
    var res = await PropertyAPI.getPropertyTenants(propID);

    var gotTenants = res['data'];
    print(gotTenants);
    if (gotTenants.isNotEmpty) {
      setState(() {
        tenants = gotTenants;
        isLoadingTenants = false;
        
      });
    } else {
      setState(() {
        isLoadingTenants = false;
        tenants.length = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPropertyNameItems();
  }

  List<Tab> buildTabs() {
    return propertyName.asMap().entries.map((entry) {
      final index = entry.key;
      final tabName = entry.value;

      return Tab(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
          child: Text(
            tabName['name'],
            style: AppFonts.bodyText, // Replace with your desired text style
          ),
        ),
      );
    }).toList();
  }

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
                  length: propertyName.length,
                  child: Column(
                    children: [
                      ButtonsTabBar(
                        onTap: (p) {
                          isLoadingTenants =true;
                          setState(() {
                            
                          });
                          
                          getAllPropertiesTenants(
                              propertyName[p]['propertyID']);
                        },
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
                        tabs: buildTabs(),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: propertyName.map((tabName) {
                            return !isLoadingTenants
                                ? TenantsContent(
                                    getSize: _getSize,
                                    tenants: tenants,
                                    // Pass any additional data to TenantsContent if needed
                                  )
                                : Container(
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
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SpinKitRing(
                                            size: 30,
                                            color: Pallete.primaryColor,
                                            lineWidth: 2.0,
                                          ),
                                          Text(
                                            "Loading Tenants on this property",
                                            style: AppFonts.body1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          }).toList(),
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
