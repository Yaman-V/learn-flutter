import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Class05 extends StatefulWidget {
  const Class05({super.key});

  @override
  State<Class05> createState() => _Class05State();
}

class _Class05State extends State<Class05> {
  String result = '';

  void getCatFacts() async {
    final url = Uri.parse('https://catfact.ninja/fact');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final mydata = jsonDecode(response.body);
      setState(() {
        result = mydata['fact'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Class_5: API(Get)'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 60,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Text(
                  result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.pink, fontSize: 20),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 40,
            child: Image.asset('assets/images/cat_image.png', height: 200),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getCatFacts,
        child: Text('show'),
      ),
    );
  }
}
