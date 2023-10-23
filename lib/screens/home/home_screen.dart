import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:landlord/constants/app_images.dart';
import '../../config/config_api.dart';
import '../../constants/app_pages.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../mixins/helper_mixin.dart';

import 'package:get/get.dart';

import '../../services/oauth_client_service.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: double.infinity,
//         title: const Text(
//           'Home',
//           style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28),
//         ),
//       ),
//       body: controller.obx(
//         (state) => Center(
//           child: Container(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('This is the home page'),
//               Text(getSessionTime()),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.find<AuthController>().signOut();
//                   Get.offAllNamed(Routes.LOGIN);
//                 },
//                 child: Text("Signout", style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           )),
//         ),

//         // here you can put your custom loading indicator, but
//         // by default would be Center(child:CircularProgressIndicator())
//         onLoading: CircularProgressIndicator(),
//         onEmpty: Column(
//           children: [
//             const Text('No Data found'),
//             ElevatedButton(
//                 onPressed: () {
//                   Get.find<AuthController>().signOut();
//                   Get.offAllNamed(Routes.LOGIN);
//                 },
//                 child: const Text("Signout",
//                     style: TextStyle(color: Colors.white))),
//           ],
//         ),

//         // here also you can set your own error widget, but by
//         // default will be an Center(child:Text(error))
//         onError: (error) => Text(''),
//       ),
//     );
//   }
//}
  @override
  Widget build(BuildContext context) {
    final screenHeightWidth = MediaQuery.of(context).size;
    final topOffset = screenHeightWidth.height * 0.010;

    double logoWidth = screenHeightWidth.width ;
    double logoHeight = screenHeightWidth.height * 0.30;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: topOffset,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 2), // Adjust the duration as needed
                width: logoWidth,
                height: logoHeight,
                child: Image.asset(
                     width: 30,
                height: 30,
                  AppImages.logo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
