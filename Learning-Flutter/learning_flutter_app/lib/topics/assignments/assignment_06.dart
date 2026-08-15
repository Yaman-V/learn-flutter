// topics/assignments/assignment_06_profile.dart
import 'package:flutter/material.dart';

class Assignment06Profile extends StatefulWidget {
  const Assignment06Profile({super.key});

  @override
  State<Assignment06Profile> createState() => _Assignment06ProfileState();
}

class _Assignment06ProfileState extends State<Assignment06Profile> {
  int _experienceLevel = 0;

  static const Color labelColor = Colors.grey;
  static const Color valueColor = Color(0xFFF2B01E); // gold/yellow accent

  void _incrementLevel() {
    setState(() {
      _experienceLevel++;
    });
  }

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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                    BorderSide(color: Colors.white24, width: 1),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/profile_pic_1.jpg"),
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
              children: const [
                Icon(Icons.email_outlined, color: Colors.white70, size: 20),
                SizedBox(width: 10),
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
