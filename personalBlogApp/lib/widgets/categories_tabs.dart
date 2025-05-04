import 'package:djangoblogapp/providers/ArticlesProviders.dart';
import 'package:flutter/material.dart';
import 'package:djangoblogapp/screens/ArticlesScreen.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class CategoriesTabs extends StatelessWidget {
  final List<String> categories = [
    "All",
    "Django",
    "Python",
    "Full Stack",
    "Flutter",
  ];

  CategoriesTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: categories.map((category) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CustomColors.scaffold_background_color,
              ),
              child: GestureDetector(
                onTap: (){
                  if (category == "All"){
                    Provider.of<ArticlesProviders>(context, listen: false).loadArticles();
                  }
                  else if(category.isEmpty){
                    Center(child: Text('No Articles available for this Category'),);
                  }
                  else {
                    Provider.of<ArticlesProviders>(context, listen: false).loadArticlesAgainstCategory(category);
                  }
                },
                child: Text(
                  category,
                  style: CustomTextStyles.category_tab_container_text_style,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
