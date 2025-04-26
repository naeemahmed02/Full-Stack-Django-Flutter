import 'package:flutter/material.dart';
import 'package:naeemahmed/constants/colors.dart';
import 'package:naeemahmed/constants/text_styles.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.appbar_background_color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: CustomColors.circle_color,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(width: 12,),
                Text(
                      'Naeem Ahmed',
                      style: CustomTextStyles.app_bar_text_style,
                    ),
              ],
            ),
            Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(image: NetworkImage('https://cdn.pixabay.com/photo/2021/06/15/16/11/man-6339003_1280.jpg',), fit: BoxFit.cover)
                    ),
                  ),
                  ],
                )
          ],
        ),
      ),
    );
  }
}
