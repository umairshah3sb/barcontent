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
  TextEditingController typingSpeedController = TextEditingController();
  TextEditingController backgroundImage = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool isGenerating = false;
  bool enableScroll = false;
  bool showTitle2 = true;
  bool typeTitle = true;
  int template = 0;
  bool showBackgroundGradient = false;
  double UserPicWidth = 135;
  double UserPicHeght = 135;
  double aspectRatio = 9 / 16;
  double logoContainerHeight = 140;
  double logoRadius = 0;
  int itemsPerScreen = 4;
  double flagWidth = 65;
  double flagBottomSpacing = 10;
  double flagRightSpacing = 10;
  TextStyle valueTextStyle = GoogleFonts.lobster(
    fontSize: 33,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  TextAlign valueTextAlign = TextAlign.center;
  double valueFontSize = 18;
  String valueFontFamily = "Russo One";
  double valueContainerSize = 45;
  double valueWidth = 160;
  Color valueFontColor1 = halfBlack;
  Color valueFontColor2 = halfBlack;
  Color? valueContainerLeft = null;
  Color? valueContainerRight = null;

  double valueContainerRadius = 8;
  double valueContainerSpacing = 10;

  Color valueContainerAnimation = Colors.blue;
  Color? picIconColor;
  double picContainerHeight = 50;
  double picContainerWidth = 50;
  double picContainerRadius = 8;
  double dataContainerHeight = 45;
  double dataContainerSpacing = 5;
  double dataContainerWidth = 430;
  double dataContainerMarginTop = 60;
  double dataContainerMarginBottom = 60;
  double dataContainerMarginH = 10;

  double nameTextSize = 20;
  String nameFontFamily = "Russo One";

  Color nameFontColor = halfBlack;
  Color containerBorder = halfBlack;

  TextStyle titleTextStyle = GoogleFonts.russoOne(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  TextStyle title2TextStyle = GoogleFonts.russoOne(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  String titleFontFamily = "Russo One";
  String title2FontFamily = "Russo One";

  TextAlign titleTextAlign = TextAlign.center;
  TextAlign title2TextAlign = TextAlign.center;
  double titleFontSize = 20;
  double titleContainerWidth = 230;
  Color titleFontColor = Colors.yellow;
  Color titleShadowColor = halfBlack;
  Color titleBackgroundColor = Colors.red;
  double title2ContainerWidth = 230;
  double titlePositionTop = 0;
  double titlePositionLeft = 0;
  double title2PositionTop = 0;
  double title2PositionLeft = 0;

  Color title2FontColor = Colors.yellow;
  Color title2ShadowColor = halfBlack;
  Color title2BackgroundColor = Colors.red;

  int animationGap = 10;
  int typingSpeed = 80;
  int title2Delay = 2;
  double secrollPadding = 10;
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
    showTitle2 = false;
    typeTitle = true;
    Timer(Duration(seconds: (5)), () {
      addItems();
      Timer(Duration(seconds: title2Delay), () {
        typeTitle = false;
        showTitle2 = true;
        update();
      });
      isGenerating = false;
      update();
    });
  }

  addItems() {
    itemsList = [];
    if (csvData.isNotEmpty) {
      if (template == 0) {
        for (var i = 0; i < csvData.length; i++) {
          itemsList.add(
            Design9Item(
              data: csvData[i],
              index: i,
            ),
          );
        }
      } else if (template == 1 || template == 2) {
        for (var i = 0; i < csvData.length; i++) {
          itemsList.add(
            Design9Item2(
              data: csvData[i],
              index: i,
            ),
          );
        }
      }
    }
    if (enableScroll) {
      Timer(Duration(seconds: 3), () {
        scrollToBottom(animationGap);
      });
    }
    update();
  }
}
