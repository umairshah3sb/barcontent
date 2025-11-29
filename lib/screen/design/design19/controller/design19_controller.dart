import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';

class Design19Controller extends GetxController {
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
  double barDepth = 18.0;
  double barWidth = 275.0;
  double spaceBetween = 50;
  Color barColor = Colors.orange;

  //bar data------------------->

  bool isGenerating = false;
  bool showAll = false;
  bool enableScroll = false;
  bool showBackgroundGradient = false;
  double backgroundImageOpacity = 5;

  double picContainerWidth = 230;
  double picBottomSpace = 195;

  double nameContainerWidth = 230;
  double nameContainerPadding = 5;
  double nameContainerRadius = 5;
  double nameTopSpacing = 5;
  String nameFontFamily = 'Russo One';
  Color nameFontColor = halfBlack;
  Color nameBGColor = Colors.transparent;
  TextAlign nameTextAlign = TextAlign.center;
  TextStyle nameStyle = GoogleFonts.manrope(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  double valueContainerWidth = 230;
  double valueContainerPadding = 5;
  double valueContainerRadius = 5;

  double valueTopSpacing = 0;
  String valueFontFamily = 'Russo One';
  Color valueFontColor = halfBlack;
  Color valueBGColor = Colors.transparent;
  TextAlign valueTextAlign = TextAlign.center;
  TextStyle valueStyle = GoogleFonts.manrope(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  double nameTextSize = 20;
  int animationGap = 30;
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

  updateFlow() async {
    await Future.delayed(Duration(seconds: 5));
    isGenerating = true;
    update();
  }
}
