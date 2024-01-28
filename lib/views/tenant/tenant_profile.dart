import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_stack/image_stack.dart';
import 'package:image_picker/image_picker.dart' as imgpika;
import '../../components/buttons.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../utils/local_storage.dart';

class TenantProfile extends StatefulWidget {
  const TenantProfile({Key? key}) : super(key: key);

  @override
  _TenantProfileState createState() => _TenantProfileState();
}

class _TenantProfileState extends State<TenantProfile> {

  var tenant = {};
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    tenant = dataFromRoute["tenant"];
    print(tenant);
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    Text("Tenant Profile"),
                    Text("")
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: _getSize.width * 0.35,
                    height: _getSize.height * 0.0007,
                    color: Pallete.primaryColor,
                  ),
                  DottedBorder(
                    borderType: BorderType.Circle,
                    strokeWidth: 2,
                    color: Color(0xFF47893F),
                    dashPattern: [10, 16],
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipOval(
                        child: Image.network(
                          tenant['selfie'],
                          fit: BoxFit.cover,
                          width: _getSize.width * 0.22,
                          height: _getSize.height * 0.10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: _getSize.width * 0.35,
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
                    "${tenant["name"]} ${tenant["surname"]}",
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
                        tenant["propertyLocation"],
                        style: AppFonts.body1.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    tenant["propertyName"],
                    style: AppFonts.body1.copyWith(
                        color: Pallete.text,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: _getSize.height * 0.01,
              ),
              Container(
                width: _getSize.width,
                height: _getSize.height * 0.0015,
                color: Color(0xFF47893F),
              ),
              SizedBox(
                height: _getSize.height * 0.027,
              ),
              middle(
                getSize: _getSize,
                tenantData: tenant,
              ),
              SizedBox(
                height: _getSize.height * 0.027,
              ),
              ProfileData(
                getSize: _getSize,
                header: "Email Address",
                content: tenant['email'],
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              ProfileData(
                getSize: _getSize,
                header: "Phone Number",
                content: tenant['phone'],
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              ProfileData(
                getSize: _getSize,
                header: "Job",
                content: "accountant",
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              ProfileData(
                getSize: _getSize,
                header: "Move-In-Date",
                content: tenant['startDate'],
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              ProfileData(
                getSize: _getSize,
                header: "Light Meter",
                content: tenant['lightMeter']??"",
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              ProfileData(
                getSize: _getSize,
                header: "Water Meter",
                content: tenant['waterMeter']??"",
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              ProfileData(
                getSize: _getSize,
                header: "Document",
                content: "Id card",
              ),
              SizedBox(
                height: _getSize.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData({
    super.key,
    required Size getSize,
    required this.header,
    required this.content,
  }) : _getSize = getSize;

  final Size _getSize;
  final String header;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header,
            style: AppFonts.boldText.copyWith(
                fontSize: _getSize.height * 0.015, color: Pallete.fade)),
        SizedBox(
          height: _getSize.height * 0.005,
        ),
        Text(content,
            style: AppFonts.boldText.copyWith(
                fontSize: _getSize.height * 0.016, color: Pallete.text)),
        Container(
          width: _getSize.width * 0.9,
          height: _getSize.height * 0.0007,
          color: Pallete.primaryColor,
        ),
      ],
    );
  }
}

class middle extends StatelessWidget {
  const middle({
    super.key,
    required this.tenantData,
    required Size getSize,
  }) : _getSize = getSize;

  final Size _getSize;
  final tenantData;

  @override
  Widget build(BuildContext context) {
    var week2mnth = tenantData['remainingWeeks']??0 / 4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: _getSize.height * 0.09,
          width: _getSize.width * 0.3,
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
                    Column(
                      children: [
                        Text(week2mnth.toString(),
                            style: AppFonts.boldText.copyWith(
                              fontSize: _getSize.height * 0.02,
                              color: Color(0xFF1D5A67),
                            )),
                        Text("Months",
                            style: AppFonts.boldText.copyWith(
                              fontSize: _getSize.height * 0.008,
                              color: Color(0xFF1D5A67),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Image.asset(
                      AppImages.estate,
                      height: _getSize.height * 0.02,
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
                      "Active",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFF1D5A67),
                          fontSize: _getSize.height * 0.018,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rent",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFF1D5A67,
                          ),
                          fontSize: _getSize.height * 0.018,
                          fontWeight: FontWeight.bold),
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
          height: _getSize.height * 0.09,
          width: _getSize.width * 0.3,
          decoration: BoxDecoration(
              color: Color(0xFFFDE7CD),
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
                        style: AppFonts.boldText.copyWith(
                            fontSize: _getSize.height * 0.02,
                            color: Color(0xFFF58807))),
                    Image.asset(
                      AppImages.request,
                      width: 18,
                      color: Color(0xFFF58807),
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
                      "Service",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFFF58807),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Request",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFFF58807,
                          ),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
