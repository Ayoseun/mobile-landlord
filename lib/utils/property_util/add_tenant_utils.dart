import 'dart:io';
import 'package:abjalandlord/models/dashItem.dart';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../../views/dashboard/dashboard.dart';
import '../../views/navbar/nav.dart';
import '../../views/property/property.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class AddTenantUtil {
  static Future<String> add(
      BuildContext context, Map<String, dynamic> tenantData) async {
    var result;

    AppUtils.showLoader(context);
    Provider.of<PropertyProvider>(context, listen: false)
        .addTenantToUnit(tenantData)
        .then((value) async {
      Navigator.of(context).pop();

      if (value['statusCode'] == 200) {
        AppUtils.SuccessDialog(
            context,
            "Successful",
            "New Tenant; ${tenantData['name']} ${tenantData['surname']} has been added successfully. ",
            Image.asset(
              AppImages.success,
              width: 48,
            ),
            "Close",
            AppRoutes.propDetails,
            routeData: value['data']['propertyID']);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NavBar(initialScreen: const Dashboard(), initialTab: 0)),
          (route) => false,
        );
      } else {
        AppUtils.showAlertDialog(
            context,
            'Oops, something isn\'t right!',
            value['error'].toString(),
            'Close',
            'Try again',
            () => Navigator.of(context).pop());
      }
    });

    return result;
  }
}
