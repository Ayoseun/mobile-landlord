import 'package:abjalandlord/constants/app_routes.dart';
import 'package:flutter/material.dart';

Future<bool> onBackPressed(BuildContext context) async {
  // Your logic to handle the back button press
  // Return true to allow the pop, and false to prevent it
  // For example:
  await Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.navbar, (route) => false);
  return true;
}
