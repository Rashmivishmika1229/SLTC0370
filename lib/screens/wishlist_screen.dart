import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/product_model.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';
import 'productdetails_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool showDrawer = false;

  final CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double s(double value) => value * (width / 375);

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/bg2.jpg", fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),

              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.82)),
          ),

          SafeArea(
            child: Column(
              children: [
                TopBar(
                  onMenuTap: () {
                    setState(() {
                      showDrawer = true;
                    });
                  },
                ),

                const SizedBox(height: 10),

                const Text(
                  "WISH LIST",

                  style: TextStyle(
                    color: Color(0xFFE8789D),

                    fontWeight: FontWeight.w800,

                    fontSize: 18,

                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 18),

                /// ITEMS
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .collection('wishlist')
                        .snapshots(),

                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            "Wishlist is Empty",

                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final items = snapshot.data!.docs;

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: s(14)),

                        itemCount: items.length,

                        itemBuilder: (context, index) {
                          final item = items[index];

                          ProductModel product = ProductModel(
                            id: item['productId'],

                            name: item['name'],

                            image: item['image'],

                            price: (item['price']).toDouble(),

                            description: item['description'] ?? '',

                            category: item['category'] ?? '',
                          );

                          return Container(
                            margin: EdgeInsets.only(bottom: s(14)),

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),

                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 12,
                                  sigmaY: 12,
                                ),

                                child: Container(
                                  padding: EdgeInsets.all(s(10)),

                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),

                                    borderRadius: BorderRadius.circular(22),

                                    border: Border.all(color: Colors.white24),
                                  ),

                                  child: Row(
                                    children: [
                                      /// IMAGE
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,

                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProductDetailsScreen(
                                                    product: product,
                                                  ),
                                            ),
                                          );
                                        },

                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),

                                          child: Image.network(
                                            item['image'],

                                            width: s(82),

                                            height: s(96),

                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: s(12)),

                                      /// DETAILS
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              item['name'],

                                              style: TextStyle(
                                                color: Colors.white,

                                                fontWeight: FontWeight.bold,

                                                fontSize: s(12),
                                              ),
                                            ),

                                            SizedBox(height: s(6)),

                                            Text(
                                              "LKR ${item['price']}",

                                              style: TextStyle(
                                                color: Colors.white70,

                                                fontSize: s(10),
                                              ),
                                            ),

                                            SizedBox(height: s(14)),

                                            /// ADD TO CART
                                            Material(
                                              color: Colors.transparent,

                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),

                                                onTap: () async {
                                                  await cartService.addToCart(
                                                    product: product,

                                                    quantity: 1,

                                                    size: "M",
                                                  );

                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Added to cart",
                                                      ),
                                                    ),
                                                  );
                                                },

                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: s(12),

                                                    vertical: s(8),
                                                  ),

                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0xFFE8789D,
                                                    ),

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),

                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,

                                                    children: [
                                                      Text(
                                                        "Add to cart",

                                                        style: TextStyle(
                                                          color: Colors.white,

                                                          fontSize: s(10),
                                                        ),
                                                      ),

                                                      SizedBox(width: s(6)),

                                                      Icon(
                                                        Icons.shopping_cart,

                                                        size: s(13),

                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Column(
                                        children: [
                                          Material(
                                            color: Colors.transparent,

                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(30),

                                              onTap: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.uid)
                                                    .collection('wishlist')
                                                    .doc(item.id)
                                                    .delete();
                                              },

                                              child: Padding(
                                                padding: EdgeInsets.all(s(4)),

                                                child: Icon(
                                                  Icons.favorite,

                                                  color: const Color(
                                                    0xFFE8789D,
                                                  ),

                                                  size: s(20),
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: s(14)),

                                          Material(
                                            color: Colors.transparent,

                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(30),

                                              onTap: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.uid)
                                                    .collection('wishlist')
                                                    .doc(item.id)
                                                    .delete();
                                              },

                                              child: Padding(
                                                padding: EdgeInsets.all(s(4)),

                                                child: Icon(
                                                  Icons.delete_outline,

                                                  color: Colors.white,

                                                  size: s(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          if (showDrawer)
            GestureDetector(
              onTap: () {
                setState(() {
                  showDrawer = false;
                });
              },

              child: Container(color: Colors.black.withOpacity(0.3)),
            ),

          /// DRAWER
          if (showDrawer) CategoryDrawer(isOpen: showDrawer),
        ],
      ),
    );
  }
}
