import 'dart:async';

import 'package:barcontent/screen/design/design9/widgets/design9_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';

class Design9Controller extends GetxController {
  List<dynamic> csvData = [];
  TextEditingController title = TextEditingController();
  TextEditingController title2 = TextEditingController();
  TextEditingController logo1 = TextEditingController();
  TextEditingController logo2 = TextEditingController();
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController backgroundImage = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool isGenerating = false;
  bool enableScroll = false;
  bool showBackgroundGradient = false;
  double logoSize = 150;
  double logoContainerHeight = 150;
  double logoRadius = 10;
  int itemsPerScreen = 4;
  double flagWidth = 65;
  TextStyle valueTextStyle = GoogleFonts.russoOne(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  TextAlign valueTextAlign = TextAlign.center;
  double valueFontSize = 18;
  double valueContainerSize = 45;
  double valueWidth = 150;
  Color valueFontColor1 = halfBlack;
  Color valueFontColor2 = halfBlack;
  Color? valueContainerLeft = null;
  Color? valueContainerRight = null;
  double valueContainerRadius = 8;
  double valueContainerSpacing = 8;

  Color valueContainerAnimation = Colors.blue;
  Color? picIconColor;
  double picContainerSize = 50;
  double picContainerRadius = 8;
  double dataContainerHeight = 45;
  double dataContainerSpacing = 5;
  double dataContainerWidth = 430;
  double dataContainerMarginV = 60;
  double dataContainerMarginH = 10;

  double nameTextSize = 20;
  Color nameFontColor = halfBlack;

  TextStyle titleTextStyle = GoogleFonts.russoOne(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  TextAlign titleTextAlign = TextAlign.center;
  double titleFontSize = 20;
  double titleContainerWidth = 230;
  Color titleFontColor = Colors.yellow;
  Color titleShadowColor = halfBlack;
  Color titleBackgroundColor = Colors.red;

  int animationGap = 3;
  Color backgroundColor = whiteColor;
  LinearGradient? backgroundGradient = null;
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

  addItems() {
    itemsList = [];
    if (csvData.isNotEmpty) {
      for (var i = 0; i < csvData.length; i++) {
        itemsList.add(
          Design9Item(
            data: csvData[i],
            index: i,
          ),
        );
      }
    }
    Timer(Duration(seconds: 3), () {
      scrollToBottom(10);
    });
    update();
  }
}
