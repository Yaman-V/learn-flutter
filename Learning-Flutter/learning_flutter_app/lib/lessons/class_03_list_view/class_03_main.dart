import 'package:flutter/material.dart';

// Data model
class Product {
  // since those Product is immutable those should be final
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

// Add a delete action — wire your trailing: Icon(Icons.add_box) (or swap it for a delete icon, your call) to remove that product via setState.
// Add a minimal DetailScreen (new StatelessWidget, takes a Product in its constructor, displays the name and star count). Wire onTap to Navigator.push to it, passing products[index].

// This is stateful because we change the product list
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            onDismissed: (direction) => setState(() {
              products.removeAt(index);
            }),

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
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(products[index].name),
                  duration: Duration(seconds: 1),
                ),
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
