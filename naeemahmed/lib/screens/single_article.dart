import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:naeemahmed/models/ArticlesModel.dart';
import 'package:naeemahmed/providers/ArticlesProviders.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

import '../services/ArticlesServices.dart';

class SingleArticle extends StatefulWidget {
  final String slug;
  SingleArticle({super.key, required this.slug});

  @override
  State<SingleArticle> createState() => _SingleArticleState();
}

class _SingleArticleState extends State<SingleArticle> {
  late Future<ArticlesModel> singleArticle;
  @override
  void initState() {
    super.initState();
    singleArticle = Articlesservices().getSingleArticle(widget.slug);
  }
  @override
  Widget build(BuildContext context) {
    final singleArticleProvider = Provider.of<Articlesproviders>(context, listen: false);
    return FutureBuilder(future: singleArticle, builder: (context, snapshot){
      if (snapshot.connectionState == ConnectionState.waiting){
        print('Waiting');
        return Center(child: CircularProgressIndicator());
      }
      else if (snapshot.hasError){
        print('Error: $snapshot.error');
        return Center(child: Text('Error: $snapshot.error'));
      }
      else if (!snapshot.hasData){
        return Center(child: Text('No Data Available'));
      }
      else{
        final article = snapshot.data!;
        print(article.content);
        return Stack(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(article.featured_image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: 250,
                decoration: BoxDecoration(color: Colors.black12),
              ),
            ),
            Positioned(
              top: 50,
              left: 15,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white)
              ),
            ),
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dynamic Category
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          child: Text(
                            article.category,
                            style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.none,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          article.title,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 25,
                            height: 1.3,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 20),
                        MarkdownBody(
                          data: article.content,
                          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                            p: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                        Html(data: article.content,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    },);
  }
}
