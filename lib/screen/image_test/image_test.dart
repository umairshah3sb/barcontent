import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({super.key});

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Container(
              margin: spacing(v: 15, h: 15),
              child: ClipRRect(
                borderRadius: borderRadius(10),
                child: Container(
                  width: 150,
                  height: 150,
                  child: textController.text.contains('.svg')
                      ? SvgPicture.network(
                          textController.text,
                          fit: BoxFit.cover,
                          placeholderBuilder: (context) =>
                              CircularProgressIndicator(),
                        )
                      : CachedNetworkImage(
                          imageUrl: textController.text,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Container(
              width: 400,
              height: 50,
              padding: spacing(
                h: 14,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: shadow,
                borderRadius: borderRadius(50),
                border: Border.all(
                  width: 2,
                  color: halfBlack,
                ),
              ),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {});
                },
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Enter Url to Test for load',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: halfBlack,
                  ),
                ),
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: halfBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
