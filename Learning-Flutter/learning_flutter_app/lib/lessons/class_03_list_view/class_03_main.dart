import 'package:flutter/material.dart';

// Data model
class Product {
  final String name;
  final int starCount;
  Product({required this.name, required this.starCount});
}

class Class03Main extends StatelessWidget {
  const Class03Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false);
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Product> products = [
    Product(name: 'Coffee', starCount: 5),
    Product(name: 'PS5', starCount: 2),
    Product(name: 'PS4', starCount: 1),
    Product(name: 'Sream Box', starCount: 0),
    Product(name: 'Apple Mac M5', starCount: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Class:03 : List View'),
      ),
      body: ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.label),
            title: Text(products[index].name),
            subtitle: Row(
              children:
                  // When using List.generate we cant use [] for some reason !!
                  List.generate(
                    products[index].starCount,
                    (i) => Icon(Icons.star, color: Colors.yellow),
                  ),
            ),
            trailing: Icon(Icons.add_box),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(products[index].name),
                duration: Duration(seconds: 1),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(), //I want the defult
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart_checkout),
        onPressed: () {},
      ),
    );
  }
}
