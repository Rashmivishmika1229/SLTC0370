import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';
import 'productdetails_screen.dart';
import 'dart:ui';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool showDrawer = false;

  List<int> products = List.generate(6, (index) => index);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double size) => size * (width / 375);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),

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
                TopBar(onMenuTap: () => setState(() => showDrawer = true)),

                const SizedBox(height: 10),

                const Text(
                  "WISH LIST",
                  style: TextStyle(
                    fontFamily: "OpenSansHebrew",
                    color: Color(0xFFE8789D),
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 15),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return WishlistTile(scale: scale);
                    },
                  ),
                ),
              ],
            ),
          ),

          if (showDrawer)
            GestureDetector(
              onTap: () => setState(() => showDrawer = false),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),

          if (showDrawer) CategoryDrawer(isOpen: showDrawer),
        ],
      ),
    );
  }
}

class WishlistTile extends StatefulWidget {
  final Function scale;

  const WishlistTile({super.key, required this.scale});

  @override
  State<WishlistTile> createState() => _WishlistTileState();
}

class _WishlistTileState extends State<WishlistTile> {
  bool isFav = true;

  @override
  Widget build(BuildContext context) {
    final s = widget.scale;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProductDetailsScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: s(12)),

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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/images/bella2.png",
                      width: s(80),
                      height: s(90),
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: s(10)),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BELLA SUMMER DRESS",
                          style: TextStyle(
                            fontFamily: "OpenSansHebrew",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: s(4)),

                        Text(
                          "LKR 4800.00",
                          style: TextStyle(
                            fontFamily: "OpenSansHebrew",
                            fontSize: 10,
                            color: Colors.white70,
                          ),
                        ),

                        SizedBox(height: s(10)),

                        Material(
                          color: const Color(0xFFE8789D),
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "Successfully added to cart",
                                    style: TextStyle(
                                      fontFamily: "OpenSansHebrew",
                                    ),
                                  ),
                                  backgroundColor: Color.fromARGB(
                                    200,
                                    232,
                                    120,
                                    157,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: s(6),
                                horizontal: s(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
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
                                    size: s(14),
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
                      GestureDetector(
                        onTap: () {
                          setState(() => isFav = !isFav);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: isFav ? const Color(0xFFE8789D) : Colors.grey,
                          size: s(20),
                        ),
                      ),

                      SizedBox(height: s(12)),

                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: s(20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
