import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';
import 'productdetails_screen.dart';
import 'dart:ui';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  bool showDrawer = false;
  final ScrollController _scrollController = ScrollController();

  List<int> products = List.generate(6, (index) => index);

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  void _loadMore() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        products.addAll(List.generate(6, (index) => products.length + index));
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                TopBar(onMenuTap: () => setState(() => showDrawer = true)),

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

                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width < 400 ? 1 : 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: width < 400 ? 0.72 : 0.55,
                    ),
                    itemBuilder: (_, __) => const ProductTile(),
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

class ProductTile extends StatefulWidget {
  const ProductTile({super.key});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  int qty = 1;
  String selectedSize = "S";
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double scale(double size) => size * (width / 375);

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProductDetailsScreen()),
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
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          "assets/images/bella2.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: scale(6)),

                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "BELLA SUMMER DRESS",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: scale(8),
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(height: scale(4)),
                                Text(
                                  "LKR 4800.00",
                                  style: TextStyle(
                                    fontSize: scale(8),
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    _qtyBtn("-", () {
                                      if (qty > 1) setState(() => qty--);
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
                                      setState(() => qty++);
                                    }, scale),
                                  ],
                                ),

                                SizedBox(height: scale(12)),

                                Container(
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
                              ],
                            ),
                          ),

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
                                  onTap: () =>
                                      setState(() => selectedSize = size),
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

                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => setState(() => isFav = !isFav),
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

  Widget _qtyBtn(String text, VoidCallback onTap, Function scale) {
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
