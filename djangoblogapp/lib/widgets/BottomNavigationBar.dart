import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:djangoblogapp/screens/HomeScreen.dart';
import 'package:djangoblogapp/screens/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/ArticlesScreen.dart';

class Bottomnavigationbar extends StatelessWidget {
  const Bottomnavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
    index: 1,
    onTap: (index) {},
    height: 70,
    backgroundColor: Colors.transparent,
    color: Color(0xFFC2410C),
    items: [
    InkWell(
    onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticlesScreen()));
    },
    child: Icon(Icons.article, color: Colors.white, size: 30)),
    InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      },
        child: Icon(Icons.home, color: Colors.white, size: 30)),
      InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
          },
          child: Icon(CupertinoIcons.person_alt_circle_fill, color: Colors.white, size: 30),),
    ],
    );
  }
}
