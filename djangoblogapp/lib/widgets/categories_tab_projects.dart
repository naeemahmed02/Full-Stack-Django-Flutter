import 'package:djangoblogapp/constants/colors.dart';
import 'package:djangoblogapp/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CategoriesTabProjects extends StatelessWidget {
  final List<String> projectCategories = [
    'All', 'Django', 'Flutter', 'Full Stack'
  ];
  CategoriesTabProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: CustomColors.tab_container_background,
      ),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: projectCategories.map((category){
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CustomColors.scaffold_background_color,
              ),
              child: Text(category, style: CustomTextStyles.category_tab_container_text_style,),
            );
          }).toList(),
        ),
      ),
    );
  }
}
