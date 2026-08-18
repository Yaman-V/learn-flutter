import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:learning_flutter_app/providers/language_provider.dart';
import 'package:learning_flutter_app/providers/theme_provider.dart';
import 'package:learning_flutter_app/topics/mini_projects/mini_project_01_tourism_in_rihab/screens/category_page.dart';

import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    final Widget themeIcon = themeProvider.isDarkMode
        ? const Icon(Icons.dark_mode)
        : const Icon(Icons.light_mode);

    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr()),
        actions: [
          IconButton(onPressed: themeProvider.toggleTheme, icon: themeIcon),
          IconButton(
            icon: Text(
              languageProvider.locale.languageCode == 'en' ? 'AR' : 'EN',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              languageProvider.toggleLanguage();
              context.setLocale(languageProvider.locale);
            },
          ),
          IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: Icon(Icons.exit_to_app, color: Colors.red),
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: 10),
            Text(
              'greeting'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),

            SizedBox(
              height: 600,
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryPage(category: 'churches'),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/church.png", width: 50),
                          SizedBox(height: 10),
                          Text(
                            'churches',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/tombstone.png", width: 50),
                        SizedBox(height: 10),
                        Text(
                          'cementery',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/water-well.png", width: 50),
                        SizedBox(height: 10),
                        Text(
                          'Water Wells',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/cave.png", width: 50),
                        SizedBox(height: 10),
                        Text(
                          'Caves',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
