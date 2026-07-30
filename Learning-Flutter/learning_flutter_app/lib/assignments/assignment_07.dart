import 'package:flutter/material.dart';

class Assignment07 extends StatelessWidget {
  const Assignment07({super.key});

  static const Color royalGreen = Color.fromARGB(255, 2, 69, 52);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: royalGreen),
        scaffoldBackgroundColor: const Color.fromARGB(255, 231, 227, 227),
        appBarTheme: const AppBarTheme(
          backgroundColor: royalGreen,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: royalGreen,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assignment-07 : List View')),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Container(
            color: const Color.fromARGB(255, 255, 255, 15),
            child: ListTile(title: Text('Iteam 1')),
          ),
          ListTile(
            leading: Icon(Icons.map_outlined),
            title: Text('Map'),
            subtitle: Text('Open Maps'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Album'),
            subtitle: Text('View your Images'),
            trailing: Icon(Icons.arrow_forward),
          ),
          Container(
            color: const Color.fromARGB(255, 15, 107, 255),
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.amberAccent),
              title: Text('Iteam with Icons'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
            subtitle: Text('Make a call'),
            trailing: Icon(Icons.arrow_forward),
          ),
          Container(
            width: 200,
            height: 200,
            child: Image.asset('assets/profile_pic_1.jpg'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            subtitle: Text('Adjust Settings'),
            trailing: Icon(Icons.arrow_forward),
          ),
          Container(
            color: Colors.lightGreenAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 5,
                children: [
                  Text('Item with Column', style: TextStyle(fontSize: 20)),
                  Text(
                    'Second Text',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
