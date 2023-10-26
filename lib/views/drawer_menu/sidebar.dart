import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_routes.dart';
import '../../../../utils/app_utils.dart';
import '../../utils/local_storage.dart';


class NavBar extends StatelessWidget {
  String email = 'your email';
  String fullname = '';
  var photo;
  inituser() async {
    var close = await clear();

    close;
  }

  NavBar(
      {Key? key, required this.email, required this.fullname, required this.photo,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Pallete.whiteColor,
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(fullname,
                  style: AppFonts.body1
                      .copyWith(color: Colors.black, fontSize: 12)),
              accountEmail: Text(email,
                  style: AppFonts.body1
                      .copyWith(color: Colors.black, fontSize: 12)),
              currentAccountPicture: CircleAvatar(
                child: SizedBox(
                  height: 75,
                  child: ClipOval(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => const Center(
                              child: SpinKitCircle(
                                size: 25,
                                color: Pallete.primaryColor,
                              ),
                            ),
                            imageUrl: photo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Pallete.secondaryColor,
              ),
            ),
            ListTile(
              leading: const Icon(
          Icons.person,
                color: Pallete.black,
              ),
              title: Text('Profile',
                  style: AppFonts.body1
                      .copyWith(color: Colors.black, fontSize: 14)),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
            ),
            ListTile(
                leading: const Icon(
                   Icons.payment_rounded,
                 
                  color: Pallete.black,
                ),
                title: Text('Orders',
                    style: AppFonts.body1
                        .copyWith(color: Colors.black, fontSize: 14)),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.ordersScreen)),
            ListTile(
              leading: const Icon(
                Icons.share,
                color: Pallete.black,
              ),
              title: Text('Share',
                  style: AppFonts.body1
                      .copyWith(color: Colors.black, fontSize: 14)),
              onTap: () => {
                Share.share('Download Pharmplug app and get drugs at your convenience')
              },
            ),
            const Divider(),
            ListTile(
                leading: const Icon(
                  Icons.chat_bubble,
                  color: Pallete.black,
                ),
                title: Text('Support',
                    style: AppFonts.body1
                        .copyWith(color: Colors.black, fontSize: 14)),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.support)),
            ListTile(
                leading: const Icon(
                  Icons.error_outline,
                  color: Pallete.black,
                ),
                title: Text('About',
                    style: AppFonts.body1
                        .copyWith(color: Colors.black, fontSize: 14)),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.about)),
            const Divider(
              color: Pallete.text,
            ),
            ListTile(
                title: Text('Exit',
                    style: AppFonts.body1
                        .copyWith(color: Colors.black, fontSize: 14)),
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Pallete.hintColor,
                ),
                onTap: () {
                  AppUtils.showAlertDialog(context, 'Are you sure?',
                      'You wil be logged out', 'Logout', 'cancel', () {
                    inituser();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.loginScreen, (route) => false);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
