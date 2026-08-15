import 'package:flutter/material.dart';

// Data model
class Product {
  // since those Product is immutable those should be final
  final String name;
  final int starCount;
  Product({required this.name, required this.starCount});
}

// This is stateful because we change the product list
class Class03 extends StatefulWidget {
  const Class03({super.key});

  @override
  State<Class03> createState() => _Class03State();
}

class _Class03State extends State<Class03> {
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
          // wrap the returns (list tiles) with dismissible to be able to delete.
          return Dismissible(
            // The key help with altering the tree, becuase Flutter does not re-build the tree from 0
            // use objectKey when we are dealing with objects
            key: ObjectKey(products[index]),

            // properties
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: AlignmentDirectional.centerEnd,
              padding: EdgeInsets.all(15),
              child: Icon(Icons.delete),
            ),

            onDismissed: (direction) {
              final removedName = products[index].name;
              setState(() => products.removeAt(index));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('deleted $removedName successfully.'),
                  duration: Duration(seconds: 1),
                ),
              );
            },

            child: ListTile(
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
              trailing: Icon(Icons.add_shopping_cart),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsPage(selectedProduct: products[index]),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart_checkout),
        onPressed: () {},
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Product selectedProduct;
  const ProductDetailsPage({super.key, required this.selectedProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedProduct.name)),
      body: Center(
        child: Card(
          color: Colors.pinkAccent,
          child: Text(
            style: TextStyle(fontSize: 28),
            'This is ${selectedProduct.name} is rated: ${selectedProduct.starCount}',
          ),
        ),
      ),
    );
  }
}
