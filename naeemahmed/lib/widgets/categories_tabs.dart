import 'package:flutter/material.dart';
import 'package:naeemahmed/screens/ArticlesScreen.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class CategoriesTabs extends StatelessWidget {
  const CategoriesTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.center,
            child: Text(
              'Django',
              style: CustomTextStyles.category_tab_container_text_style,
            ),
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CustomColors.scaffold_background_color),
          ),
          SizedBox(width: 15,),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Python',
              style: CustomTextStyles.category_tab_container_text_style,
            ),
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CustomColors.scaffold_background_color),
          ),
          SizedBox(width: 15,),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Full Stack',
              style: CustomTextStyles.category_tab_container_text_style,
            ),
            height: 30,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CustomColors.scaffold_background_color),
          ),
          SizedBox(width: 15,),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Flutter',
              style: CustomTextStyles.category_tab_container_text_style,
            ),
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CustomColors.scaffold_background_color),
          ),
          
      ],
    );
  }
}
