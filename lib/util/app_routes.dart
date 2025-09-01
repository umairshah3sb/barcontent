import 'package:barcontent/screen/countryFlags/coutries_flags_generator.dart';

import 'package:barcontent/screen/home/home.dart';
import 'package:barcontent/screen/image_test/image_test.dart';
import 'package:barcontent/util/exporter.dart';

class AppRoutes {
  // Static route keys
  static const String home = '/';
  static const flagGenerator = '/flag-generator';
  static const imageGenerator = '/image-tester';
  static const design1VideoGenerator = '/design1-video-generator';
  static const design2VideoGenerator = '/design2-video-generator';
  static const design3VideoGenerator = '/design3-video-generator';
  static const design4VideoGenerator = '/design4-video-generator';
  static const design5VideoGenerator = '/design5-video-generator';
  static const design6VideoGenerator = '/design6-video-generator';
  static const design7VideoGenerator = '/design7-video-generator';
  static const design8VideoGenerator = '/design8-video-generator';
  static const design9VideoGenerator = '/design9-video-generator';
  static const design10VideoGenerator = '/design10-video-generator';
  static const design11VideoGenerator = '/design11-video-generator';
  static const design12VideoGenerator = '/design12-video-generator';
  static const design13VideoGenerator = '/design13-video-generator';
  static const design14VideoGenerator = '/design14-video-generator';
  static const design15VideoGenerator = '/design15-video-generator';
  static const design16VideoGenerator = '/design16-video-generator';

  // Route map
  static Map<String, WidgetBuilder> routes = {
    home: (context) => Home(),
    flagGenerator: (context) => CountriesFlagGenerator(),
    imageGenerator: (context) => ImageTest(),
    design1VideoGenerator: (context) => Design1(),
    design2VideoGenerator: (context) => Design2(),
    design3VideoGenerator: (context) => Design3(),
    design4VideoGenerator: (context) => Design4(),
    design5VideoGenerator: (context) => Design5(),
    design6VideoGenerator: (context) => Design6(),
    design7VideoGenerator: (context) => Design7(),
    design8VideoGenerator: (context) => Design8(),
    design9VideoGenerator: (context) => Design9(),
    design10VideoGenerator: (context) => Design10(),
    design11VideoGenerator: (context) => Design11(),
    design12VideoGenerator: (context) => Design12(),
    design13VideoGenerator: (context) => Design13(),
    design14VideoGenerator: (context) => Design14(),
    design15VideoGenerator: (context) => Design15(),
    design16VideoGenerator: (context) => Design16(),
  };
}
