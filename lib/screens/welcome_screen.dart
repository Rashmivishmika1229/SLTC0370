import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoginSelected = true;

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
            child: Image.asset("assets/images/welcome.jpg", fit: BoxFit.cover),
          ),

          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "DISCOVER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "PlayfairDisplay",
                    fontSize: width * 0.09,
                    letterSpacing: 8.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),

                Text(
                  "YOUR  STYLE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "PlayfairDisplay",
                    fontSize: width * 0.09,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),

                SizedBox(height: height * 0.015),

                Text(
                  "Find the latest trends in\nwomen's fashion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "OpenSansHebrew",
                    fontSize: width * 0.045,
                    color: Colors.white70,
                  ),
                ),

                SizedBox(height: height * 0.05),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoginSelected = true;
                          });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: isLoginSelected
                                ? Color(0xFFE8789D)
                                : Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFFE8789D),
                              width: 2.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 4.0,
                              fontFamily: "OpenSansHebrew",
                              fontWeight: FontWeight.bold,

                              color: isLoginSelected
                                  ? Colors.white
                                  : Color(0xFFE8789D),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 16),

                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoginSelected = false;
                          });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: isLoginSelected
                                ? Colors.transparent
                                : Color(0xFFE8789D),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFFE8789D),
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              fontFamily: "OpenSansHebrew",
                              letterSpacing: 4.0,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isLoginSelected
                                  ? Color(0xFFE8789D)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.06),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
