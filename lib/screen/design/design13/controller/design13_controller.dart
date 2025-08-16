import 'dart:async';
import 'package:barcontent/screen/design/design13/widgets/design13_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design13Controller extends GetxController {
  List<dynamic> csvData = [];
  List<Widget> dataItems = [];
  Map<String, dynamic> dumyData = {
    'value1': 'GSM / CDMA / HSPA / EVDO / LTE / 5G',
    'value2': 'GSM / CDMA / HSPA / EVDO / LTE / 5G',
    'value3': 'GSM / CDMA / HSPA / EVDO / LTE / 5G',
    'name': 'Technology',
    'icon': 'https://i.postimg.cc/gctGny2D/image.png',
    'pic':
        'https://t4.ftcdn.net/jpg/02/44/43/69/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg',
  };

  TextEditingController title = TextEditingController();
  TextEditingController logo1 = TextEditingController();
  TextEditingController name1 = TextEditingController();
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
  double flagWidth = 50;
  double flagPosition = 10;
  double IconsSpacing = 25;
  double topSpacing = 25;
  double spacingBetween = 25;
  double IconPosition = 25;
  int itemsPerScreen = 4;
  int currentIndex = 0;

  TextAlign subTitleTextAlign = TextAlign.center;

  TextStyle subTitleTextStyle = GoogleFonts.russoOne(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: halfBlack,
  );

  TextStyle valueTextStyle = GoogleFonts.russoOne(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: halfBlack,
  );

  TextAlign valueTextAlign = TextAlign.left;
  double valueContainerShadowRadius = 3;
  double valueContainerWidth = 600;
  double valueContainerSpacing = 20;
  Color valueFontColor = halfBlack;
  Color valueContainerLeft = HexColor('#919191');
  Color valueContainerRight = HexColor('#919191');
  Color valueContainerShadow1 = Colors.transparent;
  Color valueContainerShadow2 = Colors.transparent;
  Color valueContainerAnimation = Colors.blue;
  double picContainerSize = 50;
  double picContainerRadius = 8;
  double dataContainerHeight = Get.height * 0.7;
  double dataContainerSpacing = 5;
  double dataContainerWidth = 500;

  double nameTopSpacing = 15;
  double nameTextSize = 40;
  Color nameContainerColor = halfBlack;
  Color nameFontColor = whiteColor;
  TextAlign nameTextAlign = TextAlign.center;
  TextStyle nameTextStyle = GoogleFonts.russoOne(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  double titleFontSize = 65;
  Color titleFontColor = halfBlack;

  double subtitleFontSize = 33;
  Color subtitleFontColor = halfBlack;

  Color backgroundColor = whiteColor;
  LinearGradient backgroundGradient = LinearGradient(
    colors: [whiteColor, whiteColor],
  );
  double backgroundImageOpacity = 5;
  double textShadowOpacity = 5;
  Color shadowColor = halfBlack;

  List<Widget> itemsList = [];
  int animationGap = 5;
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
    dataItems = [];
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
        currentIndex = i;
        dataItems.add(
          Design13Item(
            key: Key(getRandomString(30)),
            itemData: csvData[i],
            index: i,
          ),
        );
        await Future.delayed(Duration(seconds: animationGap));
        update();
        scrollToBottom(1);
      }
    }
    update();
  }
}
