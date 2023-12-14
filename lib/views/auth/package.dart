import 'dart:ffi';

import 'package:abjalandlord/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';

class Package extends StatefulWidget {
  const Package({Key? key}) : super(key: key);

  @override
  _PackageState createState() => _PackageState();
}

class _PackageState extends State<Package> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(AppImages.place),
                  Positioned(
                      left: _getSize.width * 0.05,
                      bottom: _getSize.height * 0.15,
                      child: Image.asset(AppImages.back,width: 36,)),
                ],
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get access to all resources",
                    style: AppFonts.body1.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Pallete.primaryColor),
                  ),
                  Text(
                    "and features",
                    style: AppFonts.body1.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Pallete.primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    props(
                      type: "16 Property Listing with 30 Units.",
                      check: isChecked,
                      onch: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    props(
                      type: "Tenant Screening",
                      check: isChecked,
                      onch: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    props(
                      type: "7 Property Rent Collection",
                      check: isChecked,
                      onch: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    props(
                      type: "Maintenance Requests",
                      check: isChecked,
                      onch: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    props(
                      type: "Communication with reports",
                      check: isChecked,
                      onch: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            plan(
                              bxsize: _getSize.width * 0.25,
                              type: "Free",
                              period: "30 days",
                              color: Pallete.whiteColor,
                              bColor: const Color(0xFF949494),
                              size: _getSize.height * 0.002,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.05,
                            ),
                            plan(
                              bxsize: _getSize.width * 0.25,
                              type: "\$20",
                              period: "12 months",
                              color: Pallete.whiteColor,
                              bColor: const Color(0xFF949494),
                              size: _getSize.height * 0.002,
                            )
                          ],
                        ),
                        SizedBox(
                          height: _getSize.height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            plan(
                              bxsize: _getSize.width * 0.25,
                              type: "\$55",
                              period: "12 months",
                              color: Pallete.whiteColor,
                              bColor: const Color(0xFF949494),
                              size: _getSize.height * 0.002,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.05,
                            ),
                            plan(
                              bxsize: _getSize.width * 0.25,
                              type: "\$100",
                              period: "12 months",
                              color: Color.fromARGB(255, 196, 231, 191),
                              bColor: Pallete.primaryColor,
                              size: _getSize.height * 0.002,
                              textColor: Pallete.primaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.02,
                    ),
                    ButtonWithFuction(
                        text: 'Go Platinum',
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.navbar);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class plan extends StatelessWidget {
  const plan(
      {super.key,
      required this.type,
      required this.period,
      required this.color,
      required this.bColor,
      required this.size,
      this.textColor,
      this.textColor2,
      required this.bxsize});
  final String type;
  final String period;
  final Color color;
  final double size;
  final Color bColor;
  final Color? textColor;
  final Color? textColor2;
  final double bxsize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: bxsize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
          border: Border.all(color: bColor, width: 0.7)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          children: [
            Text(
              type,
              style: AppFonts.body1.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Pallete.fade),
            ),
            SizedBox(
              height: size,
            ),
            Text(
              period,
              style: AppFonts.body1.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: textColor2 ?? Pallete.fade),
            )
          ],
        ),
      ),
    );
  }
}

class props extends StatelessWidget {
  const props(
      {super.key, required this.type, required this.check, required this.onch});
  final String type;
  final bool check;
  final Function(bool?) onch;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              activeColor: Pallete.primaryColor, value: check, onChanged: onch),
          Text(
            type,
            style: AppFonts.body1.copyWith(
                color: Pallete.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
