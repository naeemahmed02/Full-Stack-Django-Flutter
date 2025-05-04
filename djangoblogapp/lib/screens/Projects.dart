import 'package:djangoblogapp/constants/colors.dart';
import 'package:djangoblogapp/constants/text_styles.dart';
import 'package:djangoblogapp/widgets/tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:djangoblogapp/providers/ProjectProviders.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' show parse;
import 'package:url_launcher/url_launcher.dart';

import '../helper/UrlLauncher.dart';
import '../widgets/categories_tab_projects.dart';
import 'ArticlesScreen.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProjectProvider>(context, listen: false).loadProjects();
    });
  }

  String stripHtml(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final projects = projectProvider.projectList;

    return Scaffold(
      backgroundColor: CustomColors.scaffold_background_color,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black87),
                  ),
                  const SizedBox(width: 15),
                  Text('What I Built', style: CustomTextStyles.Article_page_heading_text_style),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'A showcase of my projects',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // Search Bar
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: CustomColors.category_tab_background,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Search Projects here",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    projectProvider.filterProjects(value);
                  },
                  style: const TextStyle(color: CustomColors.circle_color),
                  cursorColor: CustomColors.circle_color,
                ),
              ),

              const SizedBox(height: 20),

              // Project List
              if (projectProvider.is_laoding)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else if (projectProvider.error.isNotEmpty)
                Expanded(child: Center(child: Text(projectProvider.error)))
              else if (projects.isEmpty)
                  const Expanded(child: Center(child: Text('No project available for now')))
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return Card(
                          shadowColor: Colors.grey[300],
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left side: Text
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        project.project_title,
                                        style: CustomTextStyles.article_title_text_style,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        stripHtml(project.project_description),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Tech Stack:',
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 5),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: const [
                                            Chip(
                                              label: Text(
                                                'Flutter',
                                                style: TextStyle(color: CustomColors.circle_color),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Chip(
                                              label: Text(
                                                'Firebase',
                                                style: TextStyle(color: CustomColors.circle_color),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 10),

                                // Right side: Image and links
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://naeemahmedbe.pythonanywhere.com/media/photos/featured_images/django_uuA8IvM.png',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse(project.github_link));
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(
                                            CupertinoIcons.link_circle,
                                            color: CustomColors.circle_color,
                                            size: 20,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'GitHub',
                                            style: TextStyle(
                                              color: CustomColors.circle_color,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
