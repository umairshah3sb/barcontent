import 'dart:async';
import 'package:barcontent/screen/design/design6/widgets/design6_item.dart';
import 'package:barcontent/screen/design/design7/widgets/design7_item.dart';
import 'package:barcontent/screen/design/design8/widgets/design8_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';

class Design8Controller extends GetxController {
  List<dynamic> csvData = [];
  Map<String, dynamic> dumyData = {
    'value1': '180',
    'value2': '170',
    'name': 'Nuclear Warheads',
    'pic':
        'https://t4.ftcdn.net/jpg/02/44/43/69/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg',
  };

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
  int currentIndex = 0;

  double valueFontSize = 16;
  double valueContainerSize = 150;
  Color valueFontColor = halfBlack;
  Color valueContainerLeft = HexColor('#919191');
  Color valueContainerRight = HexColor('#919191');
  Color valueContainerAnimation = Colors.blue;
  double picContainerSize = 100;
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
  double textShadowOpacity = 5;

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

    // final maxScroll = scrollController.position.maxScrollExtent;
    // scrollController.animateTo(
    //   maxScroll,
    //   duration: Duration(seconds: sec),
    //   curve: Curves.easeInOut,
    // );
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
        itemsList.add(Design8Item(
          data: csvData[i],
        ));
        update();
        scrollToBottom(200);
      }
    }
    update();
  }
}
