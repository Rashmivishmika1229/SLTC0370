import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/category_drawer.dart';
import 'dart:ui';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showDrawer = false;

  @override
  Widget build(BuildContext context) {
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
                TopBar(
                  onMenuTap: () {
                    setState(() {
                      showDrawer = true;
                    });
                  },
                ),

                const SizedBox(height: 20),

                Column(
                  children: const [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFE8789D),
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "User Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "OpenSansHebrew",
                      ),
                    ),
                    Text(
                      "user@email.com",
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: "OpenSansHebrew",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _profileItem(Icons.shopping_bag, "My Orders"),
                      _profileItem(Icons.location_on, "Shipping Address"),
                      _profileItem(Icons.payment, "Payment Methods"),
                      _profileItem(Icons.settings, "Settings"),
                      _profileItem(Icons.help_outline, "Help & Support"),

                      const SizedBox(height: 20),

                      _logoutButton(),
                    ],
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

          if (showDrawer) CategoryDrawer(isOpen: showDrawer),
        ],
      ),
    );
  }

  Widget _profileItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            print("$title clicked");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFFE8789D)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "OpenSansHebrew",
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return Material(
      color: const Color(0xFFE8789D),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          print("Logout clicked");
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: const Text(
            "LOGOUT",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontFamily: "OpenSansHebrew",
            ),
          ),
        ),
      ),
    );
  }
}
