import 'package:djangoblogapp/providers/ArticlesProviders.dart';
import 'package:djangoblogapp/providers/ProjectProviders.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<ProjectProvider>(context, listen: false).loadProjects();
      Provider.of<ArticlesProviders>(context, listen: false).loadArticles();
    });
  }

  // Open social URL
  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black87, // Background for better visibility
        ),
        child: FaIcon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.scaffold_background_color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with avatar
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://cdn.pixabay.com/photo/2021/06/15/16/11/man-6339003_1280.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 15,
                    left: 16,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: MediaQuery.of(context).size.width / 2 - 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/naeem.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              const Text(
                "Naeem Ahmed",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("Full Stack Developer (Django + Flutter)"),
              const SizedBox(height: 20),

              // Projects & Articles Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<ProjectProvider>(
                      builder: (context, value, child) {
                        final projects = value.projectList;
                        if (value.is_laoding) {
                          return _buildStatBox("Projects", "Loading...");
                        } else {
                          return _buildStatBox("Projects", value.projectList.length.toString());
                        }
                      },
                    ),
                    Consumer<ArticlesProviders>(
                      builder: (context, value, child) {
                        if (value.is_loading) {
                          return _buildStatBox("Articles", "Loading...");
                        } else {
                          return _buildStatBox("Articles", value.articlesList.length.toString());
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Bio Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Bio",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "I am a passionate Full Stack Developer experienced in building modern web and mobile apps using Django and Flutter. I write about Django projects on my blog and enjoy exploring open-source.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Social Links
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Social Links",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/naeemahmed02'),
                        _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com/in/naeem02'),
                        _buildSocialIcon(FontAwesomeIcons.twitter, 'https://twitter.com/naeembooher'),
                        _buildSocialIcon(FontAwesomeIcons.instagram, 'https://instagram.com/naeem'),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String title, String count) {
    return Expanded(
      child: Chip(
        backgroundColor: Colors.white,
        label: Column(
          children: [
            Text(
              count,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
