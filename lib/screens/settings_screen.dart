import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool notifications = true;

  bool darkMode = true;

  bool orderUpdates = true;

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    double s(num value) =>
    value.toDouble() * (width / 375);
    return Scaffold(

      backgroundColor:
          Colors.black,

      body: Stack(

        children: [

          Positioned.fill(

            child: Image.asset(

              "assets/images/bg2.jpg",

              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(

            child: BackdropFilter(

              filter: ImageFilter.blur(
                sigmaX: 12,
                sigmaY: 12,
              ),

              child: Container(
                color:
                    Colors.transparent,
              ),
            ),
          ),

          Positioned.fill(

            child: Container(

              color: Colors.black
                  .withOpacity(0.82),
            ),
          ),

          SafeArea(

            child:
                SingleChildScrollView(

              padding:
                  EdgeInsets.all(
                      s(18)),

              child: Column(

                children: [

                  /// TOP BAR
                  Row(

                    children: [

                      Material(

                        color:
                            Colors.white
                                .withOpacity(
                                    0.08),

                        borderRadius:
                            BorderRadius.circular(
                                14),

                        child: InkWell(

                          borderRadius:
                              BorderRadius.circular(
                                  14),

                          onTap: () {

                            Navigator.pop(
                                context);
                          },

                          child: Padding(

                            padding:
                                EdgeInsets.all(
                                    s(10)),

                            child: Icon(

                              Icons
                                  .arrow_back_ios_new,

                              color:
                                  Colors.white,

                              size:
                                  s(18),
                            ),
                          ),
                        ),
                      ),

                      Expanded(

                        child: Center(

                          child: Text(

                            "SETTINGS",

                            style:
                                TextStyle(

                              color:
                                  const Color(
                                0xFFE8789D,
                              ),

                              fontSize:
                                  s(19),

                              fontWeight:
                                  FontWeight.bold,

                              letterSpacing:
                                  2,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                          width:
                              s(38)),
                    ],
                  ),

                  SizedBox(
                      height:
                          s(34)),

         
                  glassTile(

                    child: Column(

                      children: [

                        settingSwitch(

                          title:
                              "Push Notifications",

                          value:
                              notifications,

                          onChanged:
                              (v) {

                            setState(() {

                              notifications =
                                  v;
                            });
                          },
                        ),

                        divider(),

                        settingSwitch(

                          title:
                              "Dark Mode",

                          value:
                              darkMode,

                          onChanged:
                              (v) {

                            setState(() {

                              darkMode =
                                  v;
                            });
                          },
                        ),

                        divider(),

                        settingSwitch(

                          title:
                              "Order Updates",

                          value:
                              orderUpdates,

                          onChanged:
                              (v) {

                            setState(() {

                              orderUpdates =
                                  v;
                            });
                          },
                        ),
                      ],
                    ),

                    s: s,
                  ),

                  SizedBox(
                      height:
                          s(22)),

                  glassTile(

                    child: Column(

                      children: [

                        settingButton(
                          "Privacy Policy",
                          Icons.lock_outline,
                        ),

                        divider(),

                        settingButton(
                          "Terms & Conditions",
                          Icons.description_outlined,
                        ),

                        divider(),

                        settingButton(
                          "About CHIKK",
                          Icons.info_outline,
                        ),
                      ],
                    ),

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

  Widget glassTile({
  required Widget child,
  required double Function(num) s,
}) {

    return ClipRRect(

      borderRadius:
          BorderRadius.circular(
              28),

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),

        child: Container(

          padding:
              EdgeInsets.all(
                  s(18)),

          decoration:
              BoxDecoration(

            color: Colors.white
                .withOpacity(0.08),

            borderRadius:
                BorderRadius.circular(
                    28),

            border: Border.all(
              color:
                  Colors.white12,
            ),
          ),

          child: child,
        ),
      ),
    );
  }

  Widget settingSwitch({

    required String title,

    required bool value,

    required Function(bool)
        onChanged,
  }) {

    return Row(

      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [

        Text(

          title,

          style:
              const TextStyle(

            color:
                Colors.white,

            fontSize: 14,
          ),
        ),

        Switch(

          value: value,

          activeColor:
              const Color(
            0xFFE8789D,
          ),

          onChanged:
              onChanged,
        ),
      ],
    );
  }

  Widget settingButton(
    String title,
    IconData icon,
  ) {

    return Material(

      color: Colors.transparent,

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
                14),

        onTap: () {},

        child: Padding(

          padding:
              const EdgeInsets.symmetric(
            vertical: 14,
          ),

          child: Row(

            children: [

              Icon(
                icon,
                color:
                    const Color(
                  0xFFE8789D,
                ),
              ),

              const SizedBox(
                  width: 14),

              Expanded(

                child: Text(

                  title,

                  style:
                      const TextStyle(

                    color:
                        Colors.white,
                  ),
                ),
              ),

              const Icon(

                Icons.arrow_forward_ios,

                size: 14,

                color:
                    Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider() {

    return Container(

      margin:
          const EdgeInsets.symmetric(
        vertical: 10,
      ),

      height: 1,

      color: Colors.white12,
    );
  }
}