import 'package:abjalandlord/constants/app_colors.dart';
import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../utils/app_utils.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchItem = '';
  _runFilter(value) {
    setState(() {
      searchItem = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _getSize.height * 0.023,
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
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                height: _getSize.height * 0.03,
              ),
              Text(
                "Suggestions",
                style: AppFonts.body1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Pallete.text),
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: _getSize.height * 0.01,
                      ),
                      Image.asset(
                        AppImages.agent,
                        width: 56,
                      ),
                      SizedBox(
                        height: _getSize.height * 0.001,
                      ),
                      Text(
                        "Susan",
                        style: AppFonts.body1,
                      ),
                      SizedBox(
                        height: _getSize.height * 0.001,
                      ),
                      Text(
                        "Okello",
                        style: AppFonts.body1,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: _getSize.height * 0.01,
                      ),
                      Image.asset(
                        AppImages.agent,
                        width: 56,
                      ),
                      SizedBox(
                        height: _getSize.height * 0.001,
                      ),
                      Text(
                        "Susan",
                        style: AppFonts.body1,
                      ),
                      SizedBox(
                        height: _getSize.height * 0.001,
                      ),
                      Text(
                        "Okello",
                        style: AppFonts.body1,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: _getSize.height * 0.01,
                      ),
                      Image.asset(
                        AppImages.agent,
                        width: 56,
                      ),
                      SizedBox(
                        height: _getSize.height * 0.001,
                      ),
                      Text(
                        "Susan",
                        style: AppFonts.body1,
                      ),
                      SizedBox(
                        height: _getSize.height * 0.001,
                      ),
                      Text(
                        "Okello",
                        style: AppFonts.body1,
                      ),
                    ],
                  ),
                ],
              )
           
            ,SizedBox(
                height: _getSize.height * 0.023,
              ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "Recent Search",
                style: AppFonts.body1.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Pallete.text),
              ),   Text(
                "Clear",
                style: AppFonts.body1.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Pallete.primaryColor),
              ),
           ],),
           
            ],
          ),
        ),
      ),
    )));
  }
}
