import 'package:barcontent/util/app_routes.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/footer.dart';
import 'package:barcontent/util/helper.dart';
import 'package:barcontent/util/meta_data_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    MetaHelper.setMetaData(
      title: "Create Comparison Video - CSV to Video - No Water Mark",
      description:
          "Create comparison videos from CSV to video without watermark. Generate country comparison, phone specs comparison, bar chart race, and sliding comparison videos in minutes with our free online tool.",
      keywords:
          "free comparison video maker, create sliding videos online, csv to video generator, data comparison video creator, free video maker no watermark, automated video generator, top 10 list video creator, ranking video maker, free online video editor, create long and short videos",
      author: "Umair Shah",
      ogImage: '${domainUrl}assets/assets/img/Design17.png',
      ogUrl: '${domainUrl}${AppRoutes.design17VideoGenerator}',
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: spaceOnly(top: 15),
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
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
                        Container(
                          margin: spacing(h: 5, v: 5),
                          child: InkWell(
                            onTap: () {
                              pushNamedRoute(AppRoutes.design17VideoGenerator);
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
                              pushNamedRoute(AppRoutes.design18VideoGenerator);
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
                              pushNamedRoute(AppRoutes.design19VideoGenerator);
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
                      ],
                    ),
                  ),
                ),
                HtmlFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
