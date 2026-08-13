import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:learning_flutter_app/screens/topics/mini_projects/mini_project_01_tourism_in_rihab/providers/language_provider.dart';
import 'package:learning_flutter_app/screens/topics/mini_projects/mini_project_01_tourism_in_rihab/providers/theme_provider.dart';

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
                children: [Card(), Card(), Card(), Card()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
