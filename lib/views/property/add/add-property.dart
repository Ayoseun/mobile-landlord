import 'package:abjalandlord/components/buttons.dart';
import 'package:abjalandlord/components/input_field.dart';
import 'package:abjalandlord/constants/app_colors.dart';
import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/constants/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_images.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
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
                    Text("Add Property"),
                    Text("")
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                CustomInput3(
                  onSaved: (onsaved) {},
                  label: "Property Information",
                  hint: "Property Information",
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                NewWidget(
                  getSize: _getSize,
                  label: "Name",
                  hint: "Property Name",
                  label2: "Location",
                  hint2: "Property Location",
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                NewWidget(
                  getSize: _getSize,
                  label: "Type",
                  hint: "Property Type",
                  label2: "Structure",
                  hint2: "Property Structure",
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                NewWidget(
                  getSize: _getSize,
                  label: "Category",
                  hint: "Property category",
                  label2: "Unit",
                  hint2: "Number of units",
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                CustomInput3(
                  onSaved: (onsaved) {},
                  label: "Property Description",
                  hint: "Description",
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
                          type: "Football",
                          img: AppImages.football,
                          check: false,
                          onch: (bool? value) {
                            setState(() {});
                          },
                        ),
                        props(
                          type: "Pool",
                          img: AppImages.swim,
                          check: false,
                          onch: (bool? value) {
                            setState(() {});
                          },
                        ),
                        props(
                          type: "Wifi",
                          img: AppImages.wifi,
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
                    Row(
                      children: [
                        props(
                          type: "Laundry",
                          img: AppImages.laundry,
                          check: false,
                          onch: (bool? value) {
                            setState(() {});
                          },
                        ),
                        props(
                          type: "Garden",
                          img: AppImages.flower,
                          check: false,
                          onch: (bool? value) {
                            setState(() {});
                          },
                        ),
                        props(
                          type: "Fitness",
                          img: AppImages.weightlifting,
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
                    Row(
                      children: [
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
                      height: _getSize.height * 0.02,
                    ),
                  ],
                ),
                DottedBorder(
                  color: Pallete.text,
                  strokeWidth: 0.8,
                  dashPattern: [6, 3, 3],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(5),
                  padding: EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      height: _getSize.height * 0.05,
                      width: _getSize.width * 0.6,
                      color: Color.fromARGB(226, 171, 213, 163),
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
                SizedBox(
                  height: _getSize.height * 0.12,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                           Navigator.of(context).pushNamed(AppRoutes.addUnit);
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
                      Container(
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
            onSaved: (onsaved) {
             
            },
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
