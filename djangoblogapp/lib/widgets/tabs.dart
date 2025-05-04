import 'package:djangoblogapp/screens/Categories.dart';
import 'package:djangoblogapp/screens/Projects.dart';
import 'package:flutter/material.dart';
import 'package:djangoblogapp/screens/ArticlesScreen.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class Tabs extends StatelessWidget {
  Tabs({super.key});
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ArticlesScreen()));
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Articles',
              style: CustomTextStyles.tab_container_text_style,
            ),
            height: 35,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CustomColors.scaffold_background_color),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          height: 35,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: CustomColors.scaffold_background_color),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Projects()));
            },
            child: Text(
              'Projects',
              style: CustomTextStyles.tab_container_text_style,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Categories()));
            },
            child: Text(
              'Categories',
              style: CustomTextStyles.tab_container_text_style,
            ),
          ),
          height: 35,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: CustomColors.scaffold_background_color),
        ),
      ],
    );
  }
}
