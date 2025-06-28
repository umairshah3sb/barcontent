import 'package:barcontent/screen/countryFlags/coutries_flags_generator.dart';
import 'package:barcontent/screen/design/design1/design1.dart';
import 'package:barcontent/screen/design/design2/design2.dart';
import 'package:barcontent/screen/design/design3/design3.dart';
import 'package:barcontent/screen/design/design4/design4.dart';
import 'package:barcontent/screen/design/design5/design5.dart';
import 'package:barcontent/screen/image_test/image_test.dart';
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
      body: Container(
        padding: spacing(v: 15),
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Wrap(
              children: [
                Container(
                  margin: spacing(h: 5, v: 5),
                  child: InkWell(
                    onTap: () {
                      pushRoute(ImageTest());
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
                      pushRoute(CountriesFlagGenerator());
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
                      pushRoute(Design1());
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
                      pushRoute(Design2());
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
                      pushRoute(Design3());
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
                      pushRoute(Design4());
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
                      pushRoute(Design5());
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
