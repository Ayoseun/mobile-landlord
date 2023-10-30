import 'package:abjalandlord/views/auth/loading.dart';
import 'package:abjalandlord/views/auth/login/login.dart';
import 'package:abjalandlord/views/auth/package.dart';
import 'package:abjalandlord/views/auth/register/register.dart';
import 'package:abjalandlord/views/dashboard/dashboard.dart';
import 'package:abjalandlord/views/drawer_menu/sidebar.dart';
import 'package:flutter/widgets.dart';

import '../views/auth/forgotPassword/change_password.dart';
import '../views/auth/forgotPassword/forgotPassword.dart';
import '../views/auth/forgotPassword/otp.dart';
import '../views/auth/register/register_otp.dart';
import '../views/navbar/nav.dart';

class AppRoutes {
  static const dashboardScreen = '/dashboardScreen';
  static const storeScreen = '/storeScreen';
  static const welcomeScreen = '/welcomeScreen';
  static const chat = '/chatScreen';
  static const speakWithDoc = './speakWithDoc';
  static const profile = '/profile';
  static const editProfile = '/editProfile';
  static const about = './history';
  static const bookATest = './bookATest';
  static const randomSearch = '/randomSearchScreen';
  static const testScreen = '/testScreen';
  static const viewAllCart = '/viewAllCart';
  static const drugItemScreen = '/drugItem';
  static const webviewScreen = '/webview';
  static const checkOut = '/checkOut';
  static const seeAllCart = '/seeAllCart';
  static const refer = '/refer';
  static const loginScreen = '/loginScreen';
  static const forgotPassword = '/forgotPassword';
  static const selectTest = '/selectTest';
  static const ordersScreen = '/ordersScreen';
  static const drugOrdersScreen = '/drugOrdersScreen';
  static const diag = '/diag';
  static const package = '/package';
  static const navbar = '/navbar';
  static const loadHome = '/loadHome';
  static const privacy = '/privacy';
  static const terms = '/terms';
  static const registerOTPScreen = '/registerOTPScreen';
  static const changePassword = '/changePassword';
  static const registerScreen = '/registerScreen';
  static const resetOTPScreen = '/resetOTPScreen';
  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      AppRoutes.forgotPassword: ((context) => PasswordResetScreen()),
      AppRoutes.changePassword: (context) => NewPasswordScreen(),
      AppRoutes.registerOTPScreen: (context) => RegisterOTPScreen(),
      AppRoutes.resetOTPScreen: (context) => ResetOTPScreen(),
      AppRoutes.loginScreen: (context) => LoginScreen(),
      AppRoutes.registerScreen: (context) => SignUp(),
        AppRoutes.loadHome: (context) => LoadingHomeScreen(),
        AppRoutes.package: (context) =>Package(),
         AppRoutes.dashboardScreen: (context) =>Dashboard(),
              AppRoutes.navbar: (context) =>NavBar(),
    };
  }
}
