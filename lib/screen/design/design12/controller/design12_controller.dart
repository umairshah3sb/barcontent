import 'dart:async';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';

class Design12Controller extends GetxController {
  List<dynamic> csvData = [];
  Map<String, dynamic> dumyData = {
    'value1': 'GSM / CDMA / HSPA / EVDO / LTE / 5G',
    'value2': 'GSM / CDMA / HSPA / EVDO / LTE / 5G',
    'value3': 'GSM / CDMA / HSPA / EVDO / LTE / 5G',
    'name': 'Technology',
    'pic':
        'https://t4.ftcdn.net/jpg/02/44/43/69/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg',
  };

  TextEditingController title = TextEditingController();
  TextEditingController logo1 = TextEditingController();
  TextEditingController logo2 = TextEditingController();
  TextEditingController logo3 = TextEditingController();
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController name3 = TextEditingController();
  TextEditingController backgroundImage = TextEditingController();
  final ScrollController scrollController = ScrollController();

  TextAlign titleTextAlign = TextAlign.center;
  TextStyle titleTextStyle = GoogleFonts.russoOne(
    fontSize: 65,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  bool isGenerating = false;
  bool enableScroll = false;
  bool showBackgroundGradient = false;
  double logoSize = 250;
  double logoRadius = 10;
  int itemsPerScreen = 4;
  int currentIndex = 0;

  TextAlign subTitleTextAlign = TextAlign.center;

  TextStyle subTitleTextStyle = GoogleFonts.russoOne(
    fontSize: 33,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  TextStyle valueTextStyle = GoogleFonts.russoOne(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  TextAlign valueTextAlign = TextAlign.center;
  double valueFontSize = 30;
  double valueContainerSize = 420;
  Color valueFontColor = whiteColor;
  Color valueContainerLeft = HexColor('#919191');
  Color valueContainerRight = HexColor('#919191');
  Color valueContainerAnimation = Colors.blue;
  double picContainerSize = 100;
  double picContainerRadius = 8;
  double dataContainerHeight = Get.height * 0.7;
  double dataContainerSpacing = 5;
  double dataContainerWidth = 500;

  double nameTextSize = 40;
  Color nameContainerColor = halfBlack;
  Color nameFontColor = whiteColor;
  TextAlign nameTextAlign = TextAlign.center;
  TextStyle nameTextStyle = GoogleFonts.russoOne(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  double titleFontSize = 65;
  Color titleFontColor = halfBlack;
  double subtitleFontSize = 33;
  Color subtitleFontColor = halfBlack;

  double countryNameFontSize = 40;
  double countryFlagSize = 100;
  Color countryNameFontColor = halfBlack;

  int animationGap = 3;
  Color backgroundColor = whiteColor;
  LinearGradient backgroundGradient = LinearGradient(
    colors: [whiteColor, whiteColor],
  );
  double backgroundImageOpacity = 5;
  double textShadowOpacity = 5;
  Color shadowColor = halfBlack;

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
        await Future.delayed(Duration(seconds: 4));
        currentIndex = i;
        if (csvData[i]['title'].toString().isNotEmpty) {
          title.text = csvData[i]['title'].toString();
        }
        update();
      }
    }
    update();
  }
}
