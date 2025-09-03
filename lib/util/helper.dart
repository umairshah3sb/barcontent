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

pushNamedRoute(String route) {
  Navigator.of(Get.context!).pushNamed(route);
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
  'Russo One',
  'Alfa Slab One',
  'Roboto',
  'Genos',
  'Saira',
  'Anton',
  'Lobster',
  'Changa One',
  'Rowdies',
  'Lilita One',
  'Rubik Mono One',
  'Oleo Script',
  'Bebas Neue',
  'Oswald',
  'Archivo Black',
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

final List<Color> colorList = [
  Color(0x00000000),
  Color(0xFF000000),
  Color(0xFFFFFF00),
  Color(0xFFFFA500),
  Color(0xFF00FF00),
  Color(0xFF0000FF),
  Color(0xFFFFC1CC),
  Color(0xFF800080),
  // 1. The Carefree Life: Bright & Positive Colors (Airbnb)
  Color(0xFFA7C7E7), // Pale Sky Blue
  Color(0xFF8B4513), // Earthy Brown
  Color(0xFFFF6B6B), // Wild Watermelon (Pink)

  // 2. Navy Blue (Adobe)
  Color(0xFF000080), // Navy Blue
  Color(0xFF000000), // Black
  Color(0xFFFF0000), // Red
  Color(0xFF0000FF), // Blue

  // 3. Orange Zest (Amazon)
  Color(0xFFFFA500), // Orange
  Color(0xFFFFFFFF), // White
  Color(0xFF000000), // Black

  // 4. Grey & Green – The Technology of Health (Dove)
  Color(0xFF008000), // Green
  Color(0xFF808080), // City Grey

  // 5. Seaside Blue
  Color(0xFF87CEEB), // Soft Blue
  Color(0xFFF4A460), // Golden Sand

  // 6. Red is for Christmas (Coca-Cola)
  Color(0xFFFF0000), // Red
  Color(0xFF40826D), // Viridian Green

  // 7. Less is More – White Color Pallets (Dropbox)
  Color(0xFFD3D3D3), // Grey Pale
  Color(0xFF1E90FF), // Vivid Blue
  Color(0xFFFFFFFF), // White

  // 8. Honey Yellow
  Color(0xFFFFC107), // Honey Yellow

  // 9. Carnival Dance (Durex)
  Color(0xFF0000FF), // Blue
  Color(0xFF800080), // Purple
  Color(0xFFFF1493), // Deep Pink
  Color(0xFF00008B), // Dark Blue

  // 10. Fresh New Day (Colgate)
  Color(0xFFADD8E6), // Light Blue
  Color(0xFF00FF00), // Green
  Color(0xFFFFFFFF), // White
  Color(0xFFFF0000), // Red

  // 11. The Contrasting Couple (ESPN+)
  Color(0xFFFFFF00), // Yellow
  Color(0xFF000000), // Black

  // 12. Sprouting Time (Heineken)
  Color(0xFF008000), // Crusoe Green
  Color(0xFFFF0000), // Red

  // 13. Red Rose Bouquet
  Color(0xFFFF0000), // Daring Red
  Color(0xFFDDA0DD), // Plum Mauve
  Color(0xFF000000), // Black

  // 14. Cozy Little Space (IKEA)
  Color(0xFFD3D3D3), // Light Grey
  Color(0xFF9400D3), // Vivid Violet

  // 15. Sunny Days (Lego)
  Color(0xFFFFFF00), // Yellow

  // 16. Delicate Pastels (Louis Vuitton)
  Color(0xFFFFD1DC), // Pastel Pink
  Color(0xFFAEC6CF), // Pastel Blue

  // 17. Exotic Island
  Color(0xFFFFFF00), // Vivid Yellow
  Color(0xFFFF4500), // Tropical Orange
  Color(0xFF87CEEB), // Sky Blue

  // 18. Rose Sensuality (Maybelline)
  Color(0xFF3F598E), // Mona Lisa (corrected from document's typo #3F5998E)
  Color(0xFFB16774), // Turkish Rose
  Color(0xFF00008B), // Dark Blue
  Color(0xFF000000), // Black

  // 19. Somewhere Over the Rainbow (Milka)
  Color(0xFFD8BFD8), // Light Purple
  Color(0xFF0000FF), // Blue
  Color(0xFF008000), // Green
  Color(0xFF808080), // Grey

  // 20. Playful Colors (Purina)
  Color(0xFFB0E0E6), // Pale Blue
  Color(0xFFFFFFFF), // White
  Color(0xFFFF69B4), // Pink

  // 21. Primary Colors: Red, Blue, and Yellow (Google Cloud)
  Color(0xFFFF0000), // Red
  Color(0xFF0000FF), // Blue
  Color(0xFFFFFF00), // Yellow
  Color(0xFFFFFFFF), // White

  // 22. Mountain Sky View: Blue Palette (Mini Auto)
  Color(0xFF0000FF), // Blue
  Color(0xFF00008B), // Dark Blue

  // 23. Nude Pink Palette
  Color(0xFFFFC1CC), // Nude Pink

  // 24. White in Compositions
  Color(0xFFFFFFFF), // White

  // 25. Love at First Sight (Nutella)
  Color(0xFFFF0000), // Red
  Color(0xFF000000), // Black
  Color(0xFFFFFFFF), // White
  Color(0xFFD3D3D3), // Light Grey

  // 26. Orange & Blue Palette
  Color(0xFFFFA500), // Orange
  Color(0xFF0000FF), // Blue

  // 27. Summer Sea (Pampers)
  Color(0xFF40E0D0), // Turquoise
  Color(0xFFB0E0E6), // Pale Blue
  Color(0xFFC2B280), // Sandy Grey

  // 28. Milk & Honey (Pantene)
  Color(0xFFEAC87C), // Marzipan
  Color(0xFF000000), // Black
  Color(0xFFFFFFFF), // White
  Color(0xFFD3D3D3), // Light Grey

  // 29. Blue Sea
  Color(0xFF008B8B), // Dark Cyan
  Color(0xFFB0C4DE), // Light Steel Blue

  // 30. Shades of Desire – Shades of Red (Pizza Hut)
  Color(0xFFFF0000), // Red
  Color(0xFFFFFFFF), // White

  // 31. Lavender Fields Under the Starry Sky (Samsung)
  Color(0xFFE0B0FF), // Mauve
  Color(0xFF4B0082), // Indigo

  // 32. Caramel Indulgence – Shades of Brown (Snickers)
  Color(0xFF8B4513), // Brown
  Color(0xFFFF0000), // Red
  Color(0xFFFFFFFF), // White

  // 33. Luscious Red
  Color(0xFFFF0000), // Luscious Red
  Color(0xFFFFD700), // Golden Yellow
  Color(0xFF000000), // Black

  // 34. Tropical Vacation (Starbucks)
  Color(0xFFFF4500), // Orange Persimmon
  Color(0xFF228B22), // Leafy Green
  Color(0xFFD3D3D3), // Pale Grey
  Color(0xFF8B4513), // Earthy Brown

  // 35. Countryside Footpaths (UPS)
  Color(0xFF8B4513), // Raw Brown
  Color(0xFF00008B), // Dark Blue
  Color(0xFFB0C4DE), // Pale Bluish Grey

  // 36. This Jolly Couple
  Color(0xFFFF4500), // Crimson Orange
  Color(0xFFFF7F50), // Coral
  Color(0xFF0000FF), // Blue

  // 37. Midnight Sky (Visa)
  Color(0xFF191970), // Midnight Blue
  Color(0xFFFFFF00), // Yellow
  Color(0xFFFFFFFF), // White

  // 38. Marshmallow Pastels (Tiguan)
  Color(0xFFFFD1DC), // Pastel Pink
  Color(0xFF4682B4), // Metallic Blue

  // 39. Blue & Brown Color Palette
  Color(0xFF0000FF), // Blue
  Color(0xFF8B4513), // Brown
  Color(0xFFFFFACD), // Soft Yellow

  // 40. Ocean Deep Blue (Yahoo)
  Color(0xFF00008B), // Dark Blue
  Color(0xFF0077B6), // Mediterranean Blue
  Color(0xFF4B0082), // Indigo
];
