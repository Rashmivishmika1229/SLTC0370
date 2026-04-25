import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedSize = "S";
  int qty = 1;
  bool isFav = false;
  String selectedAction = "";
  bool showDrawer = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    double topHeight = height * 0.35;
    if (topHeight < 260) topHeight = 260;
    if (topHeight > 380) topHeight = 380;

    double scale(double size) => size * (width / 375);

    return Scaffold(
      backgroundColor: const Color.fromARGB(243, 0, 0, 0),

      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: topHeight,
                      decoration: BoxDecoration(color: Color(0xFFD78397)),
                    ),

                    SafeArea(
                      child: TopBar(
                        onMenuTap: () {
                          setState(() => showDrawer = true);
                        },
                      ),
                    ),

                    Positioned(
                      top: height * 0.15,
                      left: scale(35),
                      right: width * 0.50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lily Summer\nDress",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: scale(22),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: scale(8)),
                          Text(
                            "LKR 10,500.00",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: scale(12),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      right: scale(10),
                      top: height * 0.08,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: width * 0.5),
                        child: Image.asset(
                          'assets/images/data1.png',
                          height: height * 0.40,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: scale(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scale(20)),

                      InkWell(
                        onTap: () {
                          setState(() => isFav = !isFav);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: isFav ? const Color(0xFFD78397) : Colors.grey,
                        ),
                      ),

                      SizedBox(height: scale(20)),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// SIZE
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: scale(20),
                                child: const Text(
                                  "Size",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "OpenSansHebrew",
                                  ),
                                ),
                              ),

                              SizedBox(height: scale(10)),

                              Row(
                                children: ["S", "M", "L"].map((size) {
                                  bool selected = selectedSize == size;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() => selectedSize = size);
                                    },
                                    child: Container(
                                      width: scale(28),
                                      height: scale(28),
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(right: scale(10)),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: selected
                                              ? const Color(0xFFD78397)
                                              : Colors.grey.shade300,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        size,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              SizedBox(height: scale(6)),

                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Size chart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: scale(20),
                                child: const Text(
                                  "Quantity",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "OpenSansHebrew",
                                  ),
                                ),
                              ),

                              SizedBox(height: scale(10)),

                              Row(
                                children: [
                                  _qtyBtn("-", () {
                                    if (qty > 1) setState(() => qty--);
                                  }),

                                  SizedBox(width: scale(10)),

                                  Text(
                                    "$qty",
                                    style: const TextStyle(color: Colors.white),
                                  ),

                                  SizedBox(width: scale(10)),

                                  _qtyBtn("+", () {
                                    setState(() => qty++);
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: scale(30)),

                      const Text(
                        "Product Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "OpenSansHebrew",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        "• Premium lightweight chiffon blend",
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        "• Flowy A-line maxi length",
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        "• Adjustable shoulder straps",
                        style: TextStyle(color: Colors.white),
                      ),

                      SizedBox(height: scale(30)),

                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() => selectedAction = "cart");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: scale(14),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedAction == "cart"
                                      ? const Color(0xFFD78397)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFD78397),
                                  ),
                                ),
                                child: Text(
                                  "ADD TO CART",
                                  style: TextStyle(
                                    fontFamily: "OpenSansHebrew",
                                    fontWeight: FontWeight.w800,
                                    color: selectedAction == "cart"
                                        ? Colors.white
                                        : const Color(0xFFD78397),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: scale(16)),

                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() => selectedAction = "buy");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: scale(14),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedAction == "buy"
                                      ? const Color(0xFFD78397)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFD78397),
                                  ),
                                ),
                                child: Text(
                                  "BUY NOW",
                                  style: TextStyle(
                                    fontFamily: "OpenSansHebrew",
                                    fontWeight: FontWeight.w800,
                                    color: selectedAction == "buy"
                                        ? Colors.white
                                        : const Color(0xFFD78397),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: scale(40)),
                    ],
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

  Widget _qtyBtn(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFD78397)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: "OpenSansHebrew",
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
