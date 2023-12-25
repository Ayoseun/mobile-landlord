import 'dart:io';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class DeletePropertyUtil {
  static Future<String> delete(
      BuildContext context,  propertyData) async {


    var result;

    AppUtils.showLoader(context);
    Provider.of<PropertyProvider>(context, listen: false)
        .createProperty(propertyData)
        .then((value) async {
      Navigator.of(context).pop();

      if (value['statusCode'] == 200) {
        AppUtils.SuccessDialog(
            context,
            "Successful",
            "Your Property and Units have been successfully added.",
            Image.asset(
              AppImages.success,
              width: 48,
            ),
            "View Property",
            AppRoutes.propDetails);
      } else {
        if (value['statusCode'] == 404) {
          AppUtils.showAlertDialog(
              context,
              'Oops, something isn\'t right!',
              value['error'],
              'Sign Up',
              'Try again',
              () => Navigator.of(context).pushNamed(AppRoutes.registerScreen));
        }
        if (value['statusCode'] == 403) {
          AppUtils.showAlertDialog(
              context,
              'Oops, something isn\'t right!',
              value['error'],
              'Enter OTP',
              'Close',
              () =>
                  Navigator.of(context).pushNamed(AppRoutes.registerOTPScreen));
        }

        if (value['statusCode'] == 302 && value['data']['status'] == false) {
          AppUtils.showAlertDialog(
              context,
              'Oops, something isn\'t right!',
              value['error'],
              'Contact Support',
              'Close',
              () => Navigator.of(context).pushNamed(AppRoutes.registerScreen));
        }
      }
    });

    return result;
  }
}
