import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_navigation.dart';
import 'register_screen.dart';
import 'under_construction.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = true;
  bool obscurePassword = true;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadRememberedEmail();
  }

  Future<void> loadRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString('rememberedEmail');

    bool? remember = prefs.getBool('rememberMe');

    if (remember == true && savedEmail != null) {
      emailController.text = savedEmail;

      setState(() {
        isChecked = true;
      });
    }
  }

  Future<void> saveRememberMe() async {
    final prefs = await SharedPreferences.getInstance();

    if (isChecked) {
      await prefs.setString('rememberedEmail', emailController.text.trim());

      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('rememberedEmail');

      await prefs.setBool('rememberMe', false);
    }
  }

  /// LOGIN USER
  Future<void> loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await saveRememberMe();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Login Failed")));
    }
  }

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                    Image.asset(
                      "assets/images/v2-01.png",

                      height: height * 0.20,

                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: height * 0.025),

                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
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
                      controller: passwordController,
                      obscureText: obscurePassword,
                      style: const TextStyle(color: Colors.white),
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

                    /// REMEMBER ME
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
                          "Remember Me",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.02),

                    /// LOGIN
                    Material(
                      color: const Color(0xFFE8789D),
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: loginUser,
                        child: SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
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
          ),
        ],
      ),
    );
  }
}
