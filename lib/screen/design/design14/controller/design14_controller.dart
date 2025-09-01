import 'dart:async';
import 'package:barcontent/screen/design/design14/widgets/design14_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design14Controller extends GetxController {
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
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  bool isGenerating = false;
  bool enableScroll = false;
  bool allowScroll = true;
  bool changeStyle = false;
  bool showBackgroundGradient = false;
  double logoSize = 250;
  double aspectRatio = 9 / 16;
  double logoRadius = 10;
  double flagWidth = 20;
  double flagPosition = 10;
  double IconsSpacing = 25;
  double topSpacing = 25;
  double spacingBetween = 5;
  double IconPosition = 25;
  int itemsPerScreen = 4;
  int currentIndex = 0;

  TextAlign subTitleTextAlign = TextAlign.center;

  TextStyle subTitleTextStyle = GoogleFonts.russoOne(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: halfBlack,
  );

  TextStyle valueTextStyle = GoogleFonts.russoOne(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: halfBlack,
  );

  TextAlign valueTextAlign = TextAlign.left;
  double valueContainerShadowRadius = 3;
  double valueContainerWidth = 175;
  double valueContainerHeight = 340;
  double valueContainerSpacing = 1;
  Color valueFontColor = halfBlack;
  Color valueContainerLeft = HexColor('#919191');
  Color valueContainerRight = HexColor('#919191');
  Color valueContainerShadow1 = Colors.transparent;
  Color valueContainerShadow2 = Colors.transparent;
  Color valueContainerAnimation = Colors.blue;
  double picContainerSize = 20;
  double picContainerRadius = 8;
  double dataContainerHeight = 340;
  double dataContainerSpacing = 5;
  double dataContainerWidth = 155;

  double nameTopSpacing = 15;
  double nameTextSize = 14;
  Color nameContainerColor = halfBlack;
  Color nameFontColor = whiteColor;
  TextAlign nameTextAlign = TextAlign.center;
  TextStyle nameTextStyle = GoogleFonts.russoOne(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  double titleFontSize = 30;
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
          Design14Item(
            key: Key(getRandomString(30)),
            itemData: csvData[i],
            index: i,
          ),
        );
        await Future.delayed(Duration(seconds: animationGap));
        update();
      }
      if (allowScroll) {
        scrollToBottom(7);
      }
    }
    update();
  }
}
