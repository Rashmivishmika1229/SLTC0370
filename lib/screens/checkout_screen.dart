import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/category_drawer.dart';
import '../services/order_service.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orderedProducts;

  const CheckoutScreen({super.key, required this.orderedProducts});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool showDrawer = false;

  String paymentMethod = "card";

  final OrderService orderService = OrderService();

  final nameCtrl = TextEditingController();

  final addressCtrl = TextEditingController();

  final cardNameCtrl = TextEditingController();

  final cardNumberCtrl = TextEditingController();

  final expiryCtrl = TextEditingController();

  final cvcCtrl = TextEditingController();

  String generateOrderId() {
    final random = Random();

    return "ORD-${100000 + random.nextInt(900000)}";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double scale(num size) => size.toDouble() * (width / 375);

    double subtotal = 0;

    for (var item in widget.orderedProducts) {
      subtotal += item["price"] * item["qty"];
    }

    double delivery = widget.orderedProducts.isEmpty ? 0 : 500;

    double total = subtotal + delivery;

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
            child: Container(color: Colors.black.withOpacity(0.72)),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(scale(16)),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// TOP BAR
                  Row(
                    children: [
                      /// BACK BUTTON
                      Material(
                        color: Colors.white.withOpacity(0.08),

                        borderRadius: BorderRadius.circular(14),

                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),

                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: Padding(
                            padding: EdgeInsets.all(scale(10)),

                            child: Icon(
                              Icons.arrow_back_ios_new,

                              color: Colors.white,

                              size: scale(18),
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      /// MENU 
                      Material(
                        color: Colors.white.withOpacity(0.08),

                        borderRadius: BorderRadius.circular(14),

                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),

                          onTap: () {
                            setState(() {
                              showDrawer = true;
                            });
                          },

                          child: Padding(
                            padding: EdgeInsets.all(scale(10)),

                            child: Icon(
                              Icons.menu,

                              color: Colors.white,

                              size: scale(22),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: scale(18)),

                 
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

                  SizedBox(height: scale(22)),

                  /// PRODUCTS
                  Text(
                    "SELECTED PRODUCTS",

                    style: TextStyle(
                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                      fontSize: scale(14),

                      letterSpacing: 1.2,
                    ),
                  ),

                  SizedBox(height: scale(10)),

                  if (widget.orderedProducts.isEmpty)
                    Container(
                      width: double.infinity,

                      padding: EdgeInsets.all(scale(20)),

                      alignment: Alignment.center,

                      child: const Text(
                        "No Products Selected",

                        style: TextStyle(color: Colors.white70),
                      ),
                    ),

                  ListView.builder(
                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: widget.orderedProducts.length,

                    itemBuilder: (context, index) {
                      final item = widget.orderedProducts[index];

                      return _productTile(item, index, scale);
                    },
                  ),

                  SizedBox(height: scale(18)),

                  _label("Name"),

                  _inputField(controller: nameCtrl, scale: scale),

                  SizedBox(height: scale(16)),

                  _label("Delivery Address"),

                  _inputField(controller: addressCtrl, scale: scale),

                  SizedBox(height: scale(20)),

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
                    SizedBox(height: scale(16)),

                    _label("Name on the card"),

                    _inputField(controller: cardNameCtrl, scale: scale),

                    SizedBox(height: scale(16)),

                    _label("Card number"),

                    _inputField(
                      controller: cardNumberCtrl,

                      scale: scale,

                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: scale(16)),

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

                  SizedBox(height: scale(22)),

                  /// SUMMARY
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
                        _row("Subtotal", "LKR ${subtotal.toStringAsFixed(2)}"),

                        _row("Delivery", "LKR ${delivery.toStringAsFixed(2)}"),

                        const Divider(color: Colors.white24),

                        _row(
                          "Total",

                          "LKR ${total.toStringAsFixed(2)}",

                          bold: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: scale(24)),

                  /// PAYMENT 
                  Material(
                    color: const Color(0xFFE8789D),

                    borderRadius: BorderRadius.circular(25),

                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),

                      splashColor: Colors.white.withOpacity(0.3),

                      onTap: () async {
                        if (widget.orderedProducts.isEmpty) {
                          return;
                        }

                        final orderId = generateOrderId();

                        await orderService.placeOrder(
                          orderId: orderId,

                          customerName: nameCtrl.text,

                          address: addressCtrl.text,

                          paymentMethod: paymentMethod == "card"
                              ? "Paid via Card"
                              : "Cash On Delivery",

                          total: total,

                          products: widget.orderedProducts,
                        );

                        showDialog(
                          context: context,

                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),

                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 15,

                                    sigmaY: 15,
                                  ),

                                  child: Container(
                                    padding: const EdgeInsets.all(24),

                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.08),

                                      borderRadius: BorderRadius.circular(28),

                                      border: Border.all(color: Colors.white24),
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
                                          "THANK YOU !",

                                          style: TextStyle(
                                            color: Colors.white,

                                            fontSize: 22,

                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        const Text(
                                          "Thank you so much for your payment.",

                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),

                                        const SizedBox(height: 18),

                                        Text(
                                          "ORDER ID\n$orderId",

                                          textAlign: TextAlign.center,

                                          style: const TextStyle(
                                            color: Color(0xFFE8789D),

                                            fontWeight: FontWeight.bold,

                                            fontSize: 16,
                                          ),
                                        ),

                                        const SizedBox(height: 22),

                                        Material(
                                          color: const Color(0xFFE8789D),

                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),

                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),

                                            onTap: () {
                                              Navigator.pop(context);

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
                      },

                      child: Container(
                        width: double.infinity,

                        padding: EdgeInsets.symmetric(vertical: scale(14)),

                        alignment: Alignment.center,

                        child: Text(
                          "MAKE PAYMENT   LKR ${total.toStringAsFixed(2)}",

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
              onTap: () {
                setState(() {
                  showDrawer = false;
                });
              },

              child: Container(color: Colors.black.withOpacity(0.3)),
            ),

          if (showDrawer) CategoryDrawer(isOpen: showDrawer),
        ],
      ),
    );
  }

  Widget _productTile(
    Map<String, dynamic> item,
    int index,
    double Function(num) scale,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: scale(10)),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),

          child: Container(
            padding: EdgeInsets.all(scale(8)),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),

              borderRadius: BorderRadius.circular(18),

              border: Border.all(color: Colors.white24),
            ),

            child: Row(
              children: [
                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),

                  child: item["image"].toString().startsWith("http")
                      ? Image.network(
                          item["image"],

                          width: scale(58),

                          height: scale(74),

                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          item["image"],

                          width: scale(58),

                          height: scale(74),

                          fit: BoxFit.cover,
                        ),
                ),

                SizedBox(width: scale(10)),

                /// DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        item["name"],

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,

                          fontSize: scale(10.5),
                        ),
                      ),

                      SizedBox(height: scale(4)),

                      Text(
                        "Size ${item["size"]}",

                        style: TextStyle(
                          color: Colors.white70,

                          fontSize: scale(9),
                        ),
                      ),

                      SizedBox(height: scale(4)),

                      Text(
                        "Qty : ${item["qty"]}",

                        style: TextStyle(
                          color: Colors.white70,

                          fontSize: scale(9),
                        ),
                      ),
                    ],
                  ),
                ),

              
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    
                    Material(
                      color: Colors.transparent,

                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),

                        onTap: () {
                          setState(() {
                            widget.orderedProducts.removeAt(index);
                          });
                        },

                        child: Padding(
                          padding: EdgeInsets.all(scale(4)),

                          child: Icon(
                            Icons.delete_outline,

                            color: Colors.white,

                            size: scale(18),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: scale(18)),

                    /// PRICE
                    Text(
                      "LKR ${item["price"]}",

                      style: TextStyle(
                        color: Colors.white,

                        fontWeight: FontWeight.bold,

                        fontSize: scale(10),
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

    required double Function(num) scale,

    TextInputType? keyboardType,

    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      height: scale(30),

      padding: EdgeInsets.symmetric(horizontal: scale(12)),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),

        borderRadius: BorderRadius.circular(20),
      ),

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
            setState(() {
              paymentMethod = val.toString();
            });
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

  Widget _glassBox({
    required Widget child,

    required double Function(num) scale,
  }) {
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
