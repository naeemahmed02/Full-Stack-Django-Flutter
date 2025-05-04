import 'package:flutter/material.dart';
import 'package:djangoblogapp/models/ArticlesModel.dart';
import 'package:djangoblogapp/providers/ArticlesProviders.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../services/ArticlesServices.dart';

class SingleArticle extends StatefulWidget {
  final String slug;
  const SingleArticle({super.key, required this.slug});

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
    return Scaffold(
      body: FutureBuilder<ArticlesModel>(
        future: singleArticle,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No Data Available'));
          } else {
            final article = snapshot.data!;
            return Stack(
              children: [
                // Featured Image
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
                    color: Colors.black12,
                  ),
                ),
                // Back Button
                Positioned(
                  top: 50,
                  left: 15,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
                  ),
                ),
                // Article Content
                Positioned(
                  top: 220,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category
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
                              style: const TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.none,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Title
                          Text(
                            article.title,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 25,
                              height: 1.3,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // HTML Content
                          Flexible(
                            child: InAppWebView(
                              initialData: InAppWebViewInitialData(
                                data: article.content,
                                baseUrl: WebUri("http://naeemahmedbe.pythonanywhere.com/api/articles/${article.slug}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
