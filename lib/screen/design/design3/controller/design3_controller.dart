import 'dart:async';

import 'package:barcontent/screen/design/design3/widgets/design3_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class design3Controller extends GetxController {
  List<dynamic> csvData = [];
  TextEditingController logo1 = TextEditingController();
  TextEditingController logo2 = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool isGenerating = false;
  bool enableScroll = false;
  double logoSize = 150;
  double logoRadius = 10;
  int itemsPerScreen = 4;

  double valueFontSize = 16;
  double valueContainerSize = 70;
  Color valueFontColor = HexColor('#ffbd59');
  Color valueContainerLeft = HexColor('#919191');
  Color valueContainerRight = HexColor('#919191');
  Color valueContainerAnimation = Colors.blue;
  double picContainerSize = 50;
  double picContainerRadius = 8;
  double dataContainerHeight = 30;
  double dataContainerSpacing = 5;
  double dataContainerWidth = 360;

  double nameTextSize = 14;
  Color nameFontColor = halfBlack;

  int animationGap = 3;
  Color backgroundColor = HexColor('#ffbd59');
  Color indexFontColor = halfBlack;
  Color smallFontColor = whiteColor;
  List<Widget> itemsList = [];

  void scrollToBottom(int sec) {
    final maxScroll = scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      maxScroll,
      duration: Duration(seconds: sec),
      curve: Curves.easeInOut,
    );
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

  addItems() {
    itemsList = [];
    if (csvData.isNotEmpty) {
      for (var i = 0; i < csvData.length; i++) {
        itemsList.add(
          Design3Item(
            data: csvData[i],
            sec: ((i + 1) * animationGap),
          ),
        );
      }
      Timer(Duration(seconds: animationGap * 4), () {
        scrollToBottom(((csvData.length - 4) * animationGap));
        update();
      });
    }
    update();
  }
}
