import 'package:flutter/material.dart';
import 'package:naeemahmed/constants/colors.dart';
import 'package:naeemahmed/constants/text_styles.dart';
import 'package:naeemahmed/models/ArticlesModel.dart';
import 'package:naeemahmed/screens/single_article.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../providers/ArticlesProviders.dart';

class ArticleWidget extends StatelessWidget {
  ArticlesModel article;
  ArticleWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Articlesproviders>(context, listen: false);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: CustomColors.category_tab_background,
                  ),
                  child: Text(article.category, style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFC2410C))),
                ),
                SizedBox(height: 7,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SingleArticle(slug: article.slug,)));
                  },
                  child: Text(
                    article.title,
                    style: CustomTextStyles.article_title_text_style, maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 7,),
                Row(children: [
                Text('${article.readTimeMethod} Min read', style: CustomTextStyles.article_meta_data_text_style,),
                SizedBox(width: 7,),
                Text(timeago.format(article.created_at), style: CustomTextStyles.article_meta_data_text_style)
              ],)
              ],
            ),
          ),
          SizedBox(width: 10,),
          Container(
              width: 120,
              height: 120,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(image: NetworkImage(article.featured_image), fit: BoxFit.cover,))),
        ],
      ),
    );
  }
}
