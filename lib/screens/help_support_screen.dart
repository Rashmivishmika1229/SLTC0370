import 'dart:ui';
import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(s(18)),

              child: Column(
                children: [
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
                            "HELP & SUPPORT",

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

                  SizedBox(height: s(34)),

                  helpCard(
                    title: "Customer Support",

                    subtitle: "Chat with our support team for quick help.",

                    icon: Icons.support_agent,

                    s: s,
                  ),

                  SizedBox(height: s(18)),

                  helpCard(
                    title: "Shipping Information",

                    subtitle: "Learn about delivery timelines and tracking.",

                    icon: Icons.local_shipping_outlined,

                    s: s,
                  ),

                  SizedBox(height: s(18)),

                  helpCard(
                    title: "Return Policy",

                    subtitle: "Easy returns and refund guidelines.",

                    icon: Icons.assignment_return_outlined,

                    s: s,
                  ),

                  SizedBox(height: s(18)),

                  helpCard(
                    title: "Contact Us",

                    subtitle: "support@chikk.com",

                    icon: Icons.email_outlined,

                    s: s,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget helpCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required double Function(num) s,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

        child: Container(
          padding: EdgeInsets.all(s(18)),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),

            borderRadius: BorderRadius.circular(28),

            border: Border.all(color: Colors.white12),
          ),

          child: Row(
            children: [
              Container(
                width: s(52),

                height: s(52),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8789D).withOpacity(0.15),

                  shape: BoxShape.circle,
                ),

                child: Icon(icon, color: const Color(0xFFE8789D)),
              ),

              SizedBox(width: s(16)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,

                      style: TextStyle(
                        color: Colors.white,

                        fontWeight: FontWeight.bold,

                        fontSize: s(14),
                      ),
                    ),

                    SizedBox(height: s(6)),

                    Text(
                      subtitle,

                      style: TextStyle(
                        color: Colors.white70,

                        fontSize: s(11),

                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
