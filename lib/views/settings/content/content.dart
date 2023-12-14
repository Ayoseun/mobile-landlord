import 'package:flutter/material.dart';

import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  List<dynamic>? info;
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    info = dataFromRoute["data"];
    print(info![0]);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    Text("Settings",style: AppFonts.smallWhite,)
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
                    Text(
                      dataFromRoute["header"],
                      style: AppFonts.bodyText,
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    SizedBox(
                        width: _getSize.width,
                        height: _getSize.height * 0.7,
                        child: ListView.builder(
                            itemCount: info!.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 48.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      info![index]["icon"],
                                      width: 24,
                                    ),
                                    SizedBox(
                                      width: _getSize.width * 0.05,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          info![index]["text"],
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
                                            info![index]["text2"],
                                            style: AppFonts.bodyText
                                                .copyWith(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
