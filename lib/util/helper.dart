import 'dart:io';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget gap({double h = 0, double w = 0}) {
  return SizedBox(
    width: w,
    height: h,
  );
}

BorderRadius borderRadius(double radius) {
  return BorderRadius.all(Radius.circular(radius));
}

BorderRadius radiusOnly(
    {double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0}) {
  return BorderRadius.only(
    topLeft: Radius.circular(topLeft),
    topRight: Radius.circular(topRight),
    bottomLeft: Radius.circular(bottomLeft),
    bottomRight: Radius.circular(bottomRight),
  );
}

EdgeInsets spacing({double h = 0, double v = 0}) {
  return EdgeInsets.symmetric(horizontal: h, vertical: v);
}

pushRoute(Widget screen) {
  Navigator.of(Get.context!).push(
    MaterialPageRoute(builder: (context) => screen),
  );
}

pushReplacement(Widget screen) {
  Navigator.of(Get.context!).pushReplacement(
    MaterialPageRoute(builder: (context) => screen),
  );
}

popRoute() {
  Navigator.of(Get.context!).pop();
}

EdgeInsets spaceOnly(
    {double left = 0, double right = 0, double bottom = 0, double top = 0}) {
  return EdgeInsets.only(left: left, right: right, bottom: bottom, top: top);
}

Future<void> toastMessage(String msg) async {
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: darkBlue,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<File?> pickNewFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    return null;
  }
}

List<BoxShadow> shadow = [
  BoxShadow(
    color: Color(0x26442A7C),
    blurRadius: 28.68,
    offset: Offset(0, 28.68),
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0x26442A7C),
    blurRadius: 28.68,
    offset: Offset(0, 28.68),
    spreadRadius: 0,
  )
];

Map<String, dynamic> dumyData = {
  'index': '1',
  'avatar':
      'https://filmfare.wwmindia.com/content/2024/aug/amirkhan41723367644.jpg',
  'name': 'Aamir Khan',
  'role': 'actor',
  'largeText': '5',
  'smallText': 'cr per movie',
  'icon': 'https://static.thenounproject.com/png/7167-200.png',
};
Map<String, dynamic> design2Data = {
  'index': '1',
  'pic1':
      'https://filmfare.wwmindia.com/content/2024/aug/amirkhan41723367644.jpg',
  'pic2':
      'https://filmfare.wwmindia.com/content/2024/aug/amirkhan41723367644.jpg',
  'name': 'Aamir Khan',
  'largeText': '5',
  'smallText': 'cr per movie',
};
String getRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

Widget tableItems(String title) {
  return Container(
    padding: spacing(v: 5, h: 7),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: halfBlack,
      ),
    ),
    child: Text(title),
  );
}

colorPicker(
    {required Color currentColor,
    required Function(Color) onChange,
    required void Function()? onPressed}) {
  // create some values

  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: onChange,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Done'),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}

Widget FontSizer({
  String hintText = '',
  int fontSize = 45,
  required Function()? increase,
  required Function()? decrease,
}) {
  return Container(
    width: Get.width * 0.2,
    padding: spacing(h: 10, v: 2),
    decoration: BoxDecoration(
      border: Border.all(
        width: 2,
        color: halfBlack,
      ),
      borderRadius: borderRadius(7),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${hintText}: ${fontSize}'),
        Spacer(),
        Column(
          children: [
            InkWell(
              onTap: increase,
              child: Icon(
                Icons.keyboard_arrow_up_sharp,
                color: halfBlack,
                size: 18,
              ),
            ),
            gap(h: 5),
            InkWell(
              onTap: decrease,
              child: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: halfBlack,
                size: 18,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget ColorPickerItem({
  String hintText = '',
  void Function()? pickerTap,
  required Color currentColor,
}) {
  return Container(
    width: Get.width * 0.2,
    margin: spacing(v: 7),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${hintText}:'),
        Spacer(),
        InkWell(
          onTap: pickerTap,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: borderRadius(25),
              boxShadow: shadow,
            ),
          ),
        ),
      ],
    ),
  );
}

Color getRandomDarkColor() {
  final Random random = Random();
  return Color.fromARGB(
    255, // Full opacity
    random.nextInt(100), // Red (0-99)
    random.nextInt(100), // Green (0-99)
    random.nextInt(100), // Blue (0-99)
  );
}

Color getRandomColor() {
  return Color.fromRGBO(
    Random().nextInt(256), // Red (0-255)
    Random().nextInt(256), // Green (0-255)
    Random().nextInt(256), // Blue (0-255)
    1.0, // Opacity (1.0 for fully opaque)
  );
}

List<BoxShadow> newShadow = [
  BoxShadow(
      color: Colors.grey.shade300,
      spreadRadius: 0.0,
      blurRadius: 3,
      offset: Offset(3.0, 3.0)),
  BoxShadow(
      color: Colors.grey.shade400,
      spreadRadius: 0.0,
      blurRadius: 3 / 2.0,
      offset: Offset(3.0, 3.0)),
  BoxShadow(
      color: Colors.black.withAlpha(80),
      spreadRadius: 2.0,
      blurRadius: 3,
      offset: Offset(-3.0, -3.0)),
  BoxShadow(
      color: Colors.black.withAlpha(80),
      spreadRadius: 2.0,
      blurRadius: 3 / 2,
      offset: Offset(-3.0, -3.0)),
];

int getRandomValue({int minValue = 0}) {
  final Random random = Random();
  if (minValue != 257) {
    return minValue +
        random.nextInt((256 - minValue)); // Generates 0 to 256 inclusive
  }
  return random.nextInt(minValue); // Generates 0 to 256 inclusive
}

List<Color> generate100ColorShades() {
  final List<Color> colors = [];
  for (int i = 0; i < 30; i++) {
    final Color rgbaColor = Color.fromARGB(
        getRandomValue(), getRandomValue(), getRandomValue(), 255);

    colors.add(rgbaColor);
  }

  return colors;
}

List<String> fontFamilies = [
  'Russo+One',
  'Bebas Neue',
  'Futura',
  'Oswald'
  'Archivo Black',
  'Roboto',
  'San Francisco',
  'Helvetica',
  'Arial',
  'Times New Roman',
  'Courier New',
  'Georgia',
  'Verdana',
  'ABeeZee',
  
  'PT Sans',
  'PT Serif',
  'Proxima Nova',
  'JetBrains Mono',
  'Fira Code',
  'Source Code Pro',
];

Widget ValueChangeSlider({
  required String title,
  required void Function(double)? onChanged,
  required double value,
  double max = 430,
}) {
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      margin: spacing(v: 10),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.russoOne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: halfBlack,
            ),
          ),
          gap(h: 10),
          Slider(
            max: max,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  });
}

class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child; // Don’t wrap in a scrollbar
  }
}
