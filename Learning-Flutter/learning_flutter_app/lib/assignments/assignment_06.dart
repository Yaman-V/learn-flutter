import 'package:flutter/material.dart';

class Assignment06 extends StatelessWidget {
  const Assignment06({super.key});

  static const Color royalGreen = Color.fromARGB(255, 2, 69, 52);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: royalGreen),
        scaffoldBackgroundColor: const Color(0xFF1C1C1C),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _experienceLevel = 0;

  void _incrementLevel() {
    setState(() {
      _experienceLevel++;
    });
  }

  static const Color labelColor = Colors.grey;
  static const Color valueColor = Color(0xFFF2B01E); // gold/yellow accent

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assignment-6 : Profile',
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 1),
                  image: const DecorationImage(
                    image: const AssetImage("assets/img-1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white24, thickness: 3),
            const SizedBox(height: 20),
            const Text(
              'NAME',
              style: TextStyle(color: labelColor, letterSpacing: 1.2),
            ),
            const SizedBox(height: 6),
            const Text(
              'Yaman Adeeb',
              style: TextStyle(
                color: valueColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'HOMETOWN',
              style: TextStyle(color: labelColor, letterSpacing: 1.2),
            ),
            const SizedBox(height: 6),
            const Text(
              'AMMAN',
              style: TextStyle(
                color: valueColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'CURRENT EXPERIENCE LEVEL',
              style: TextStyle(color: labelColor, letterSpacing: 1.2),
            ),
            const SizedBox(height: 6),
            Text(
              '$_experienceLevel',
              style: const TextStyle(
                color: valueColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: Colors.white70,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'email_example@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementLevel,
        child: const Icon(Icons.add),
      ),
    );
  }
}
