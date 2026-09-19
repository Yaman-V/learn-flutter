// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:super_store/models/product.dart';
import 'package:super_store/providers/cart_provider.dart';
import 'package:super_store/screens/product_list_screen.dart';
import 'package:super_store/services/product_service.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(create: (_) => CartProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProductListScreen());
  }
}

// ******************** Tests ******************
// Service (API) test
void serviceTest() async {
  final service = ProductService();

  try {
    print('Fetching products from the internet... 🌐');

    final products = await service.getAllProducts();

    print('Success! We downloaded ${products.length} products.');
    print('The first product is: ${products[0]}');
  } catch (e) {
    print(e);
  }
}

// Hardcoded test for the model
void modelTest() {
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
}
