import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool showDrawer = false;

  final CartService cartService = CartService();

  final Set<String> selectedItems = {};

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double s(num value) => value.toDouble() * (width / 375);

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
                /// TOP BAR
                TopBar(
                  onMenuTap: () {
                    setState(() {
                      showDrawer = true;
                    });
                  },
                ),

                const SizedBox(height: 10),

               
                const Text(
                  "CART",

                  style: TextStyle(
                    color: Color(0xFFE8789D),

                    fontWeight: FontWeight.w800,

                    fontSize: 18,

                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 14),

                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: cartService.getCartItems(),

                    builder: (context, snapshot) {
                
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final cartItems = snapshot.data!.docs;

                      
                      if (cartItems.isEmpty) {
                        return const Center(
                          child: Text(
                            "Cart is Empty",

                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        );
                      }

                
                      double subtotal = 0;

                      for (var item in cartItems) {
                        if (selectedItems.contains(item.id)) {
                          subtotal +=
                              ((item['price'] ?? 0) as num).toDouble() *
                              ((item['quantity'] ?? 1) as num).toDouble();
                        }
                      }

                      double shipping = selectedItems.isEmpty ? 0 : 500;

                      double total = subtotal + shipping;

                      return ListView(
                        padding: const EdgeInsets.only(bottom: 24),

                        children: [
                       
                          ListView.builder(
                            shrinkWrap: true,

                            physics: const NeverScrollableScrollPhysics(),

                            padding: const EdgeInsets.symmetric(horizontal: 14),

                            itemCount: cartItems.length,

                            itemBuilder: (context, index) {
                              final item = cartItems[index];

                              return _cartTile(s, item);
                            },
                          ),

                          /// SHIPPING
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 14),

                            padding: EdgeInsets.all(s(12)),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),

                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                const Text(
                                  "SHIPPING FEE",

                                  style: TextStyle(color: Colors.white70),
                                ),

                                Text(
                                  "LKR ${shipping.toStringAsFixed(2)}",

                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: s(14)),

                          /// CHECKOUT 
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),

                            child: Material(
                              color: const Color(0xFFE8789D),

                              borderRadius: BorderRadius.circular(22),

                              child: InkWell(
                                borderRadius: BorderRadius.circular(22),

                                onTap: selectedItems.isEmpty
                                    ? null
                                    : () {
                                        final selectedProducts = cartItems
                                            .where(
                                              (item) => selectedItems.contains(
                                                item.id,
                                              ),
                                            )
                                            .map(
                                              (item) => {
                                                "name": item['name'],

                                                "image": item['image'],

                                                "price": item['price'],

                                                "qty": item['quantity'],

                                                "size": item['size'],
                                              },
                                            )
                                            .toList();

                                        Navigator.push(
                                          context,

                                          MaterialPageRoute(
                                            builder: (_) => CheckoutScreen(
                                              orderedProducts: selectedProducts,
                                            ),
                                          ),
                                        );
                                      },

                                child: Container(
                                  width: double.infinity,

                                  padding: EdgeInsets.symmetric(
                                    vertical: s(14),
                                  ),

                                  alignment: Alignment.center,

                                  child: Text(
                                    "CHECKOUT   LKR ${total.toStringAsFixed(2)}",

                                    style: TextStyle(
                                      color: Colors.white,

                                      fontSize: s(12),

                                      fontWeight: FontWeight.bold,

                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  Widget _cartTile(double Function(num) s, QueryDocumentSnapshot item) {
    bool selected = selectedItems.contains(item.id);

    return Container(
      margin: EdgeInsets.only(bottom: s(14)),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),

          child: Container(
            padding: EdgeInsets.all(s(10)),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),

              borderRadius: BorderRadius.circular(22),

              border: Border.all(color: Colors.white24),
            ),

            child: Row(
              children: [
                /// TICK
                Material(
                  color: Colors.transparent,

                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),

                    onTap: () {
                      setState(() {
                        if (selected) {
                          selectedItems.remove(item.id);
                        } else {
                          selectedItems.add(item.id);
                        }
                      });
                    },

                    child: Container(
                      width: s(22),

                      height: s(22),

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: selected
                            ? const Color(0xFFE8789D)
                            : Colors.transparent,

                        border: Border.all(color: const Color(0xFFE8789D)),
                      ),

                      child: selected
                          ? Icon(Icons.check, size: s(14), color: Colors.white)
                          : null,
                    ),
                  ),
                ),

                SizedBox(width: s(10)),

                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),

                  child: Image.network(
                    item['image'] ?? "",

                    width: s(70),

                    height: s(82),

                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: s(70),

                        height: s(82),

                        color: Colors.white10,

                        child: const Icon(
                          Icons.broken_image,

                          color: Colors.white54,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(width: s(12)),

                /// DETAILS
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        item['name'] ?? "",

                        style: TextStyle(
                          color: Colors.white,

                          fontSize: s(11),

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: s(6)),

                      Text(
                        "Size ${(item['size'] ?? 'M')}",

                        style: TextStyle(
                          color: Colors.white70,

                          fontSize: s(10),
                        ),
                      ),

                      SizedBox(height: s(10)),

                      Text(
                        "Quantity : ${(item['quantity'] ?? 1)}",

                        style: TextStyle(color: Colors.white, fontSize: s(10)),
                      ),
                    ],
                  ),
                ),

          
                Column(
                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                   
                    Material(
                      color: Colors.transparent,

                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),

                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('cart')
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

                    SizedBox(height: s(26)),

                    /// PRICE
                    Text(
                      "LKR ${(((item['price'] ?? 0) as num).toDouble() * ((item['quantity'] ?? 1) as num).toDouble()).toStringAsFixed(2)}",

                      style: TextStyle(
                        color: Colors.white,

                        fontSize: s(10),

                        fontWeight: FontWeight.bold,
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
  }
}
