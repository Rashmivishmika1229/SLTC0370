import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  Future<void> placeOrder({

    required String orderId,

    required List<Map<String, dynamic>>
        products,

    required String paymentMethod,

    required double total,

    required String customerName,

    required String address,
  }) async {

    final user = auth.currentUser;

    if (user == null) return;

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("orders")
        .add({

      "orderId": orderId,

      "products": products,

      "paymentMethod":
          paymentMethod,

      "total": total,

      "customerName":
          customerName,

      "address": address,

      "createdAt":
          Timestamp.now(),
    });
  }

  Stream<QuerySnapshot>
      getOrders() {

    final user =
        auth.currentUser;

    return firestore
        .collection("users")
        .doc(user!.uid)
        .collection("orders")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }
}