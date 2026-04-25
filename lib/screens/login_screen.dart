import 'dart:ui';
import 'package:flutter/material.dart';
import 'under_construction.dart';
import 'register_screen.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = true;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Image.asset("assets/images/bg2.jpg", fit: BoxFit.cover),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),

          Center(
            child: Container(
              width: width * 0.85,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: height * 0.04,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white12),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// EMAIL
                  TextField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "OpenSansHebrew",
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.white70),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  TextField(
                    obscureText: obscurePassword,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "OpenSansHebrew",
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.white70),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),

                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        activeColor: const Color(0xFFE8789D),
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text(
                        "Keep me logged in",
                        style: TextStyle(
                          fontFamily: "OpenSansHebrew",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  Material(
                    color: const Color(0xFFE8789D),
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainNavigation(),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontFamily: "OpenSansHebrew",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UnderConstructionScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Your Password?",
                          style: TextStyle(
                            fontFamily: "OpenSansHebrew",
                            color: Colors.white70,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Create New Account",
                          style: TextStyle(
                            fontFamily: "OpenSansHebrew",
                            color: Colors.white70,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
