import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product_model.dart';

class WishlistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ADD TO WISHLIST
  Future<void> addToWishlist(ProductModel product) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('wishlist')
        .doc(product.id)
        .set({
          'name': product.name,
          'image': product.image,
          'price': product.price,
          'productId': product.id,

          'description': product.description,

          'category': product.category,
        });
  }

  /// REMOVE FROM WISHLIST
  Future<void> removeFromWishlist(String productId) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('wishlist')
        .doc(productId)
        .delete();
  }

  /// GET WISHLIST ITEMS
  Stream<QuerySnapshot> getWishlistItems() {
    final user = _auth.currentUser;

    return _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('wishlist')
        .snapshots();
  }
}
