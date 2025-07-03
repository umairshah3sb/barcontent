import 'dart:async';

import 'package:barcontent/screen/design/Design6/widgets/Design6_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';

class Design6Controller extends GetxController {
  List<dynamic> csvData = [];
  Map<String, dynamic> currentItems = {};
  TextEditingController title = TextEditingController();
  TextEditingController logo1 = TextEditingController();
  TextEditingController logo2 = TextEditingController();
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController backgroundImage = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool isGenerating = false;
  bool enableScroll = false;
  bool showBackgroundGradient = false;
  double logoSize = 250;
  double logoRadius = 10;
  int itemsPerScreen = 4;

  double valueFontSize = 18;
  double valueContainerSize = 70;
  Color valueFontColor = halfBlack;
  Color valueContainerLeft = HexColor('#919191');
  Color valueContainerRight = HexColor('#919191');
  Color valueContainerAnimation = Colors.blue;
  double picContainerSize = 50;
  double picContainerRadius = 8;
  double dataContainerHeight = 45;
  double dataContainerSpacing = 5;
  double dataContainerWidth = 430;

  double nameTextSize = 20;
  Color nameFontColor = halfBlack;

  double titleFontSize = 40;
  Color titleFontColor = halfBlack;

  double countryNameFontSize = 40;
  Color countryNameFontColor = halfBlack;

  int animationGap = 3;
  Color backgroundColor = whiteColor;
  LinearGradient backgroundGradient = LinearGradient(
    colors: [whiteColor, whiteColor],
  );
  double backgroundImageOpacity = 5;

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

  addItems() async {
    itemsList = [];
    if (csvData.isNotEmpty) {
      for (var i = 0; i < csvData.length; i++) {
        currentItems = csvData[i];
        update();
        await Future.delayed(Duration(seconds: 5));
      }
    }
    update();
  }
}
