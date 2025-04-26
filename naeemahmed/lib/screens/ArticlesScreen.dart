import 'package:flutter/material.dart';
import 'package:naeemahmed/constants/colors.dart';
import 'package:naeemahmed/providers/ArticlesProviders.dart';
import 'package:naeemahmed/widgets/article_widget.dart';
import 'package:naeemahmed/widgets/categories_tabs.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_appbar.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
  Provider.of<Articlesproviders>(context, listen: false).loadArticles();
});
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: CustomColors.scaffold_background_color,
    body: SafeArea(
      child: Column(
        children: [
          CustomAppbar(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CustomColors.tab_container_background,
              ),
              child: CategoriesTabs(),
            ),
          ),
          SizedBox(height: 20),
          // 👇 Expanded wraps the list
          Expanded(
            child: Consumer<Articlesproviders>(builder: (context, provider, child) {
              if (provider.is_loading) {
                return Center(child: CircularProgressIndicator());
              } else if (provider.error.isNotEmpty) {
                return Center(child: Text(provider.error));
              } else {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  itemCount: provider.articlesList.length,
                  itemBuilder: (context, index) {
                    return Padding(padding: EdgeInsets.only(bottom: 20),
                      child: ArticleWidget(article: provider.articlesList[index],),
                    );
                  },
                );
              }
            }),
          )
        ],
      ),
    ),
  );
}
}