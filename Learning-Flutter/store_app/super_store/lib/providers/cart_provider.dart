import 'package:flutter/material.dart';
import 'package:super_store/models/cart_item.dart';
import 'package:super_store/models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  void addItem(CartItem cartItem) {
    for (var item in _cartItems) {
      // Already exists items
      if (cartItem.product.id == item.product.id) {
        // I will stop the user from adding more than the current stock in the `cart_screen`.
        item.quantity += cartItem.quantity;
        notifyListeners();
        // I added a print statment to help me debug, but I feel there must be away to debug bette?
        print('added a new Item');

        return;
      }
    }

    _cartItems.add(cartItem);
    notifyListeners();
    print('added a new Item');
  }

  void removeItem(Product product) {
    for (var item in _cartItems) {
      if (product.id == item.product.id) {
        // Question: here I did not guard the negative, as the `cart_screen` UI will not allow that, is that correct? Or should I always have the logic even if never used?
        if (item.quantity == 1) {
          _cartItems.remove(item);
        } else {
          item.quantity -= 1;
        }
        notifyListeners();
        print('removed an Item');

        return;
      }
    }
  }
}
