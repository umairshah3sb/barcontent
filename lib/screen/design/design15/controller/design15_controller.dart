import 'dart:async';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';

class Design15Controller extends GetxController {
  List<dynamic> csvData = [];
  Map<String, dynamic> dumyData = {
    'value1': '~\$30.5 trillion (1st)',
    'value2': '~\$19.2 trillion (2nd)',
    'name': 'GDP',
    'pic': 'https://i.postimg.cc/4x7WVwb0/image.png',
    'pic1': 'https://i.postimg.cc/4x7WVwb0/image.png',
    'pic2': 'https://i.postimg.cc/4x7WVwb0/image.png',
  };

  TextEditingController title = TextEditingController();
  TextEditingController logo1 = TextEditingController();
  TextEditingController logo2 = TextEditingController();
  TextEditingController verserImage = TextEditingController();
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController backgroundImage = TextEditingController();
  final ScrollController scrollController = ScrollController();

  double VideoContainerSpacingH = 10;
  double VideoContainerHeight = 600;
  double aspectRatio = 16 / 9;
  bool isGenerating = false;
  bool enableScroll = false;
  bool differencePic = false;
  bool changeStyle = false;

  bool showBackgroundGradient = false;
  double logoSize = 250;
  double logoRadius = 0;
  int itemsPerScreen = 4;
  int currentIndex = 0;
  double flagBorderSize = 5;
  Color flagBorderColor = Colors.transparent;

  double valueFontSize = 55;
  double valueWidth = 200;
  String valueFontFamily = 'Russo One';
  double valueContainerSize = 70;
  Color valueFontColor = halfBlack;
  Color valueContainerLeft = Colors.transparent;
  Color valueContainerRight = Colors.transparent;
  Color valueContainerAnimation = Colors.blue;

  double picContainerWidth = 400;
  double picContainerHeight = 300;
  double picBorderSize = 5;
  Color picBorderColor = Colors.transparent;

  double picVMargin = 40;
  double picHMargin = 40;
  double vsImageWidth = 100;
  double picContainerRadius = 0;
  double dataContainerSpacing = 5;
  double dataContainerWidth = 430;

  String nameFontFamily = 'Russo One';
  double nameTextSize = 20;
  Color nameFontColor = halfBlack;

  String titleFontFamily = 'Russo One';
  double titleFontSize = 40;
  Color titleFontColor = halfBlack;

  String countryFontFamily = 'Russo One';
  double countryNameFontSize = 40;
  double countryFlagSize = 100;
  Color countryNameFontColor = halfBlack;
  TextStyle styleText = GoogleFonts.genos();

  int animationGap = 3;
  Color backgroundColor = whiteColor;
  LinearGradient backgroundGradient = LinearGradient(
    colors: [whiteColor, whiteColor],
  );
  double backgroundImageOpacity = 5;
  double textShadowOpacity = 5;
  double flagShadowOpacity = 1;
  Color shadowColor = halfBlack;
  Color flagShadowColor = halfBlack;

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
        await Future.delayed(Duration(seconds: 6));
        currentIndex = i;
        update();
      }
    }
    update();
  }
}
