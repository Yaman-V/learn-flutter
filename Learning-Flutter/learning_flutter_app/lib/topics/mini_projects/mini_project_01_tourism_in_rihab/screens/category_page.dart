import 'package:flutter/material.dart';
import 'package:learning_flutter_app/topics/mini_projects/mini_project_01_tourism_in_rihab/models/monument.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Monument> getMonuments() {
    switch (widget.category) {
      case 'churches':
        return [
          Monument(
            name: 'Church of St. George',
            description:
                """It is one of the oldest historical churches in the world, and it was a cave in which a Christian group worshiped in secret for fear of the oppression of the pagan Roman state.""",
            imagePath: 'assets/icons/church.png',
            latitude: 32.32166,
            longitude: 36.09681,
            imagePath1: 'assets/images/a17.jpg',
            imagePath2: 'assets/images/g1.jpg',
            imagePath3: 'assets/images/g4.jpg',
          ),
        ];
      case 'Cemeteries':
        return [];
      case 'Water_wells':
        return [];
      case 'Caves':
        return [];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Monument> monuments = getMonuments();
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: SafeArea(
        child: ListView.builder(
          itemCount: monuments.length,
          itemBuilder: (context, index) {
            final monument = monuments[index];
            return Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      monument.imagePath,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      largerImage(context, monument.imagePath1),
                      largerImage(context, monument.imagePath2),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          monument.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          monument.description,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.map),
                    onPressed: () {
                      // _launchMaps(monument.latitude, monument.longitude),
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget largerImage(BuildContext context, String monument) {
  return GestureDetector(
    onTap: () => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Image.asset(monument, height: 300),
          ),
        );
      },
    ),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Image.asset(monument, height: 50),
    ),
  );
}
