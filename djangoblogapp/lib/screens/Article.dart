import 'package:djangoblogapp/constants/colors.dart';
import 'package:djangoblogapp/models/ArticlesModel.dart';
import 'package:djangoblogapp/providers/ArticlesProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class Article extends StatefulWidget {
  final String slug, category;
  const Article({super.key, required this.slug, required this.category});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  InAppWebViewController? webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, result) async {
        final controller = webViewController;
        if (controller != null && await controller.canGoBack()) {
          controller.goBack();
        } 
      }),
      child: Scaffold(
        backgroundColor: CustomColors.appbar_background_color,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined, size: screenWidth * 0.07),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri(
                          "https://naeemahmedbe.pythonanywhere.com/blog/${widget.category}/${widget.slug}",
                        ),
                      ),
                      initialSettings: InAppWebViewSettings(
                        
                        javaScriptEnabled: true,
                      ),
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      onLoadStart: (controller, url) {
                        setState(() {
                          _isLoading = true;
                        });
                      },
                      onLoadStop: (controller, url) async {
                        setState(() {
                          _isLoading = false;
                        });

                        // Inject viewport meta tag and increase font size
                        await controller.evaluateJavascript(source: """
                          var meta = document.createElement('meta');
                          meta.name = 'viewport';
                          meta.content = 'width=device-width, initial-scale=0.8, maximum-scale=0.8, user-scalable=yes';
                          document.getElementsByTagName('head')[0].appendChild(meta);

                          var style = document.createElement('style');
                          style.innerHTML = 'body { font-size: 120% !important; line-height: 1.6; padding: 10px; }';
                          document.head.appendChild(style);
                        """);
                      },
                    ),
                    if (_isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
