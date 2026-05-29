import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirestoreService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProducts() {

    return _firestore
        .collection('products')
        .snapshots()

        .handleError((error) {

      print(
          "FIRESTORE ERROR: $error");
    })

        .map((snapshot) {

      List<ProductModel> products = [];

      for (var doc in snapshot.docs) {

        try {

          final data =
              doc.data();

          products.add(

            ProductModel.fromMap(
              doc.id,
              data,
            ),
          );

        } catch (e) {

          print(
              "PRODUCT PARSE ERROR: $e");

          print(
              "BROKEN DOC: ${doc.data()}");
        }
      }

      return products;
    });
  }
}