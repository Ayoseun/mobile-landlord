
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/buttons.dart';
import '../../../components/input_field.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';

import '../../../utils/auth_utils/change_password_util.dart';
import '../../../utils/validator.dart';
import '../login/validation_text_row.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool obsecure = true;
  bool enabled = false;
  bool isLetterAdded = false;
  bool isNumAdded = false;
  bool isAboveEight = false;

  final Map<String, dynamic> _resetPasswordData = {
    'password': '',
  };

  void _checkPasswordStrength(String value) {
    dynamic password = value.trim();
    setState(() {
      if (Validators.numReg.hasMatch(password)) {
        // Password has number
        isNumAdded = true;
      } else {
        isNumAdded = false;
      }
       if (Validators.lettersmallReg.hasMatch(password) &&Validators.letterReg.hasMatch(password) ) {
        // Password has number
        isLetterAdded = true;
      } else {
        isLetterAdded = false;
      }
      if (password.length > 8) {
        // Password is more than 8
        isAboveEight = true;
      } else {
        isAboveEight = false;
      }
      if (isLetterAdded&& isNumAdded && isAboveEight) {
        enabled = true;
      } else {
        enabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));
    final size = MediaQuery.of(context).size;
    final token = ModalRoute.of(context)!.settings.arguments as int;
  
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Pallete.black),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.06,
                ),
                Text(
                  // 'Wobia, let’s create a new \npassword',
                  'Let’s create a new \npassword',
                  style: AppFonts.coloredHeading,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Try not to misplace it this time.😉',
                  style: AppFonts.body1,
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                Form(
                  child: Column(
                    children: [
                      CustomInput(
                        obsecure: obsecure,
                        hint: 'Enter password',
                        onChanged: (value) {
                          _checkPasswordStrength(value!);
                          if (enabled) {
                            _resetPasswordData['password'] = value;
                          }
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obsecure = !obsecure;
                            });
                          },
                          child: Image.asset(
                            obsecure ? AppImages.eyesOn : AppImages.eyesOff,
                            scale: 4,
                          ),
                        ),
                        onSaved: (value) {},
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                  ValidationTextRow(
                  text: 'Add a Capital Letter',
                  passed: isLetterAdded,
                ),
                ValidationTextRow(
                  text: 'Add a number',
                  passed: isNumAdded,
                ),
                ValidationTextRow(
                  text: 'Contain more than 8 characters',
                  passed: isAboveEight,
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                CustomButton(
                  text: 'Next',
                  enabled: enabled,
                  onpressed: enabled
                      ? () =>
                    
                         ResetPasswordUtil .resetPassword(context, _resetPasswordData):
                       () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

