import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:djangoblogapp/constants/colors.dart';
import 'package:djangoblogapp/constants/text_styles.dart';
import 'package:djangoblogapp/providers/ArticlesProviders.dart';
import 'package:djangoblogapp/screens/ArticlesScreen.dart';
import 'package:djangoblogapp/widgets/custom_appbar.dart';
import 'package:djangoblogapp/widgets/tabs.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/BottomNavigationBar.dart';
import '../widgets/article_widget.dart';
// import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    String today = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: CustomColors.scaffold_background_color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(),
                SizedBox(height: screenHeight * 0.06),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.003,
                    horizontal: screenWidth * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Backend Developer',
                        style: CustomTextStyles.main_heading,
                      ),
                      SizedBox(height: screenHeight * 0.006),
                      Text(
                        "Bridging Backend Logic with \nBeautiful Interfaces",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.025,
                        ),
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: CustomColors.tab_container_background,
                        ),
                        child: Tabs(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.003,
                    horizontal: screenWidth * 0.04,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Just For You',
                        style: CustomTextStyles.second_heading_text_style,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticlesScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'See More',
                          style: CustomTextStyles.see_more_heading_text_style,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.003,
                    horizontal: screenWidth * 0.04,
                  ),
                  child: Consumer<ArticlesProviders>(
                    builder: (context, provider, child) {
                      if (provider.is_loading) {
                        return Column(
                          children: List.generate(3, (index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: screenHeight * 0.025,
                                ),
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }),
                        );
                      } else if (provider.error.isNotEmpty) {
                        return Center(child: Text('Error: ${provider.error}'));
                      } else {
                        return Column(
                          children:
                              provider.articlesList.map((article) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: screenHeight * 0.025,
                                  ),
                                  child: ArticleWidget(article: article),
                                );
                              }).toList(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
