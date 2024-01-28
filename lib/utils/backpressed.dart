import 'package:abjalandlord/constants/app_routes.dart';
import 'package:flutter/material.dart';

import '../views/dashboard/dashboard.dart';
import '../views/navbar/nav.dart';

Future<bool> onBackPressed(BuildContext context) async {
  // Your logic to handle the back button press
  // Return true to allow the pop, and false to prevent it
  // For example:
  await  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NavBar(initialScreen: Dashboard(),initialTab: 0)),
                                    (route) => false,
                                  );
  return true;
}
