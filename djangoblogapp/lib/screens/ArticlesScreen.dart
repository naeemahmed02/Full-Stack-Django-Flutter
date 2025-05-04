import 'package:djangoblogapp/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:djangoblogapp/constants/colors.dart';
import 'package:djangoblogapp/providers/ArticlesProviders.dart';
import 'package:djangoblogapp/widgets/article_widget.dart';
import 'package:djangoblogapp/widgets/categories_tabs.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/BottomNavigationBar.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  bool isSearching = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ArticlesProviders>(context, listen: false).loadArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: CustomColors.scaffold_background_color,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black87,)),
                            SizedBox(width: 15),
                            Text('Explore Articles', style: CustomTextStyles.Article_page_heading_text_style),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tech insights, tutorials, and guides',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Search Icon with Background
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSearching = !isSearching;
                          if (!isSearching) {
                            searchQuery = '';  // Reset the search query
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: CustomColors.tab_container_background, // You can choose any color here
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          isSearching ? Icons.cancel : Icons.search,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            // Show category tabs or search bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              child: isSearching
                  ? Container(
                alignment: Alignment.center,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: CustomColors.category_tab_background,
                ),
                child: TextField(
                  cursorColor: CustomColors.circle_color,
                  autofocus: true,
                  style: TextStyle(color: CustomColors.circle_color),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;

                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search articles...',
                    border: InputBorder.none,
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          searchQuery = '';
                        });
                      },
                    )
                        : null,
                  ),
                ),
              )
                  : Container(
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
            Expanded(
              child: Consumer<ArticlesProviders>(
                builder: (context, provider, child) {
                  final articles = provider.articlesList;

                  if (provider.is_loading) {
                    return Column(
                      children: List.generate(6, (index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: screenHeight * 0.025,
                              left: screenWidth * 0.025,
                              right: screenWidth * 0.025,
                            ),
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                    );
                  } else if (articles.isEmpty) {
                    return Center(
                      child: Text('No articles available for this category'),
                    );
                  } else if (provider.error.isNotEmpty) {
                    return Center(child: Text(provider.error));
                  } else {
                    // Filter articles based on search query
                    final filteredArticles = articles.where((article) {
                      return article.title.toLowerCase().contains(searchQuery.toLowerCase());
                    }).toList();

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ArticleWidget(article: filteredArticles[index]),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
