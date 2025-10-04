import 'dart:async';
import 'package:barcontent/screen/design/design18/widgets/bar_design.dart';
import 'package:barcontent/screen/design/design18/widgets/design18_item.dart';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design18Controller extends GetxController {
  List<dynamic> csvData = [];
  Map<String, dynamic> dumyData = {
    'value1': '180',
    'value2': '170',
    'name': 'Nuclear Warheads',
    'pic':
        'https://t4.ftcdn.net/jpg/02/44/43/69/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg',
  };

  TextEditingController backgroundImage = TextEditingController();
  final ScrollController scrollController = ScrollController();

  //bar data------------------->

  double maxValue = 200.0;
  double maxBarAreaHeight = Get.height * 0.8;
  double barDepth = 15.0;
  double barWidth = 150.0;
  double spaceBetween = 10;

  //bar data------------------->

  bool isGenerating = false;
  bool enableScroll = false;
  bool showBackgroundGradient = false;
  double backgroundImageOpacity = 5;

  double picContainerWidth = 100;
  double picBottomSpace = 20;

  double nameContainerWidth = 100;
  double nameTopSpacing = 20;
  String nameFontFamily = 'Russo One';
  Color nameFontColor = halfBlack;
  TextAlign nameTextAlign = TextAlign.center;
  TextStyle nameStyle = GoogleFonts.manrope(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  double nameTextSize = 20;
  int animationGap = 3;
  Color backgroundColor = whiteColor;
  LinearGradient backgroundGradient = LinearGradient(
    colors: [whiteColor, whiteColor],
  );

  List<Widget> itemsList = [];

  void scrollToBottom(int sec) {
    if (scrollController.hasClients &&
        scrollController.position.maxScrollExtent > scrollController.offset) {
      scrollController.animateTo(
        scrollController.offset + 250,
        duration: Duration(milliseconds: sec),
        curve: Curves.easeOut,
      );
    }
  }

  updateFlow() {
    itemsList = [];
    update();
    Timer(Duration(seconds: (5)), () {
      addItems();
      isGenerating = false;
      update();
    });
  }

  addItems() async {
    itemsList = [];
    if (csvData.isNotEmpty) {
      for (var i = 0; i < csvData.length; i++) {
        await Future.delayed(Duration(seconds: animationGap));
        itemsList.add(
          Design18Item(
            data: csvData[i],
            value: (70 + i).toDouble(),
            maxValue: maxValue,
            color: getRandomColor(),
            maxBarAreaHeight: maxBarAreaHeight,
            depth: barDepth,
            barWidth: barWidth,
            isLastBar: true,
          ),
        );
        update();
        scrollToBottom(200);
      }
    }
    update();
  }
}
