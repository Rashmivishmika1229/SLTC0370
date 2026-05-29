import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product_model.dart';

class CartService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// ADD TO CART
  Future<void> addToCart({
    required ProductModel product,
    required int quantity,
    required String size,
  }) async {

    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(product.id)
        .set({

      'name': product.name,

      'image': product.image,

      'price': product.price,

      'quantity': quantity,

      'size': size,

      'productId': product.id,

      'createdAt': Timestamp.now(),
    });
  }

  /// GET CART ITEMS
  Stream<QuerySnapshot> getCartItems() {
    final user = _auth.currentUser;

    return _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('cart')
        .snapshots();
  }

  /// REMOVE ITEM
  Future<void> removeFromCart(
      String productId) async {

    final user = _auth.currentUser;

    await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('cart')
        .doc(productId)
        .delete();
  }
}