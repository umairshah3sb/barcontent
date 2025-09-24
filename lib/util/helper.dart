import 'dart:io';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

String domainUrl = true
    ? 'https://videocreator.novabuildr.com/'
    : 'https://contentcreator-9774f.web.app/';
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

Map<String, dynamic> dumy17Data = {
  'index': '1',
  'pic': 'https://contentcreator-9774f.web.app/assets/assets/flags/us.svg',
  'icon': 'https://i.postimg.cc/Y9dmW0MH/image.png',
  'name': 'USA',
  'tagline': 'GDP',
  'largeText': '\$30',
  'smallText': 'Trillion',
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
  Function()? increase,
  Function()? decrease,
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
          Row(
            children: [
              value > max
                  ? gap()
                  : Slider(
                      max: max,
                      value: value,
                      onChanged: onChanged,
                    ),
              gap(w: 10),
              InkWell(
                onTap: increase,
                child: Icon(
                  Icons.keyboard_arrow_up_sharp,
                  color: halfBlack,
                  size: 18,
                ),
              ),
              gap(w: 5),
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
  Color(0x00000000), // Transparent
  Color(0xFF000000), // Black
  Color(0xFFFFFF00), // Yellow
  Color(0xFFFFA500), // Orange
  Color(0xFF00FF00), // Green
  Color(0xFF0000FF), // Blue
  Color(0xFFFFC1CC), // Nude Pink
  Color(0xFF800080), // Purple
  Color(0xFFA166E4), // Unique purple shade
  Color(0xFFE6A93E),
  Color(0xFFA7C7E7), // Pale Sky Blue
  Color(0xFF8B4513), // Earthy Brown
  Color(0xFFFF6B6B), // Wild Watermelon (Pink)
  Color(0xFF000080), // Navy Blue
  Color(0xFFFFFFFF), // White
  Color(0xFF008000), // Crusoe Green
  Color(0xFF808080), // City Grey
  Color(0xFF87CEEB), // Soft Blue
  Color(0xFFF4A460), // Golden Sand
  Color(0xFF40826D), // Viridian Green
  Color(0xFFD3D3D3), // Light Grey
  Color(0xFF1E90FF), // Vivid Blue
  Color(0xFFFFC107), // Honey Yellow
  Color(0xFFFF1493), // Deep Pink
  Color(0xFF00008B), // Dark Blue
  Color(0xFFADD8E6), // Light Blue
  Color(0xFFDDA0DD), // Plum Mauve
  Color(0xFF9400D3), // Vivid Violet
  Color(0xFFFFD1DC), // Pastel Pink
  Color(0xFFAEC6CF), // Pastel Blue
  Color(0xFFFF4500), // Tropical Orange
  Color(0xFF3F598E), // Mona Lisa
  Color(0xFFB16774), // Turkish Rose
  Color(0xFFD8BFD8), // Light Purple
  Color(0xFFB0E0E6), // Pale Blue
  Color(0xFFFF69B4), // Pink
  Color(0xFF40E0D0), // Turquoise
  Color(0xFFC2B280), // Sandy Grey
  Color(0xFFEAC87C), // Marzipan
  Color(0xFF008B8B), // Dark Cyan
  Color(0xFFB0C4DE), // Light Steel Blue
  Color(0xFFE0B0FF), // Mauve
  Color(0xFF4B0082), // Indigo
  Color(0xFFFFD700), // Golden Yellow
  Color(0xFF228B22), // Leafy Green
  Color(0xFF191970), // Midnight Blue
  Color(0xFF4682B4), // Metallic Blue
  Color(0xFFFFFACD), // Soft Yellow
  Color(0xFF0077B6), // Mediterranean Blue
  Color(0xFFFF7F50), // Coral
];

// List of 32 color palettes with their corresponding gradients
// Each gradient uses a 147° angle as specified
const double gradientAngle =
    147 * math.pi / 180; // Convert 147 degrees to radians

List<LinearGradient> colorPalettes = [
  // 1. Orange, green, purple, orange
  LinearGradient(
    colors: [
      Color(0xFFFF6200),
      Color(0xFF00FF00),
      Color(0xFF800080),
      Color(0xFFFF6200)
    ],
    transform: GradientRotation(gradientAngle),
  ),
  // 2. Blue, pink, orange
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFFFFC1CC), Color(0xFFFF6200)],
    transform: GradientRotation(gradientAngle),
  ),
  // 3. Blue, green, purple
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFF00FF00), Color(0xFF800080)],
    transform: GradientRotation(gradientAngle),
  ),
  // 4. Blue, orange
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFFFF6200)],
    transform: GradientRotation(gradientAngle),
  ),
  // 5. Green
  LinearGradient(
    colors: [Color(0xFF00FF00), Color(0xFF006400)],
    transform: GradientRotation(gradientAngle),
  ),
  // 6. Skin, pastel, pink
  LinearGradient(
    colors: [Color(0xFFF5CBA7), Color(0xFFFFE4E1), Color(0xFFFFC1CC)],
    transform: GradientRotation(gradientAngle),
  ),
  // 7. Blue, purple, pink
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFF800080), Color(0xFFFFC1CC)],
    transform: GradientRotation(gradientAngle),
  ),
  // 8. Green
  LinearGradient(
    colors: [Color(0xFF00FF00), Color(0xFF228B22)],
    transform: GradientRotation(gradientAngle),
  ),
  // 9. Green, orange, red, blue
  LinearGradient(
    colors: [
      Color(0xFF00FF00),
      Color(0xFFFF6200),
      Color(0xFFFF0000),
      Color(0xFF0000FF)
    ],
    transform: GradientRotation(gradientAngle),
  ),
  // 10. Grey
  LinearGradient(
    colors: [Color(0xFF808080), Color(0xFFD3D3D3)],
    transform: GradientRotation(gradientAngle),
  ),
  // 11. Blue, yellow, green, orange
  LinearGradient(
    colors: [
      Color(0xFF0000FF),
      Color(0xFFFFFF00),
      Color(0xFF00FF00),
      Color(0xFFFF6200)
    ],
    transform: GradientRotation(gradientAngle),
  ),
  // 12. Black, blue, pink
  LinearGradient(
    colors: [Color(0xFF000000), Color(0xFF0000FF), Color(0xFFFFC1CC)],
    transform: GradientRotation(gradientAngle),
  ),
  // 13. Green, purple, pink, orange
  LinearGradient(
    colors: [
      Color(0xFF00FF00),
      Color(0xFF800080),
      Color(0xFFFFC1CC),
      Color(0xFFFF6200)
    ],
    transform: GradientRotation(gradientAngle),
  ),
  // 14. Orange, purple, blue
  LinearGradient(
    colors: [Color(0xFFFF6200), Color(0xFF800080), Color(0xFF0000FF)],
    transform: GradientRotation(gradientAngle),
  ),
  // 15. Blue, purple, pink
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFF800080), Color(0xFFFFC1CC)],
    transform: GradientRotation(gradientAngle),
  ),
  // 16. Orange, yellow, blue
  LinearGradient(
    colors: [Color(0xFFFF6200), Color(0xFFFFFF00), Color(0xFF0000FF)],
    transform: GradientRotation(gradientAngle),
  ),
  // 17. Blue, orange, green
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFFFF6200), Color(0xFF00FF00)],
    transform: GradientRotation(gradientAngle),
  ),
  // 18. Green, blue
  LinearGradient(
    colors: [Color(0xFF00FF00), Color(0xFF0000FF)],
    transform: GradientRotation(gradientAngle),
  ),
  // 19. Pink, purple, blue
  LinearGradient(
    colors: [Color(0xFFFFC1CC), Color(0xFF800080), Color(0xFF0000FF)],
    transform: GradientRotation(gradientAngle),
  ),
  // 20. Blue
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFF4682B4)],
    transform: GradientRotation(gradientAngle),
  ),
  // 21. Purple, pink
  LinearGradient(
    colors: [Color(0xFF800080), Color(0xFFFFC1CC)],
    transform: GradientRotation(gradientAngle),
  ),
  // 22. Green, yellow, orange
  LinearGradient(
    colors: [Color(0xFF00FF00), Color(0xFFFFFF00), Color(0xFFFF6200)],
    transform: GradientRotation(gradientAngle),
  ),
  // 23. Orange, yellow, pink
  LinearGradient(
    colors: [Color(0xFFFF6200), Color(0xFFFFFF00), Color(0xFFFFC1CC)],
    transform: GradientRotation(gradientAngle),
  ),
  // 24. Blue, green
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFF00FF00)],
    transform: GradientRotation(gradientAngle),
  ),
  // 25. Brown, blue
  LinearGradient(
    colors: [Color(0xFF8B4513), Color(0xFF0000FF)],
    transform: GradientRotation(gradientAngle),
  ),
  // 26. Green, maroon, orange
  LinearGradient(
    colors: [Color(0xFF00FF00), Color(0xFF800000), Color(0xFFFF6200)],
    transform: GradientRotation(gradientAngle),
  ),
  // 27. Blue, red, orange
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFFFF0000), Color(0xFFFF6200)],
    transform: GradientRotation(gradientAngle),
  ),
  // 28. Blue, red, orange
  LinearGradient(
    colors: [Color(0xFF0000FF), Color(0xFFFF0000), Color(0xFFFF6200)],
    transform: GradientRotation(gradientAngle),
  ),
  // 29. Grey
  LinearGradient(
    colors: [Color(0xFF808080), Color(0xFFA9A9A9)],
    transform: GradientRotation(gradientAngle),
  ),
  // 30. Pastel blue, purple, pink
  LinearGradient(
    colors: [Color(0xFFADD8E6), Color(0xFFDDA0DD), Color(0xFFFFC1CC)],
    transform: GradientRotation(gradientAngle),
  ),
  // 31. Pink, orange, green
  LinearGradient(
    colors: [Color(0xFFFFC1CC), Color(0xFFFF6200), Color(0xFF00FF00)],
    transform: GradientRotation(gradientAngle),
  ),
  // 32. Green, yellow, red, purple
  LinearGradient(
    colors: [
      Color(0xFF00FF00),
      Color(0xFFFFFF00),
      Color(0xFFFF0000),
      Color(0xFF800080)
    ],
    transform: GradientRotation(gradientAngle),
  ),
];
