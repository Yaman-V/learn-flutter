import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Class02 extends StatelessWidget {
  const Class02({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: 'Scaffold elements',
      // impotred date from google
      theme: ThemeData(textTheme: GoogleFonts.coinyTextTheme()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scaffold elements'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,

        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          SizedBox(width: 5),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          SizedBox(width: 5),
        ],
      ),
      body: Center(child: Text("Scaffold elements")),

      drawer: Drawer(
        backgroundColor: Colors.blueGrey,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Text('My menu'),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const AssetImage(
                      "assets/profile_pic_1.jpg",
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('snackbar message')),
              duration: Duration(seconds: 3),
            ),
          );
        },
        child: Text('Show'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 25)),
            IconButton(onPressed: () {}, icon: Icon(Icons.home, size: 25)),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings, size: 25)),
          ],
        ),
      ),
    );
  }
}
