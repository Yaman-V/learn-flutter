import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Class06 extends StatefulWidget {
  const Class06({super.key});

  @override
  State<Class06> createState() => _Class06State();
}

class _Class06State extends State<Class06> {
  List universities = [];
  // This hold the results of the filtering (.where())
  List filteredUniversities = [];
  String selectedCountry = 'Jordan';
  final List<String> countries = [
    'Argentina',
    'Australia',
    'Brazil',
    'Canada',
    'China',
    'Egypt',
    'France',
    'Germany',
    'India',
    'Japan',
    'Jordan',
    'Mexico',
    'Nigeria',
    'South Africa',
    'United Kingdom',
    'United States',
  ];

  // Get the API data as the app starting
  @override
  void initState() {
    super.initState();
    getUniData();
  }

  void getUniData() async {
    final response = await http.get(
      Uri.parse(
        'http://universities.hipolabs.com/search?country=$selectedCountry',
      ),
    );

    setState(() {
      universities = json.decode(response.body);
      filteredUniversities = universities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Class_06: University App')),
      body: ListView.builder(
        itemCount: filteredUniversities.length,
        itemBuilder: (context, index) {
          // shortcut
          var uni = filteredUniversities[index];
          return Card(child: Column(children: [Text(uni['name'])]));
        },
      ),
    );
  }
}
