import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool showDrawer = false;
  String paymentMethod = "card";

  final nameCtrl = TextEditingController(text: "");
  final addressCtrl = TextEditingController(text: "");
  final cardNameCtrl = TextEditingController(text: "");
  final cardNumberCtrl = TextEditingController();
  final expiryCtrl = TextEditingController();
  final cvcCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double size) => size * (width / 375);

    return Scaffold(
      backgroundColor: const Color.fromARGB(243, 0, 0, 0),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(scale(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(onMenuTap: () => setState(() => showDrawer = true)),

                  SizedBox(height: scale(12)),

                  Center(
                    child: Text(
                      "CHECKOUT",
                      style: TextStyle(
                        fontFamily: "OpenSansHebrew",
                        color: const Color(0xFFE8789D),
                        fontSize: scale(22),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  SizedBox(height: scale(24)),

                  _label("Name"),
                  _inputField(controller: nameCtrl, scale: scale),

                  SizedBox(height: scale(18)),

                  _label("Delivery Address"),
                  _inputField(
                    controller: addressCtrl,
                    scale: scale,
                    trailing: "Edit",
                    onTrailingTap: () {},
                  ),

                  SizedBox(height: scale(22)),

                  _label("Choose payment method"),

                  SizedBox(height: scale(8)),

                  Row(
                    children: [
                      _radio("Cash on delivery", "cash"),
                      SizedBox(width: scale(20)),
                      _radio("Card payment", "card"),
                    ],
                  ),

                  if (paymentMethod == "card") ...[
                    SizedBox(height: scale(18)),

                    _label("Name on the card"),
                    _inputField(controller: cardNameCtrl, scale: scale),

                    SizedBox(height: scale(18)),

                    _label("Card number"),
                    _inputField(
                      controller: cardNumberCtrl,
                      scale: scale,
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: scale(18)),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label("Expiration date"),
                              _inputField(
                                controller: expiryCtrl,
                                scale: scale,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                  FilteringTextInputFormatter.digitsOnly,
                                  _ExpiryDateFormatter(),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: scale(16)),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label("CVC"),
                              _inputField(
                                controller: cvcCtrl,
                                scale: scale,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],

                  SizedBox(height: scale(24)),

                  Text(
                    "ORDER SUMMARY",
                    style: TextStyle(
                      fontFamily: "OpenSansHebrew",
                      color: Colors.white,
                      fontSize: scale(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: scale(12)),

                  _glassBox(
                    scale: scale,
                    child: Column(
                      children: [
                        _row("Subtotal", "LKR 19,100.00"),
                        _row("Delivery", "LKR 500.00"),
                        const Divider(color: Colors.white24),
                        _row("Total", "LKR 19,600.00", bold: true),
                      ],
                    ),
                  ),

                  SizedBox(height: scale(24)),

                  Material(
                    color: const Color(0xFFE8789D),
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      splashColor: Colors.white.withOpacity(0.3),
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: scale(14)),
                        alignment: Alignment.center,
                        child: Text(
                          "MAKE PAYMENT   LKR 19,600.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: scale(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: scale(24)),
                ],
              ),
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

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontFamily: "OpenSansHebrew",
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required Function scale,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? trailing,
    VoidCallback? onTrailingTap,
  }) {
    return Container(
      height: scale(30),
      padding: EdgeInsets.symmetric(horizontal: scale(12)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "OpenSansHebrew",
              ),
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (trailing != null)
            GestureDetector(
              onTap: onTrailingTap,
              child: Text(
                trailing,
                style: const TextStyle(
                  color: Color(0xFFE8789D),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _radio(String title, String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: paymentMethod,
          activeColor: const Color(0xFFE8789D),
          onChanged: (val) {
            setState(() => paymentMethod = val.toString());
          },
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "OpenSansHebrew",
          ),
        ),
      ],
    );
  }

  Widget _row(String left, String right, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontFamily: "OpenSansHebrew",
            ),
          ),
          Text(
            right,
            style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassBox({required Widget child, required Function scale}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.all(scale(12)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(oldValue, newValue) {
    var text = newValue.text;

    if (text.length == 2 && !text.contains('/')) {
      text = "$text/";
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
