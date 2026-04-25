import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';
import 'checkout_screen.dart';
import 'dart:ui';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool showDrawer = false;

  List<int> products = List.generate(3, (index) => index);

  List<bool> selected = [true, true, true];
  List<int> qty = [1, 1, 1];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double size) => size * (width / 375);

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopBar(onMenuTap: () => setState(() => showDrawer = true)),

                  const SizedBox(height: 10),

                  const Text(
                    "CART",
                    style: TextStyle(
                      fontFamily: "OpenSansHebrew",
                      color: Color(0xFFE8789D),
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return _cartTile(scale, index);
                    },
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.all(scale(10)),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SHIPPING FEE",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "LKR 500.00",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: scale(12)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Material(
                      color: const Color(0xFFE8789D),
                      borderRadius: BorderRadius.circular(25),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        splashColor: Colors.white.withOpacity(0.3),
                        highlightColor: Colors.white.withOpacity(0.1),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CheckoutScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: scale(14)),
                          alignment: Alignment.center,
                          child: Text(
                            "PROCEED TO CHECKOUT   LKR 19,600.00",
                            style: TextStyle(
                              fontFamily: "OpenSansHebrew",
                              color: Colors.white,
                              fontSize: scale(12),
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          if (showDrawer)
            GestureDetector(
              onTap: () => setState(() => showDrawer = false),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),

          if (showDrawer)
  CategoryDrawer(isOpen: showDrawer),
        ],
      ),
    );
  }

  Widget _cartTile(Function scale, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: scale(12)),
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
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected[index] = !selected[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: scale(10)),
                    width: scale(18),
                    height: scale(18),
                    decoration: BoxDecoration(
                      color: selected[index]
                          ? const Color(0xFFE8789D)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white),
                    ),
                    child: selected[index]
                        ? Icon(
                            Icons.check,
                            size: scale(12),
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/bella2.png",
                    width: scale(80),
                    height: scale(100),
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: scale(12)),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BELLA SUMMER DRESS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: scale(10),
                          fontFamily: "OpenSansHebrew",
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: scale(5)),

                      Text(
                        "Size  S",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: scale(10),
                        ),
                      ),

                      SizedBox(height: scale(10)),

                      Row(
                        children: [
                          _qtyBtn("-", scale, () {
                            if (qty[index] > 1) {
                              setState(() => qty[index]--);
                            }
                          }),

                          SizedBox(width: scale(6)),

                          Text(
                            "${qty[index]}",
                            style: const TextStyle(color: Colors.white),
                          ),

                          SizedBox(width: scale(6)),

                          _qtyBtn("+", scale, () {
                            setState(() => qty[index]++);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: scale(20),
                      ),
                    ),

                    SizedBox(height: scale(40)),

                    Text(
                      "LKR 4800.00",
                      style: TextStyle(
                        fontFamily: "OpenSansHebrew",
                        color: Colors.white,
                        fontSize: scale(10),
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

  Widget _qtyBtn(String text, Function scale, VoidCallback onTap) {
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
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
