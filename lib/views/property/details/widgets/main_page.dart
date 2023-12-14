import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';

class PropertyMainprops extends StatelessWidget {
  const PropertyMainprops({
    super.key,
    required this.type,
    required this.img,
     this.width
  });
  final String type;
  final String img;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                width: 0.5,
                color: Pallete.fade,
              )),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
              img,
              width: 20,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          type,
          style: AppFonts.body1.copyWith(
            color: Pallete.text,
            fontSize: 12,
          ),
        ),
        SizedBox(
          width: width
        ),
      ],
    );
  }
}
