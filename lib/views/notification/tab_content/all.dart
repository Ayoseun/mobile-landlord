import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';

class AllNotifications extends StatelessWidget {
  const AllNotifications({super.key, required Size getSize})
      : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    List<Map> services = [
      {
        'color': Color(0xFFFCEADA),
        "date": "Today",
        'text': 'Painter',
        'text2': "Painting of Apartment 004",
        'data': [
          {
            'icon': AppImages.agent,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
        ]
      },
      {
        'color': Color(0xFFEADAFF),
        'text': 'Rent Paid',
        "date": "Yesterday",
        'text2':
            "Agent Emmanuel has received rent payment from Miss Susan for June 2023.",
        'data': [
          {
            'icon': AppImages.painter,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2': "Painting of Apartment 004"
          },
          {
            'icon': AppImages.agent,
            'color': Color(0xFFEADAFF),
            'text': ' Apartment 006 is due for rent payment -',
            'text3': "agent!",
            'text2':
                " Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFFFE4E9),
            'text': 'New Successfully Added Tenant (Unit 005)-',
            'text2':
                " New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property."
          },
        ]
      },
      {
        'icon': AppImages.fumigator,
        'color': Color(0xFFEADAFF),
        'text': 'Rent Paid',
        "date": "Last Week",
        'text2':
            "Agent Emmanuel has received rent payment from Miss Susan for June 2023.",
        'data': [
          {
            'icon': AppImages.plumber,
            'color': Color(0xFFFCEADA),
            'text': 'Plumber',
            'text2': "Repair of leaking pipes in Apartment 007"
          },
          {
            'icon': AppImages.agent,
            'color': Color(0xFFEADAFF),
            'text': 'Rent Paid',
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
          {
            'icon': AppImages.movers,
            'color': Color(0xFFFFE4E9),
            'text': 'Front',
            'text3': "1st Floor",
            'text2':
                "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property."
          },
          {
            'icon': AppImages.movers,
            'color': Color(0xFFDAE7D9),
            'text': '2nd Floor- Back',
            'text2':
                "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property."
          },
        ]
      },
      {
        'icon': AppImages.fumigator,
        'color': Color(0xFFFFE4E9),
        'text': 'Successfully',
        "date": "Last 2 Week",
        'text2':
            "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property.",
        'data': [
          {
            'icon': AppImages.plumber,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2': "Painting of Apartment 004"
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFEADAFF),
            'text': 'Rent Paid',
            'text3': "agent!",
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
        ]
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        "date": "Last Month",
        'text2': "Mr. Eric is in need of house cleaning.",
        "data": [
          {
            'icon': AppImages.plumber,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2': "Painting of Apartment 004"
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFEADAFF),
            'text': 'Rent Paid',
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
        ]
      },
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
      child: SizedBox(
          width: _getSize.width * 0.9,
          height: _getSize.height * 0.9,
          child: ListView.builder(
              itemCount: services.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 16, left: 16),
                  child: Container(
                    height: services[index]['data'].length == 1
                        ? _getSize.height * 0.12 // For length < 2
                        : services[index]['data'].length == 2
                            ? _getSize.height * 0.17 // For length < 2
                            : services[index]['data'].length == 3
                                ? _getSize.height * 0.24 // For length < 2
                                : services[index]['data'].length == 4
                                    ? _getSize.height * 0.3
                                    : _getSize.height * 0.3,
                    width: _getSize.width,
                    decoration: BoxDecoration(
                        color: Pallete.backgroundColor,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color.fromARGB(44, 85, 80, 80),
                        //     blurRadius: 11,
                        //     spreadRadius: 1,
                        //     offset: Offset(0, 5),
                        //   )
                        // ],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            services[index]['date'],
                            style: AppFonts.boldText.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: services[index]['data'].length == 1
                                ? _getSize.height * 0.06 // For length < 2
                                : services[index]['data'].length == 2
                                    ? _getSize.height * 0.11 // For length < 2
                                    : services[index]['data'].length == 3
                                        ? _getSize.height *
                                            0.17 // For length < 3
                                        : services[index]['data'].length == 4
                                            ? _getSize.height *
                                                0.24 // For length < 4
                                            : _getSize.height *
                                                0.24, // For length >= 4
                            child: buildListItem(context,
                                services[index]['data'], _getSize.width),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

Widget buildListItem(BuildContext context, List<Map<String, dynamic>> service,
    double getSizeWidth) {
  // Assuming AppFonts and Pallete are defined elsewhere in your project.
  return ListView.builder(
      itemCount: service.length,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                service[index]['icon'],
                width: 24,
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: getSizeWidth * 0.6,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      service[index]['text3'] != null
                          ? TextSpan(
                              text: service[index]['text3'],
                              style: TextStyle(
                                color: service[index]['text3'] != 'agent!'
                                    ? Colors.black
                                    : Color.fromARGB(255, 224, 10,
                                        10), // Replace with Pallete.black if defined
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : TextSpan(
                              text: '',
                              style: TextStyle(
                                color: Colors
                                    .black, // Replace with Pallete.black if defined
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      service[index]['text3'] != null
                          ? TextSpan(
                              text: ' - ',
                              style: TextStyle(
                                color: Colors
                                    .black, // Replace with Pallete.black if defined
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : TextSpan(
                              text: '',
                              style: TextStyle(
                                color: Colors
                                    .black, // Replace with Pallete.black if defined
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      TextSpan(
                        text: '${service[index]['text']} ',
                        style: TextStyle(
                          color: Colors
                              .black, // Replace with Pallete.black if defined
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' - ${service[index]['text2']}',
                        style: TextStyle(
                          color: Colors
                              .grey, // Replace with Pallete.fade if defined
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              const Icon(Icons.more_vert),
            ],
          ),
        );
      });
}
