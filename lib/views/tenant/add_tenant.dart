import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/utils/property_util/add_tenant_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../../components/input_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import 'package:image_picker/image_picker.dart' as imgpika;

import '../../network/property.dart';
import '../../utils/app_utils.dart';

class AddTenant extends StatefulWidget {
  const AddTenant({Key? key}) : super(key: key);

  @override
  _AddTenantState createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  TextEditingController datePickerController = TextEditingController();

  final _tenantFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> _tenantData = {
    "email": '',
    "phone": "",
    "name": "",
    "docPhoto": "",
    "propertyID": "",
    "unitID": "",
    "startDate": "",
    "endDate": "",
    "surname": ""
  };
  bool isFetchingImage = false;
  Map<String, dynamic> tenantData = {};
  String photo = '';
  imgpika.XFile? image; //this is the state variable
  upload(selfie) async {
    isFetchingImage = true;
    var res = await PropertyAPI.uploadImage(selfie);

    print(res);

    setState(() {
      photo = res['data']['selfie'];
      isFetchingImage = false;
      _tenantData['docPhoto'] = photo;
    });
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 180)); // 6 months later
bool haveSelectedStartDate=false;
  Future<void> _selectStartDate(BuildContext context) async {


    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        endDate = picked.add(Duration(days: 180));

        // Update end date to be at least 6 months later
haveSelectedStartDate=true;
        
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
        if(!haveSelectedStartDate){
   AppUtils.singleDialog(
                          context,
                          'Error',
                          'Select start date first',
                          'close',
                          const Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 205, 5, 5),
                            size: 30,
                          ),
                          const Text(""),
                          () => Navigator.of(context).pop());
    }else{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.isBefore(startDate.add(Duration(days: 180)))
          ? startDate.add(Duration(days: 180))
          : endDate,
      firstDate: startDate.add(Duration(days: 180)),
      lastDate: DateTime(2101),
    );

   if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;

          _tenantData['propertyID'] = tenantData['propertyID'];
                      _tenantData['unitID'] = tenantData['unitID'];
                      _tenantData['startDate'] = formatDate(startDate);
                       _tenantData['endDate'] = formatDate(endDate);
        
      });
    }
    }

  }

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    tenantData = dataFromRoute["tenant"];
    print(tenantData);
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
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
                  Text("Add New Tenant"),
                  Text("")
                ],
              ),
            ),
            SizedBox(
              height: _getSize.height * 0.02,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _tenantFormKey,
                    child: Column(
                      children: [
                        CustomInput3(
                          onSaved: (v) {},
                          onChanged: (v) {
                            _tenantData['name'] = v;
                          },
                          label: "First Name",
                          hint: "First Name",
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                        CustomInput3(
                          onSaved: (v) {},
                          onChanged: (v) {
                            _tenantData['surname'] = v;
                          },
                          label: "Last Name",
                          hint: "last Name",
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                        CustomInput3(
                          onSaved: (v) {},
                          onChanged: (v) {
                            _tenantData['email'] = v;
                          },
                          label: "Email address",
                          hint: "Email",
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                        CustomInput3(
                          onSaved: (v) {},
                          onChanged: (v) {
                            _tenantData['phone'] = v;
                          },
                          label: "Phone Number",
                          hint: "Phone",
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Move-in Date',
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 35),
                                suffixIcon: Image.asset(
                                  "assets/icons/calenda.png",
                                  height: _getSize.height * 0.02,
                                ),
                              ),
                              readOnly: true,
                              onTap: () => _selectStartDate(context),
                              controller: TextEditingController(
                                  text: "${startDate.toLocal()}".split(' ')[0]),
                            ),
                            SizedBox(
                                height: 20), // Spacing between input fields
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Due Date',
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 35),
                                suffixIcon: Image.asset(
                                  "assets/icons/calenda.png",
                                  height: _getSize.height * 0.02,
                                ),
                              ),
                              readOnly: true,
                              onTap: () => _selectEndDate(context),
                              controller: TextEditingController(
                                  text: "${endDate.toLocal()}".split(' ')[0]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                GestureDetector(
                  onTap: () async {
                    final imgpika.ImagePicker _picker = imgpika.ImagePicker();
                    final img = await _picker.pickImage(
                        source: imgpika.ImageSource.gallery);
                    if (img != null) {
                      File imageFile = File(img.path);
                      Uint8List imageBytes = await imageFile.readAsBytes();
                      String base64String = base64Encode(imageBytes);
                      setState(() {
                        print(base64String);
                        upload(base64String);
                      });
                    }
                  },
                  child: DottedBorder(
                    color: Pallete.text,
                    strokeWidth: 1,
                    dashPattern: [6, 6],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5),
                    padding: EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Container(
                        height: _getSize.height * 0.13,
                        width: _getSize.width * 0.6,
                        child: !isFetchingImage
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Image.asset(
                                    AppImages.dwn,
                                    width: 24,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Choose a file to upload",
                                    style: AppFonts.bodyText.copyWith(
                                        color: Pallete.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "JPEG, PNG, PDF and DOCS formats, up to 50MB.",
                                    style: AppFonts.bodyText
                                        .copyWith(fontSize: 10),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            color: Pallete.primaryColor,
                                            width: 0.5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Browse File",
                                        style: AppFonts.bodyText.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Pallete.text,
                                            fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SpinKitRing(
                                size: 30,
                                color: Pallete.primaryColor,
                                lineWidth: 2.0,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.10,
                ),
                GestureDetector(
                  onTap: () {
                    print(_tenantData);
                    if (_tenantData['name'] == "" ||
                        _tenantData['surname'] == "" ||
                        _tenantData['email'] == "" ||
                        _tenantData['phone'] == "" ||
                        _tenantData['docphoto'] == "" ||
                        _tenantData['startDate'] == "" ||
                        _tenantData["endDate"] == "") {
                      AppUtils.singleDialog(
                          context,
                          'Error',
                          'You must provide all property information.',
                          'close',
                          const Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 205, 5, 5),
                            size: 30,
                          ),
                          Text(""),
                          () => Navigator.of(context).pop());
                    } else {
                    
                      print(_tenantData);
                       AddTenantUtil.add(context, _tenantData);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Pallete.primaryColor,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            color: Pallete.primaryColor, width: 0.5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: _getSize.width * 0.15),
                      child: Text(
                        "Save Changes",
                        style: AppFonts.bodyText.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Pallete.whiteColor,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.10,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
  // Create a new method to format the date
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('d MMMM yyyy');
    return formatter.format(date);
  }