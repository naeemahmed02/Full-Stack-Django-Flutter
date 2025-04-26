import 'package:flutter/material.dart';
import 'package:naeemahmed/providers/ArticlesProviders.dart';
import 'package:naeemahmed/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Articlesproviders())  
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