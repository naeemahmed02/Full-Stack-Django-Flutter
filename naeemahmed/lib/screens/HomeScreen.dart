import 'package:flutter/material.dart';
import 'package:naeemahmed/constants/colors.dart';
import 'package:naeemahmed/constants/text_styles.dart';
import 'package:naeemahmed/providers/ArticlesProviders.dart';
import 'package:naeemahmed/screens/ArticlesScreen.dart';
import 'package:naeemahmed/widgets/custom_appbar.dart';
import 'package:naeemahmed/widgets/tabs.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/article_widget.dart';

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
      Provider.of<Articlesproviders>(context, listen: false).loadArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
    return Scaffold(
      backgroundColor: CustomColors.scaffold_background_color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Backend Developer', style: CustomTextStyles.main_heading,),
                    SizedBox(height: 5,),
                      Text("Bridging Backend Logic with \nBeautiful Interfaces", style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: CustomColors.tab_container_background
                      ),
                      child: Tabs()
                    )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Just For You', style: CustomTextStyles.second_heading_text_style),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlesScreen()));
                        },
                          child: Text('See More', style: CustomTextStyles.see_more_heading_text_style,)),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  child: Consumer<Articlesproviders>(builder: (context, provider, child){
                    if (provider.is_loading){
                      return Center(child: CircularProgressIndicator());
                    }
                    else if (provider.error.isNotEmpty){
                      return Center(child: CircularProgressIndicator());
                    }
                    else {
                      return Column(
                        children: provider.articlesList.map((article){
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: ArticleWidget(article: article),
                          );
                        }).toList(),
                      );
                    }
                  })
                )
              ],
            ),
        ),
        ),
      ));
  }
}