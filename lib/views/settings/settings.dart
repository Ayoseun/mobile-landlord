import 'package:flutter/material.dart';

import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../utils/app_utils.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _runFilter(value) {
    setState(() {
      searchItem = value;
    });
  }

  List<Map> services = [
    {
      'text': 'My Account',
      'icon': AppImages.profile,
      'text2':
          "View your account details, download a copy of your data, and learn how to deactivate your account.",
    },
    {
      'text': 'Account Security and Access',
      'icon': AppImages.lock,
      'text2':
          "Protect your account from unauthorized access and monitor how you're using it, including the apps you've connected.",
    },
    {
      'text': 'Payments',
      'icon': AppImages.wallet,
      'text2':
          "View your payment history and make payments. Also set up automatic payments in this section.",
    },
    {
      'text': 'Privacy and Safety',
      'icon': AppImages.secure,
      'text2':
          "Choose what information you want to see and share on the Casmara app.",
    },
    {
      'text': 'Notifications',
      'icon': AppImages.notify,
      'text2':
          "Control the types of notifications you receive about your account, so you're only notified about the things you care about.",
    },
    {
      'text': 'Accessibility, display and languages',
      'icon': AppImages.accessibility,
      'text2': "Customize the way Casmara content is displayed to you.",
    }
  ];

  var account = [
    {
      'text': 'Account Information',
      'icon': AppImages.profile,
      'text2':
          "Access your account information, such as your phone number and email address.",
    },
    {
      'text': 'Change your password',
      'icon': AppImages.lock,
      'text2': "You can change your password whenever you want.",
    },
    {
      'text': 'Download an archive of your data.',
      'icon': AppImages.sharpdwonload,
      'text2':
          "Discover the types of information that are collected and stored by the service.",
    },
    {
      'text': 'Deactivate your account',
      'icon': AppImages.brokenHeart,
      'text2': "Learn how to deactivate your account.",
    }
  ];
  var security = [
    {
      'text': 'Account Information',
      'icon': AppImages.profile,
      'text2':
          "Access your account information, such as your phone number and email address.",
    },
    {
      'text': 'Change your password',
      'icon': AppImages.lock,
      'text2': "You can change your password whenever you want.",
    },
    {
      'text': 'Download an archive of your data.',
      'icon': AppImages.sharpdwonload,
      'text2':
          "Discover the types of information that are collected and stored by the service.",
    },
    {
      'text': 'Deactivate your account',
      'icon': AppImages.brokenHeart,
      'text2': "Learn how to deactivate your account.",
    }
  ];
  String searchItem = '';
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: _getSize.height,
          width: _getSize.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        AppImages.back,
                        width: 36,
                      ),
                    ),
                    Text("Settings"),
                    Text("")
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: _getSize.height * 0.003,
                    ),
                    Container(
                      height: _getSize.height * 0.055,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Color(0xFF949494),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextField(
                                onChanged: (value) => _runFilter(value),
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                ),
                                style: AppFonts.body1.copyWith(fontSize: 14),
                                // Add any necessary event handlers for text changes or submission.
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (searchItem.isEmpty) {
                                AppUtils.showSnackBarMessage(
                                    'Enter an item to search for', context);
                              } else {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.randomSearch,
                                  arguments: {
                                    'search': searchItem,
                                  },
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image.asset(
                                AppImages.search,
                                width: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    SizedBox(
                        width: _getSize.width,
                        height: _getSize.height * 0.7,
                        child: ListView.builder(
                            itemCount: services.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.settingsDetails,
                                      arguments: {
                                        'data': account,
                                        'header':
                                            "View your account details, download a copy of your data, and learn how to deactivate your account."
                                      },
                                    );
                                  } else if (index == 1) {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.settingsDetails,
                                        arguments: {
                                          'data': account,
                                          "header": ""
                                        });
                                  } else if (index == 2) {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.settingsDetails,
                                        arguments: {
                                          'data': security,
                                          "header":
                                              "Protect your account from unauthorized access and monitor how you're using it, including the apps you've connected."
                                        });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 48.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        services[index]["icon"],
                                        width: 24,
                                      ),
                                      SizedBox(
                                        width: _getSize.width * 0.05,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            services[index]["text"],
                                            style: AppFonts.boldText.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: _getSize.height * 0.005,
                                          ),
                                          SizedBox(
                                            width: _getSize.width * 0.8,
                                            child: Text(
                                              services[index]["text2"],
                                              style: AppFonts.bodyText
                                                  .copyWith(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
