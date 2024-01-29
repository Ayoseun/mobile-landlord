import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_routes.dart';

class UnitContent extends StatelessWidget {
  const UnitContent({
    super.key,
    required Size getSize,
    required this.property,
    required this.propertyUnits,
    required this.unitCount,
  }) : _getSize = getSize;

  final Size _getSize;
  final Map property;
  final List propertyUnits;
  final int unitCount;

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
                          !propertyUnits[unitCount]['isTaken']
                              ? GestureDetector(
                                  onTap: () {
                                    var tenantInfo = {
                                      "propertyID": property['propertyID'],
                                      "unitID": propertyUnits[unitCount]
                                          ['unitID']
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
                          ? GestureDetector(
                              onTap: () {
                                var tenantInfoData =
                                    propertyUnits[unitCount]['tenantInfo'];
                                tenantInfoData['lightMeter'] =
                                    propertyUnits[unitCount]['lightMeter'];
                                tenantInfoData['waterMeter'] =
                                    propertyUnits[unitCount]['waterMeter'];
                                tenantInfoData['propertyName'] =
                                    property['name'];
                                tenantInfoData['propertyLocation'] =
                                    property['location'];
                                print(propertyUnits[unitCount]);
                                Navigator.of(context).pushNamed(
                                  AppRoutes.tenantsProfile,
                                  arguments: {
                                    'tenant': tenantInfoData,
                                  },
                                );
                              },
                              child: Column(
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
                                          propertyUnits[unitCount]['tenantInfo']
                                              ['selfie'],
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
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  Text(
                                                    "20 June 2023",
                                                    style:
                                                        AppFonts.body1.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                                  .circular(
                                                                      100),
                                                          color: Color(
                                                              0xFF47893F)),
                                                    ),
                                                    SizedBox(
                                                      width: _getSize.width *
                                                          0.025,
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
                              ),
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
              SizedBox(
                height: _getSize.height * 0.015,
              ),
              ButtonWithFuction(
                  text: "Request Service Provider",
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.createRequest);
                  }),
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
