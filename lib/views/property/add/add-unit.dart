import 'package:abjalandlord/components/buttons.dart';
import 'package:abjalandlord/components/input_field.dart';
import 'package:abjalandlord/constants/app_colors.dart';
import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_images.dart';

class AddUnit extends StatefulWidget {
  const AddUnit({Key? key}) : super(key: key);

  @override
  _AddUnitState createState() => _AddUnitState();
}

class _AddUnitState extends State<AddUnit> {
  int moreUnit = 1;
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: _getSize.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              children: [
                Row(
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
                    Text("Add Unit"),
                    Text("")
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                SizedBox(
                  width: _getSize.width,
                  height: _getSize.height * 0.7,
                  child: ListView.builder(
                      itemCount: moreUnit,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: Column(children: [
                            CustomInput3(
                              onSaved: (onsaved) {},
                              label: "Unit Information",
                              hint: "Unit Information",
                            ),
                            SizedBox(
                              height: _getSize.height * 0.03,
                            ),
                            NewWidget(
                              getSize: _getSize,
                              label: "Unit Space",
                              hint: "Unit Space",
                              label2: "ID Number",
                              hint2: "ID Number",
                            ),
                            SizedBox(
                              height: _getSize.height * 0.03,
                            ),
                            NewWidget(
                              getSize: _getSize,
                              label: "Bathrooms",
                              hint: "Bathrooms",
                              label2: "Toilet",
                              hint2: "Toilet",
                            ),
                            SizedBox(
                              height: _getSize.height * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    "Features",
                                    style: AppFonts.body1.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Pallete.text),
                                  ),
                                ),
                                Row(
                                  children: [
                                    props(
                                      type: "Wifi",
                                      img: AppImages.wifi,
                                      check: false,
                                      onch: (bool? value) {
                                        setState(() {});
                                      },
                                    ),
                                    props(
                                      type: "Power",
                                      img: AppImages.power,
                                      check: false,
                                      onch: (bool? value) {
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.005,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  width: _getSize.width * 0.25,
                                  color: Pallete.primaryColor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Cost for rent",
                                  style: AppFonts.body1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Pallete.primaryColor),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 1,
                                  width: _getSize.width * 0.25,
                                  color: Pallete.primaryColor,
                                )
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.02,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Monthly Cost",
                                          style: AppFonts.bodyText.copyWith(
                                              fontSize: 12,
                                              color: Pallete.text,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "*",
                                          style: AppFonts.bodyText.copyWith(
                                              color: Color.fromARGB(
                                                  255, 208, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5, color: Pallete.fade),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Color(0xFFDAE7D9)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 1),
                                        child: Center(
                                            child: Text(
                                          "\$/yr",
                                          style: AppFonts.bodyText.copyWith(
                                              fontSize: 12,
                                              color: Pallete.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Extra Wages",
                                          style: AppFonts.bodyText.copyWith(
                                              fontSize: 12,
                                              color: Pallete.text,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "*",
                                          style: AppFonts.bodyText.copyWith(
                                              color: Color.fromARGB(
                                                  255, 208, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 84,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5, color: Pallete.fade),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Color(0xFFDAE7D9)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 1),
                                        child: Center(
                                            child: Text(
                                          "\$/yr",
                                          style: AppFonts.bodyText.copyWith(
                                              fontSize: 12,
                                              color: Pallete.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Tax",
                                          style: AppFonts.bodyText.copyWith(
                                              fontSize: 12,
                                              color: Pallete.text,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "*",
                                          style: AppFonts.bodyText.copyWith(
                                              color: Color.fromARGB(
                                                  255, 208, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 84,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5, color: Pallete.fade),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Color(0xFFDAE7D9)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 1),
                                        child: Center(
                                            child: Text(
                                          "\$/yr",
                                          style: AppFonts.bodyText.copyWith(
                                              fontSize: 12,
                                              color: Pallete.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.05,
                            ),
                            DottedBorder(
                              color: Pallete.text,
                              strokeWidth: 0.8,
                              dashPattern: [6, 3, 3],
                              borderType: BorderType.RRect,
                              radius: Radius.circular(5),
                              padding: EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: Container(
                                  height: _getSize.height * 0.05,
                                  width: _getSize.width * 0.6,
                                  color: Color(0xFFDAE7D9),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Pallete.primaryColor,
                                      ),
                                      Text("Upload Property Image")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        );
                      }),
                ),
                SizedBox(
                  height: _getSize.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            moreUnit++;
                          });
                        },
                        child: Container(
                          width: _getSize.width * 0.4,
                          height: _getSize.height * 0.045,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Pallete.primaryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text("Add Unit"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                       
                          AppUtils.showLoader(context);

                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.pop(context);
                              AppUtils.SuccessDialog(
                              context,
                              "Successful",
                              "Your Property and Units have been successfully added.",
                              Image.asset(AppImages.success,width: 48,),
                              "View Property");    });
                        },
                        child: Container(
                          width: _getSize.width * 0.4,
                          height: _getSize.height * 0.045,
                          decoration: BoxDecoration(
                              color: Pallete.primaryColor,
                              border: Border.all(
                                  width: 0.5, color: Pallete.primaryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: AppFonts.smallWhiteBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class NewWidget extends StatelessWidget {
  NewWidget(
      {super.key,
      required Size getSize,
      required this.label,
      required this.hint,
      required this.hint2,
      required this.label2})
      : _getSize = getSize;

  final Size _getSize;
  final String label;
  final String label2;
  final String hint;
  final String hint2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: _getSize.width * 0.45,
          child: CustomInput3(
            onSaved: (onsaved) {},
            label: label,
            hint: hint,
          ),
        ),
        SizedBox(
          width: _getSize.width * 0.45,
          child: CustomInput3(
            onSaved: (onsaved) {},
            label: label2,
            hint: hint2,
          ),
        )
      ],
    );
  }
}

class props extends StatelessWidget {
  const props(
      {super.key,
      required this.type,
      required this.img,
      required this.check,
      required this.onch});
  final String type;
  final String img;
  final bool check;
  final Function(bool?) onch;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              activeColor: Pallete.primaryColor, value: check, onChanged: onch),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  width: 0.5,
                  color: Pallete.fade,
                )),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                img,
                width: 20,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            type,
            style: AppFonts.body1.copyWith(
              color: Pallete.text,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
