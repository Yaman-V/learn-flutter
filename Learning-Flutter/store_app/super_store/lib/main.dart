import 'package:flutter/material.dart';
import 'package:super_store/models/product.dart';

void main() {
  // Hardcoded test for the model
  final Map<String, dynamic> fakeApiData = {
    "id": 1,
    "title": "Essence Mascara Lash Princess",
    "description": "The Essence Mascara Lash Princess is a popular mascara...",
    "category": "beauty",
    "price": 9.99,
    "rating": 2.56,
    "tags": ["beauty", "mascara"],
    "brand": "Essence",
    "availabilityStatus": "In Stock",
    "returnPolicy": "No return policy",
    "images": ["https://.../1.webp"],
    "thumbnail": "https://.../thumbnail.webp",
  };

  final myTestProduct = Product.fromJson(fakeApiData);
  print(myTestProduct);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(child: Text('Super Store, Placeholder')),
      ),
    );
  }
}
