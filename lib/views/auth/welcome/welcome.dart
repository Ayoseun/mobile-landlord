import 'package:abjalandlord/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../components/buttons.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';
import '../../../utils/app_utils.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String name = '';
  String? phone;
 FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.light // dark text for status bar
        ));
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Pallete.onboardColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Image.asset(AppImages.banner),
                Positioned(
                  left: _getSize.width * 0.1,
                  bottom: _getSize.height * 0.18,
                  child: Text(
                    'Get Started',
                    style: AppFonts.bodyText.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Pallete.primaryColor,
                        fontSize: 20),
                  ),
                ),
              ]),
              Text(
                'What\'s your phone number?',
                style: AppFonts.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Pallete.primaryColor,
                    fontSize: 20),
              ),
              SizedBox(
                height: _getSize.height * 0.01,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
                child: Column(
                  children: [
                    IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Enter Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.2,color: Pallete.fade,style: BorderStyle.none),
                        ),
                      ),
                      initialCountryCode: 'UG',
                      focusNode: focusNode,
                      onChanged: (ph) {
                        print(ph.completeNumber);
                          phone = ph.completeNumber.trim().split(' ').join('');
                      },
                    ),
                    // CustomInput2(
                    //   label: ' Phone',
                    //   type: 'number',
                    //   hint: 'Enter Phone number?',
                    //   onChanged: (v) {
                    //     setState(() {
                    //       phone = v!;
                    //     });
                    //   },
                    //   onSaved: (value) {},
                    // ),
                    SizedBox(
                      height: _getSize.height * 0.02,
                    ),
                    ButtonWithFuction(
                        text: "Continue",
                        onPressed: () {
                          if (phone != null) {
                            print(phone);
                            Navigator.of(context).pushNamed(
                              AppRoutes.registerScreen,
                              arguments: {
                                'phone': phone,
                              },
                            );
                          } else {
                            AppUtils.showAlertDialog(
                                context,
                                'Oops, something isn\'t right!',
                                "Phone number is required here",
                                'View policy',
                                'Close',
                                () => Navigator.of(context).pop());
                          }
                        }),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              color: Pallete.fade,
                              width: _getSize.width * 0.37,
                              height: _getSize.height * 0.0005,
                            ),
                            const Text("  Or  "),
                            Container(
                              color: Pallete.fade,
                              width: _getSize.width * 0.37,
                              height: _getSize.height * 0.0005,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _getSize.height * 0.02,
                        ),
                        Text(
                          "Continue with",
                          style: AppFonts.body1.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Pallete.fade),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                AppImages.fb,
                                width: _getSize.width * 0.05,
                              ),
                              Image.asset(
                                AppImages.google,
                                width: _getSize.width * 0.05,
                              ),
                              Image.asset(
                                AppImages.apple,
                                width: _getSize.width * 0.05,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: _getSize.height * 0.02),
                        Row(
                          children: [
                            Container(
                              color: Pallete.fade,
                              width: _getSize.width * 0.37,
                              height: _getSize.height * 0.0005,
                            ),
                            const Text("  Or  "),
                            Container(
                              color: Pallete.fade,
                              width: _getSize.width * 0.37,
                              height: _getSize.height * 0.0005,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: _getSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.search,
                          width: _getSize.width * 0.05,
                        ),
                        SizedBox(
                          width: _getSize.width * 0.03,
                        ),
                        Text(
                          "Find my account",
                          style: AppFonts.body1.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Pallete.fade),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.05,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).pushNamed(AppRoutes.loginScreen)
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: AppFonts.bodyText.copyWith(
                              color: Pallete.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Sign in',
                            style: AppFonts.bodyText.copyWith(
                                fontWeight: FontWeight.w300,
                                color: Pallete.secondaryColor,
                                fontSize: 14),
                          ),
                           SizedBox(
                height: _getSize.height * 0.15,
              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
