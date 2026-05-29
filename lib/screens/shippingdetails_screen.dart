import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  final nameCtrl = TextEditingController();

  final phoneCtrl = TextEditingController();

  final addressCtrl = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadAddress();
  }

  Future<void> loadAddress() async {
    final user = auth.currentUser;

    if (user == null) return;

    final doc = await firestore
        .collection("users")
        .doc(user.uid)
        .collection("shipping_address")
        .doc("default")
        .get();

    if (doc.exists) {
      final data = doc.data()!;

      nameCtrl.text = data["name"] ?? "";

      phoneCtrl.text = data["phone"] ?? "";

      addressCtrl.text = data["address"] ?? "";
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> saveAddress() async {
    final user = auth.currentUser;

    if (user == null) return;

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("shipping_address")
        .doc("default")
        .set({
          "name": nameCtrl.text.trim(),

          "phone": phoneCtrl.text.trim(),

          "address": addressCtrl.text.trim(),

          "updatedAt": Timestamp.now(),
        });

    showDialog(
      context: context,

      barrierColor: Colors.black.withOpacity(0.45),

      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),

            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

              child: Container(
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),

                  borderRadius: BorderRadius.circular(30),

                  border: Border.all(color: Colors.white12),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const Icon(
                      Icons.check_circle,

                      color: Color(0xFFE8789D),

                      size: 70,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "ADDRESS UPDATED",

                      style: TextStyle(
                        color: Colors.white,

                        fontSize: 18,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Your shipping details were saved successfully.",

                      textAlign: TextAlign.center,

                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 22),

                    Material(
                      color: const Color(0xFFE8789D),

                      borderRadius: BorderRadius.circular(18),

                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),

                        onTap: () {
                          Navigator.pop(context);
                        },

                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,

                            vertical: 10,
                          ),

                          child: Text(
                            "DONE",

                            style: TextStyle(
                              color: Colors.white,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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

          if (loading)
            const Center(child: CircularProgressIndicator())
          else
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(s(16)),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    /// TOP BAR
                    Row(
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
                              "SHIPPING ADDRESS",

                              style: TextStyle(
                                color: const Color(0xFFE8789D),

                                fontSize: s(18),

                                fontWeight: FontWeight.bold,

                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: s(38)),
                      ],
                    ),

                    SizedBox(height: s(28)),

                    /// FORM
                    _label("FULL NAME", s),

                    _field(controller: nameCtrl, s: s),

                    SizedBox(height: s(18)),

                    _label("CONTACT NUMBER", s),

                    _field(
                      controller: phoneCtrl,
                      s: s,
                      keyboard: TextInputType.phone,
                    ),

                    SizedBox(height: s(18)),

                    _label("DELIVERY ADDRESS", s),

                    _field(controller: addressCtrl, s: s, maxLines: 5),

                    SizedBox(height: s(40)),

                    /// SAVE
                    Material(
                      color: const Color(0xFFE8789D),

                      borderRadius: BorderRadius.circular(24),

                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),

                        splashColor: Colors.white.withOpacity(0.2),

                        onTap: saveAddress,

                        child: Container(
                          width: double.infinity,

                          padding: EdgeInsets.symmetric(vertical: s(15)),

                          alignment: Alignment.center,

                          child: Text(
                            "SAVE ADDRESS",

                            style: TextStyle(
                              color: Colors.white,

                              fontWeight: FontWeight.bold,

                              fontSize: s(12),

                              letterSpacing: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _label(String text, double Function(num) s) {
    return Padding(
      padding: EdgeInsets.only(bottom: s(8)),

      child: Text(
        text,

        style: TextStyle(
          color: const Color(0xFFE8789D),

          fontWeight: FontWeight.bold,

          fontSize: s(11),

          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required double Function(num) s,

    int maxLines = 1,

    TextInputType? keyboard,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: s(16)),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),

            borderRadius: BorderRadius.circular(22),

            border: Border.all(color: Colors.white12),
          ),

          child: TextField(
            controller: controller,

            maxLines: maxLines,

            keyboardType: keyboard,

            style: const TextStyle(color: Colors.white),

            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
