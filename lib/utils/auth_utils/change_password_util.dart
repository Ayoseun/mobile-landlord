import 'dart:io';

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';

import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class ResetPasswordUtil {
  static Future<String> resetPassword(GlobalKey<FormState> formkey,
      BuildContext context, password, cpassword) async {
    var id = await showId();
    var result;
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      AppUtils.showLoader(context);
      var result;
      Provider.of<AuthProvider>(context, listen: false)
          .changePassword(id, password, cpassword)
          .then((value) async {
        Navigator.of(context).pop();
        print(value);
        if (value['statusCode'] != 200) {
          if (value["error"] == "Expired Bearer token") {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen, (route) => false);
          } else {
            AppUtils.ErrorDialog(
              context,
              'Error',
              value['error'],
              'Close',
              const Icon(
                Icons.error_rounded,
                color: Color.fromARGB(255, 213, 10, 10),
                size: 30,
              ),
            );
          }
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.loginScreen, (Route<dynamic> route) => false);
        }
      });
    }
    return result;
  }
}
