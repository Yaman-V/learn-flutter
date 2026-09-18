import 'package:flutter/material.dart';
import 'package:super_store/models/product.dart';
import 'package:super_store/screens/product_detail_screen.dart';
import 'package:super_store/services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final Future<List<Product>> products;
  @override
  void initState() {
    super.initState();
    products = ProductService().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Super Store')),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            // Error check
            if (snapshot.hasError) {
              return Text("Error: failed to get data");
            }

            // waiting
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            // Check if the Future succeeded and has data
            if (snapshot.hasData) {
              final productList = snapshot.data!;
              // return (Text('Data received: ${productList.first}'));
              return _ProductGrid(productList: productList);
            }

            // Fallback
            return Text('No data here ....');
          },
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<Product> productList;
  const _ProductGrid({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          ),

          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(8),

                    child: Container(
                      width: double.infinity,
                      color: const Color.fromARGB(131, 239, 239, 239),
                      child: Image.network(product.thumbnail),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      ElevatedButton(onPressed: () {}, child: Text('Buy')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
