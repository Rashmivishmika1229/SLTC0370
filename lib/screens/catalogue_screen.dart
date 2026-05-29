import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/firestore_service.dart';
import '../services/cart_service.dart';
import '../services/wishlist_service.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';
import 'productdetails_screen.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  bool showDrawer = false;

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(243, 0, 0, 0),

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
            child: Container(color: Colors.black.withOpacity(0.8)),
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
                  "FEATURED PRODUCTS",

                  style: TextStyle(
                    fontFamily: "OpenSansHebrew",

                    color: Color(0xFFE8789D),

                    fontWeight: FontWeight.w800,

                    fontSize: 22,

                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 10),

                /// PRODUCTS
                Expanded(
                  child: StreamBuilder<List<ProductModel>>(
                    stream: firestoreService.getProducts(),

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Products Found",

                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final products = snapshot.data!;

                      return GridView.builder(
                        padding: const EdgeInsets.all(12),

                        itemCount: products.length,

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: width < 400 ? 1 : 2,

                          mainAxisSpacing: 12,

                          crossAxisSpacing: 12,

                          childAspectRatio: width < 400 ? 0.72 : 0.55,
                        ),

                        itemBuilder: (_, index) {
                          final product = products[index];

                          return ProductTile(product: product);
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

class ProductTile extends StatefulWidget {
  final ProductModel product;

  const ProductTile({super.key, required this.product});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final CartService cartService = CartService();

  final WishlistService wishlistService = WishlistService();

  int qty = 1;

  String selectedSize = "S";

  bool isFav = false;

  @override
  void initState() {
    super.initState();

    checkWishlist();
  }

  Future<void> checkWishlist() async {
    final items = await wishlistService.getWishlistItems().first;

    for (var doc in items.docs) {
      if (doc['productId'] == widget.product.id) {
        setState(() {
          isFav = true;
        });

        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double scale(num size) => size.toDouble() * (width / 375);

    return InkWell(
      borderRadius: BorderRadius.circular(22),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: widget.product),
          ),
        );
      },

      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),

          child: Container(
            padding: EdgeInsets.all(scale(10)),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),

              borderRadius: BorderRadius.circular(22),

              border: Border.all(color: Colors.white24),
            ),

            child: Stack(
              children: [
               
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    /// PRODUCT IMAGE
                    AspectRatio(
                      aspectRatio: 0.8,

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),

                        child: Image.network(
                          widget.product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: scale(6)),

                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          /// LEFT SIDE
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  widget.product.name,

                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    fontSize: scale(8),
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(height: scale(4)),

                                Text(
                                  "LKR ${widget.product.price}",

                                  style: TextStyle(
                                    fontSize: scale(8),
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                /// QUANTITY
                                Row(
                                  children: [
                                    _qtyBtn("-", () {
                                      if (qty > 1) {
                                        setState(() {
                                          qty--;
                                        });
                                      }
                                    }, scale),

                                    SizedBox(width: scale(6)),

                                    Text(
                                      "$qty",

                                      style: TextStyle(
                                        fontSize: scale(8),
                                        color: Colors.white,
                                      ),
                                    ),

                                    SizedBox(width: scale(6)),

                                    _qtyBtn("+", () {
                                      setState(() {
                                        qty++;
                                      });
                                    }, scale),
                                  ],
                                ),

                                SizedBox(height: scale(12)),

                                /// ADD TO CART
                                GestureDetector(
                                  onTap: () async {
                                    await cartService.addToCart(
                                      product: widget.product,

                                      quantity: qty,

                                      size: selectedSize,
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Added to cart"),
                                      ),
                                    );
                                  },

                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: scale(5),

                                      horizontal: scale(12),
                                    ),

                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8789D),

                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: Text(
                                      "Add to cart",

                                      style: TextStyle(
                                        color: Colors.white,

                                        fontSize: scale(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// SIZES
                          Column(
                            children: [
                              Text(
                                "Size",

                                style: TextStyle(
                                  fontSize: scale(9),
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: scale(4)),

                              ...["S", "M", "L"].map((size) {
                                bool selected = selectedSize == size;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = size;
                                    });
                                  },

                                  child: Container(
                                    width: scale(24),

                                    height: scale(20),

                                    alignment: Alignment.center,

                                    margin: EdgeInsets.symmetric(
                                      vertical: scale(3),
                                    ),

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,

                                      border: Border.all(
                                        color: selected
                                            ? const Color(0xFFE8789D)
                                            : Colors.grey,
                                      ),
                                    ),

                                    child: Text(
                                      size,

                                      style: TextStyle(
                                        fontSize: scale(9),

                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// FAVORITE 
                Positioned(
                  top: 6,
                  right: 6,

                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        isFav = !isFav;
                      });

                      if (isFav) {
                        await wishlistService.addToWishlist(widget.product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to wishlist")),
                        );
                      } else {
                        await wishlistService.removeFromWishlist(
                          widget.product.id,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Removed from wishlist"),
                          ),
                        );
                      }
                    },

                    child: Icon(
                      Icons.favorite,

                      size: scale(16),

                      color: isFav ? const Color(0xFFE8789D) : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _qtyBtn(String text, VoidCallback onTap, double Function(num) scale) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: scale(24),

        height: scale(20),

        alignment: Alignment.center,

        decoration: const BoxDecoration(
          shape: BoxShape.circle,

          color: Color(0xFFE8789D),
        ),

        child: Text(
          text,

          style: const TextStyle(
            fontWeight: FontWeight.bold,

            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
