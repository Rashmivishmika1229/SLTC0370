import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/category_drawer.dart';
import 'checkout_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  String selectedSize = 'S';

  bool isFavorite = false;

  bool addedToCart = false;

  bool showDrawer = false;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    checkFavorite();
  }

  Future<void> checkFavorite() async {
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('wishlist')
        .where('productId', isEqualTo: widget.product.id)
        .get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        isFavorite = true;
      });
    }
  }

  Future<void> toggleWishlist() async {
    if (user == null) return;

    final wishlist = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('wishlist');

    final existing = await wishlist
        .where('productId', isEqualTo: widget.product.id)
        .get();

    if (existing.docs.isNotEmpty) {
      await existing.docs.first.reference.delete();

      setState(() {
        isFavorite = false;
      });
    } else {
      await wishlist.add({
        'productId': widget.product.id,

        'name': widget.product.name,

        'price': widget.product.price,

        'image': widget.product.image,

        'description': widget.product.description,

        'category': widget.product.category,
      });

      setState(() {
        isFavorite = true;
      });
    }
  }

  Future<void> addToCart() async {
    if (user == null) return;

    final cart = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart');

    await cart.add({
      'productId': widget.product.id,

      'name': widget.product.name,

      'price': widget.product.price,

      'image': widget.product.image,

      'quantity': quantity,

      'size': selectedSize,
    });

    setState(() {
      addedToCart = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height;

    double s(double value) => value * (width / 375);

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,

                    padding: EdgeInsets.symmetric(
                      horizontal: s(20),

                      vertical: s(20),
                    ),

                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFD88EA8), Color(0xFFCC8BA1)],

                        begin: Alignment.topLeft,

                        end: Alignment.bottomRight,
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            /// BACK BUTTON
                            Material(
                              color: Colors.transparent,

                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),

                                onTap: () {
                                  Navigator.pop(context);
                                },

                                child: Padding(
                                  padding: EdgeInsets.all(s(6)),

                                  child: Icon(
                                    Icons.arrow_back_ios_new,

                                    color: Colors.white,

                                    size: s(18),
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                /// NOTIFICATION
                                CircleAvatar(
                                  radius: s(15),

                                  backgroundColor: Colors.white,

                                  child: Icon(
                                    Icons.notifications_none,

                                    color: const Color(0xFFD86B97),

                                    size: s(15),
                                  ),
                                ),

                                SizedBox(width: s(10)),

                                /// MENU
                                Material(
                                  color: Colors.transparent,

                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),

                                    onTap: () {
                                      setState(() {
                                        showDrawer = true;
                                      });
                                    },

                                    child: CircleAvatar(
                                      radius: s(15),

                                      backgroundColor: Colors.white,

                                      child: Icon(
                                        Icons.menu,

                                        color: const Color(0xFFD86B97),

                                        size: s(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: s(22)),

                        /// PRODUCT
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),

                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

                            child: Container(
                              padding: EdgeInsets.all(s(16)),

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),

                                borderRadius: BorderRadius.circular(28),

                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Container(
                                    width: double.infinity,

                                    height: height * 0.60,

                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(24),
                                    ),

                                    child: Padding(
                                      padding: EdgeInsets.all(s(16)),

                                      child: Image.network(
                                        widget.product.image,

                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: s(24)),

                                  Text(
                                    widget.product.name,

                                    style: TextStyle(
                                      color: Colors.white,

                                      fontSize: s(18),

                                      fontWeight: FontWeight.bold,

                                      height: 1.5,
                                    ),
                                  ),

                                  SizedBox(height: s(10)),

                                  Text(
                                    'LKR ${widget.product.price}',

                                    style: TextStyle(
                                      color: Colors.white70,

                                      fontSize: s(13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// DETAILS
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: s(22),

                      vertical: s(26),
                    ),

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                GestureDetector(
                                  onTap: toggleWishlist,

                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,

                                    color: const Color(0xFFD86B97),

                                    size: s(24),
                                  ),
                                ),

                                SizedBox(height: s(28)),

                                Text(
                                  'Size',

                                  style: TextStyle(
                                    color: Colors.white,

                                    fontSize: s(15),
                                  ),
                                ),

                                SizedBox(height: s(18)),

                                Row(
                                  children: [
                                    sizeButton('S'),

                                    SizedBox(width: s(14)),

                                    sizeButton('M'),

                                    SizedBox(width: s(14)),

                                    sizeButton('L'),
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              children: [
                                SizedBox(height: s(54)),

                                Text(
                                  'Quantity',

                                  style: TextStyle(
                                    color: Colors.white,

                                    fontSize: s(15),
                                  ),
                                ),

                                SizedBox(height: s(18)),

                                Row(
                                  children: [
                                    quantityButton(Icons.remove, () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    }),

                                    SizedBox(width: s(18)),

                                    Text(
                                      quantity.toString(),

                                      style: TextStyle(
                                        color: Colors.white,

                                        fontSize: s(18),
                                      ),
                                    ),

                                    SizedBox(width: s(18)),

                                    quantityButton(Icons.add, () {
                                      setState(() {
                                        quantity++;
                                      });
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: s(42)),

                        Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            'Product Description',

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: s(18),

                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(height: s(18)),

                        Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            widget.product.description,

                            style: TextStyle(
                              color: Colors.white70,

                              fontSize: s(13),

                              height: 2.3,
                            ),
                          ),
                        ),

                        SizedBox(height: s(48)),

                        Row(
                          children: [
                            Expanded(
                              child: actionButton(
                                'ADD TO CART',

                                addToCart,

                                filled: addedToCart,
                              ),
                            ),

                            SizedBox(width: s(18)),

                            Expanded(
                              child: actionButton('BUY NOW', () {
                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (_) => CheckoutScreen(
                                      orderedProducts: [
                                        {
                                          "productId": widget.product.id,

                                          "name": widget.product.name,

                                          "image": widget.product.image,

                                          "price": widget.product.price,

                                          "qty": quantity,

                                          "size": selectedSize,
                                        },
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

          /// CATEGORY DRAWER
          if (showDrawer) CategoryDrawer(isOpen: showDrawer),
        ],
      ),
    );
  }

  Widget sizeButton(String size) {
    final selected = selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },

      child: Container(
        width: 44,

        height: 44,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          border: Border.all(
            color: selected ? const Color(0xFFD86B97) : Colors.white,

            width: 1.8,
          ),
        ),

        child: Center(
          child: Text(
            size,

            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget quantityButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(30),

        onTap: onTap,

        child: Container(
          width: 44,

          height: 44,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            border: Border.all(color: const Color(0xFFD86B97), width: 1.8),
          ),

          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget actionButton(String text, VoidCallback onTap, {bool filled = false}) {
    return Material(
      color: Colors.transparent,

      borderRadius: BorderRadius.circular(18),

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(18),

        splashColor: Colors.white.withOpacity(0.15),

        highlightColor: Colors.white.withOpacity(0.05),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),

          height: 48,

          decoration: BoxDecoration(
            color: filled ? const Color(0xFFD86B97) : Colors.transparent,

            borderRadius: BorderRadius.circular(18),

            border: Border.all(color: const Color(0xFFD86B97)),
          ),

          child: Center(
            child: Text(
              text,

              style: TextStyle(
                color: filled ? Colors.white : const Color(0xFFD86B97),

                fontWeight: FontWeight.bold,

                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
