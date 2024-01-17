import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';

import '../../../../components/buttons.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_routes.dart';
import 'main_page.dart';

class FullPropertyContent extends StatelessWidget {
  const FullPropertyContent({
    super.key,
    required Size getSize,
    required this.property,
    required this.unitCount,
    required this.propertyUnits,
    required this.service,
  }) : _getSize = getSize;

  final Size _getSize;
  final Map property;
  final int unitCount;

  final List propertyUnits;
  final List<Map> service;
  int getTenantCount(List<dynamic> unitData) {
    int tenantCount = 0;

    for (var unit in unitData) {
      if (unit.containsKey('tenantInfo')) {
        tenantCount++;
      }
    }

    return tenantCount;
  }

  List<String> getSelfieUrls(List<dynamic> unitData) {
    List<String> selfieUrls = [];

    for (var unit in unitData) {
      if (unit.containsKey('tenantInfo') &&
          unit['tenantInfo'].containsKey('selfie')) {
        selfieUrls.add(unit['tenantInfo']['selfie']);
      }
    }

    return selfieUrls;
  }

  @override
  Widget build(BuildContext context) {
    int tenantCount = getTenantCount(property['unitData']);
    // print('Total tenants: $tenantCount');
    List<String> selfieUrls = getSelfieUrls(property['unitData']);
    return Column(
      children: [
        SizedBox(
          height: _getSize.height * 0.03,
        ),
        SizedBox(
          height: _getSize.height * 0.56,
          child: 
          
          SingleChildScrollView(
            child: 
            Column(
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
                            SizedBox(
                              width: _getSize.width * 0.55,
                              child: Text(
                                property['location'],
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade,
                                    fontSize: _getSize.height * 0.016),
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            var tenantInfo = {
                              "propertyID": property['propertyID'],
                              "unitID": property['propertyID']
                            };

                            property['structure'] != "Standalone"
                                ? Navigator.of(context).pushNamed(
                                    AppRoutes.addMoreUnit,
                                    arguments: {
                                      'data': property,
                                    },
                                  )
                                : Navigator.of(context).pushNamed(
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
                                property['structure'] != "Standalone"
                                    ? "Add More Unit"
                                    : "Add Tenant",
                                style: AppFonts.smallWhiteBold
                                    .copyWith(color: Pallete.primaryColor),
                              ),
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
                          property['structure'] != "Standalone"
                              ? "Tenants"
                              : "Tenant",
                          style: AppFonts.boldText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Pallete.text,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: _getSize.height * 0.005,
                        ),
                        selfieUrls.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ImageStack(
                                    imageList: selfieUrls,
                                    backgroundColor:
                                        Color.fromARGB(49, 209, 209, 209),
                                    extraCountTextStyle: AppFonts.body1
                                        .copyWith(
                                            color: Pallete.primaryColor,
                                            fontWeight: FontWeight.w600),
                                    totalCount:
                                        tenantCount, // If larger than images.length, will show extra empty circle
                                    imageRadius: 45, // Radius of each images
                                    imageCount: tenantCount > 3
                                        ? 3
                                        : tenantCount, // Maximum number of images to be shown in stack
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
                              )
                            : Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFC8DCC5),
                                        borderRadius:
                                            BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Tenant has been added",
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.primaryColor),
                                      ),
                                    ))),
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
                              "Total Service Requests",
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
                            child: service.isEmpty
                                ? ListView.builder(
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
                                              style:
                                                  AppFonts.bodyText.copyWith(
                                                fontSize: 12,
                                                color: Pallete.text,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFC8DCC5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "No Repair has been done",
                                            style: AppFonts.body1.copyWith(
                                                color: Pallete.primaryColor),
                                          ),
                                        ))))
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
                            child: service.isEmpty
                                ? ListView.builder(
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
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: service[index]
                                                          ['text'],
                                                      style: const TextStyle(
                                                        color: Colors
                                                            .black, // Replace with Pallete.black if defined
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: ' - ',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey, // Replace with Pallete.fade if defined
                                                        fontSize: 10,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' ${service[index]['text2']}',
                                                      style: const TextStyle(
                                                        color: Pallete
                                                            .text, // Replace with Pallete.fade if defined
                                                        fontSize: 11,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                    })
                                : Center(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFC8DCC5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "No Request has been made",
                                            style: AppFonts.body1.copyWith(
                                                color: Pallete.primaryColor),
                                          ),
                                        ))))
                      ],
                    )
                  ],
                ),        SizedBox(
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
              SizedBox(
                height: _getSize.height * 0.045,
              ),
            ],
          ),
        ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
