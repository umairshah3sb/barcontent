import 'dart:async';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class design2Controller extends GetxController {
  List<dynamic> csvData = [design2Data, design2Data, design2Data];
  bool isGenerating = false;
  bool enableScroll = false;
  bool hideIndex = false;
  double nameFontSize = 45;
  int itemsPerScreen = 4;
  double largTextSize = 90;
  double smallTextSize = 30;
  int videoDuration = 90;
  Color nameContainerColor = whiteColor;
  Color indexContainerColor = HexColor('#ffbd59');
  Color indexFontColor = halfBlack;
  Color nameFontColor = halfBlack;
  Color LargeTextContainer = HexColor('#919191');
  Color largeFontColor = HexColor('#ffbd59');
  Color smallFontColor = whiteColor;

  updateFlow() {
    update();
    Timer(Duration(seconds: (videoDuration + 30)), () {
      isGenerating = false;
      enableScroll = false;
      update();
    });
  }
}
