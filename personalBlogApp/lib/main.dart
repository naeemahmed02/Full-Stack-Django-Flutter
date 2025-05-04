import 'package:djangoblogapp/providers/ProjectProviders.dart';
import 'package:flutter/material.dart';
import 'package:djangoblogapp/providers/ArticlesProviders.dart';
import 'package:djangoblogapp/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ArticlesProviders()),
      ChangeNotifierProvider(create: (_) => ProjectProvider())
    ],
    child: const MyApp())
    );

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}