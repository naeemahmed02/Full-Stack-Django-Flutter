import 'package:djangoblogapp/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    // Example categories list
    final List<String> categories = [
      'Django',
      'Python',
      'ORM',
      'Views',
      'Forms',
      'Admin',
      'Auth',
      'API',
      'DRF',
      'JWT',
      'CBV',
      'FBV',
      'Model',
      'Signals',
      'Celery',
      'Redis',
      'Docker',
      'Gunicorn',
      'Nginx',
      'SQL',
    ];


    return Scaffold(
      backgroundColor: CustomColors.scaffold_background_color,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black87,)),
                  SizedBox(width: 15,),
                  Text('Explore Categories', style: CustomTextStyles.Article_page_heading_text_style),
                ],
              ),
              SizedBox(height: 5,),
              Text('Browse topics based on technology, tools, and concepts I write about.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
              SizedBox(height: 10,),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories
                    .map((category) => Chip(
                  label: Text(category),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey.shade300),
                ))
                    .toList(),
              )
            ],
          ),
        )
        ),
      );
    
  }
}
