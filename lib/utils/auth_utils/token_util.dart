import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../../provider/property_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class UserUtil {
  validateToken(
    BuildContext context,
  ) async {
    // print(loginData);
    //var token2 = await showToken();
    //var id2 = await showId();

    var token = await showToken();
    try {
      DateTime expirationDate = JwtDecoder.getExpirationDate(token);
      DateTime currentDate = DateTime.now();

      // Check if the token is already expired
      if (currentDate.isAfter(expirationDate)) {
        await saveToken("");
        await saveOnce(2);
        AppUtils.showSnackBarMessage(
            "Session Expired, Login to continue", context);
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.loginScreen,
          (route) => false,
        );
      }

      // Check if the token will expire within the next 5 minutes
      Duration timeUntilExpiration = expirationDate.difference(currentDate);
      if (timeUntilExpiration.inMinutes <= 5) {
        await saveToken("");
        await saveOnce(2);

        AppUtils.showSnackBarMessage(
            "Session Expired, Login to continue", context);

        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.loginScreen,
          (route) => false,
        );
      }
    } catch (e) {
      // If there's an error decoding the token, consider it invalid
      print('Error decoding token: $e');
      await saveOnce(2);
      await saveToken("");
      AppUtils.showSnackBarMessage(
          "Session Expired, Login to continue", context);
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.loginScreen,
        (route) => false,
      );
    }
  }
}
