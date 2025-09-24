import 'package:barcontent/screen/countryFlags/coutries_flags_generator.dart';
import 'package:barcontent/screen/design/design17/design17.dart';

import 'package:barcontent/screen/home/home.dart';
import 'package:barcontent/screen/image_test/image_test.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/tools/shadow_generator.dart';

class AppRoutes {
  // Static route keys
  static const String home = '/';
  static const flagGenerator = '/flag-generator';
  static const imageGenerator = '/image-tester';
  static const design1VideoGenerator = 'data-comparison-video-generator';
  static const design2VideoGenerator = 'data-comparison-video-generator-2';
  static const design3VideoGenerator = 'comparison-short-video-generator-1';
  static const design4VideoGenerator = 'comparison-short-video-generator-2';
  static const design5VideoGenerator = 'comparison-short-video-generator-free';
  static const design6VideoGenerator = 'comparison-video-generator';
  static const design7VideoGenerator = '3d-bar-comparison-video-generator';
  static const design8VideoGenerator = '3d-bar-video-generator';
  static const design9VideoGenerator = 'make-short-video-generator';
  static const design10VideoGenerator = 'make-comparison-video';
  static const design11VideoGenerator = 'create-short-comparison-video';
  static const design12VideoGenerator = 'create-mobile-comparison-video';
  static const design13VideoGenerator = 'create-mobile-specification-video';
  static const design14VideoGenerator = 'create-short-mobile-specification';
  static const design15VideoGenerator = 'create-data-comparison-video';
  static const design16VideoGenerator = 'phone-comparison-video-creator';
  static const design17VideoGenerator = 'make-data-comparison-video';

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
    design17VideoGenerator: (context) => Design17(),
  };
}
