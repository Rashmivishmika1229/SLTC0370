import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/order_service.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final OrderService orderService = OrderService();

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
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),

              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.72)),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: s(16),
                    vertical: s(10),
                  ),

                  child: Row(
                    children: [
                      Material(
                        color: Colors.white.withOpacity(0.08),

                        borderRadius: BorderRadius.circular(14),

                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),

                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: Padding(
                            padding: EdgeInsets.all(s(10)),

                            child: Icon(
                              Icons.arrow_back_ios_new,

                              color: Colors.white,

                              size: s(18),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            "MY ORDERS",

                            style: TextStyle(
                              color: const Color(0xFFE8789D),

                              fontSize: s(20),

                              fontWeight: FontWeight.bold,

                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: s(38)),
                    ],
                  ),
                ),

                SizedBox(height: s(10)),

                /// ORDERS
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: orderService.getOrders(),

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Orders Yet",

                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final orders = snapshot.data!.docs;

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: s(16)),

                        itemCount: orders.length,

                        itemBuilder: (context, index) {
                          final order = orders[index];

                          final data = order.data() as Map<String, dynamic>;

                          return _orderTile(data, s);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderTile(Map<String, dynamic> order, double Function(num) s) {
    final List products = order["products"] ?? [];

    return Container(
      margin: EdgeInsets.only(bottom: s(18)),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

          child: Container(
            padding: EdgeInsets.all(s(16)),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),

              borderRadius: BorderRadius.circular(28),

              border: Border.all(color: Colors.white12),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      order["orderId"] ?? "",

                      style: TextStyle(
                        color: const Color(0xFFE8789D),

                        fontWeight: FontWeight.bold,

                        fontSize: s(13),

                        letterSpacing: 1.2,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: s(10),

                        vertical: s(5),
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),

                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: Text(
                        order["paymentMethod"] ?? "",

                        style: TextStyle(color: Colors.white, fontSize: s(9)),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: s(14)),

                /// PRODUCTS
                SizedBox(
                  height: s(74),

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: products.length,

                    itemBuilder: (context, index) {
                      final product = products[index];

                      return Container(
                        width: s(64),

                        margin: EdgeInsets.only(right: s(10)),

                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),

                                child:
                                    product["image"].toString().startsWith(
                                      "http",
                                    )
                                    ? Image.network(
                                        product["image"],

                                        fit: BoxFit.cover,

                                        width: double.infinity,
                                      )
                                    : Image.asset(
                                        product["image"],

                                        fit: BoxFit.cover,

                                        width: double.infinity,
                                      ),
                              ),
                            ),

                            SizedBox(height: s(4)),

                            Text(
                              product["name"] ?? "",

                              maxLines: 1,

                              overflow: TextOverflow.ellipsis,

                              style: TextStyle(
                                color: Colors.white70,

                                fontSize: s(8),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: s(16)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "ORDER PLACED",

                          style: TextStyle(
                            color: Colors.white54,

                            fontSize: s(8),

                            letterSpacing: 1.2,
                          ),
                        ),

                        SizedBox(height: s(4)),

                        Text(
                          order["createdAt"] != null
                              ? (order["createdAt"] as Timestamp)
                                    .toDate()
                                    .toString()
                                    .split(" ")[0]
                              : "",

                          style: TextStyle(
                            color: Colors.white,

                            fontSize: s(10),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Text(
                          "TOTAL",

                          style: TextStyle(
                            color: Colors.white54,

                            fontSize: s(8),

                            letterSpacing: 1.2,
                          ),
                        ),

                        SizedBox(height: s(4)),

                        Text(
                          "LKR ${order["total"]}",

                          style: TextStyle(
                            color: const Color(0xFFE8789D),

                            fontSize: s(12),

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
