import 'package:barcontent/util/app_routes.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: spacing(v: 15),
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  children: [
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.imageGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: darkBlue,
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: Center(
                            child: Text(
                              'Test Image',
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.flagGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: darkBlue,
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: Center(
                            child: Text(
                              'Flags Generator',
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design1VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design2VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design3VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design3.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design4VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design4.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design5VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design5.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design6VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design6.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design7VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design7.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design8VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design8.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design9VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design9.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design10VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design10.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design11VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design5.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design12VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design12.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design13VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design13.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design14VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design14.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design15VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design15.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: spacing(h: 5, v: 5),
                      child: InkWell(
                        onTap: () {
                          pushNamedRoute(AppRoutes.design16VideoGenerator);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: borderRadius(10),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius(15),
                            child: Image.asset(
                              'assets/img/Design16.png',
                              fit: BoxFit.cover,
                            ),
                          ),
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
    );
  }
}
