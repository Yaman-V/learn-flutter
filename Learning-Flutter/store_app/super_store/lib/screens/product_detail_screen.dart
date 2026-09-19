// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_store/models/cart_item.dart';
import 'package:super_store/models/product.dart';
import 'package:super_store/providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // Some logic and state (Kept in parent)
  int _quantity = 1;

  void _increment() {
    if (_quantity < widget.product.stock) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _ProductHeroImage(screen: widget),
              // dont wrap the image with padding so it is edge-to-edge.
              // Wrap the rest of the content inside Padding
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    _ProductTitle(screen: widget),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _ProductRatingsAndBrand(screen: widget),

                        const Spacer(),
                        _QuantitySelector(
                          quantity: _quantity,
                          onIncrement: _increment,
                          onDecrement: _decrement,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _ProductDescription(screen: widget),
                  ],
                ),
              ),
            ],
          ),
          const _BackArrow(),
        ],
      ),
      bottomNavigationBar: _CheckoutBottomBar(
        screen: widget,
        quantity: _quantity,
      ),
    );
  }
}

class _BackArrow extends StatelessWidget {
  const _BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 239, 239, 239),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductHeroImage extends StatelessWidget {
  const _ProductHeroImage({super.key, required this.screen});

  final ProductDetailScreen screen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      width: double.infinity,
      child: Image.network(screen.product.images[0], fit: BoxFit.cover),
    );
  }
}

class _ProductTitle extends StatelessWidget {
  const _ProductTitle({super.key, required this.screen});

  final ProductDetailScreen screen;

  @override
  Widget build(BuildContext context) {
    return Text(
      screen.product.title,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A1A1A),
        letterSpacing: -0.5,
      ),
    );
  }
}

class _ProductRatingsAndBrand extends StatelessWidget {
  const _ProductRatingsAndBrand({super.key, required this.screen});

  final ProductDetailScreen screen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text(
          screen.product.rating.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('|', style: TextStyle(color: Colors.grey)),
        ),

        Text(
          screen.product.brand != null ? 'By ${screen.product.brand}' : '',
          style: const TextStyle(decoration: TextDecoration.underline),
        ),
      ],
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),

            onTap: onDecrement,

            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Icon(Icons.remove, size: 18, color: Colors.black87),
            ),
          ),
          Container(width: 1, height: 20, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: 24,
              child: Text(
                '$quantity',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(width: 1, height: 20, color: Colors.grey[300]),

          InkWell(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),

            onTap: onIncrement,

            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Icon(Icons.add, size: 18, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({super.key, required this.screen});

  final ProductDetailScreen screen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          screen.product.description,
          style: const TextStyle(height: 1.5, color: Colors.black87),
        ),
        const SizedBox(height: 150),
      ],
    );
  }
}

class _CheckoutBottomBar extends StatelessWidget {
  const _CheckoutBottomBar({
    super.key,
    required this.screen,
    required this.quantity,
  });

  final ProductDetailScreen screen;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  Text(
                    '\$${(screen.product.price * quantity).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6A87C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),

                onPressed: () {
                  context.read<CartProvider>().addItem(
                    CartItem(product: screen.product, quantity: quantity),
                  );
                },

                child: const Text(
                  'Add to cart',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
