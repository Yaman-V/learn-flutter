import 'dart:convert';

import 'package:super_store/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getAllProducts() async {
    final url = Uri.parse('https://dummyjson.com/products');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Response status code is not (OK 200)');
    }

    final productData = jsonDecode(response.body);
    final List<dynamic> productsList = productData['products'];
    return productsList.map((product) => Product.fromJson(product)).toList();
  }
}
