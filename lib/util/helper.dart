import 'dart:io';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

Color diamondColor = Colors.red;
Color diamondColorWithShade = Colors.red.shade900;
String domainUrl =
    true ? 'https://novabuildr.com/' : 'https://contentcreator-9774f.web.app/';
Widget gap({double h = 0, double w = 0}) {
  return SizedBox(
    width: w,
    height: h,
  );
}

Color darken(Color color, [double amount = .1]) {
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
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
  // Warm Flame: #ff9a9e → #fad0c4
  LinearGradient(
    colors: [Color(0xFFff9a9e), Color(0xFFfad0c4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Night Fade: #a18cd1 → #fbc2eb
  LinearGradient(
    colors: [Color(0xFFa18cd1), Color(0xFFfbc2eb)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Spring Warmth: #fad0c4 → #ffd1ff
  LinearGradient(
    colors: [Color(0xFFfad0c4), Color(0xFFffd1ff)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Juicy Peach: #ffecd2 → #fcb69f
  LinearGradient(
    colors: [Color(0xFFffecd2), Color(0xFFfcb69f)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Young Passion: Many colors
  LinearGradient(
    colors: [
      Color(0xFFff8177),
      Color(0xFFff867a),
      Color(0xFFff8c7f),
      Color(0xFFf99185),
      Color(0xFFcf556c),
      Color(0xFFb12a5b)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Lady Lips: #ff9a9e → #fecfef
  LinearGradient(
    colors: [Color(0xFFff9a9e), Color(0xFFfecfef)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Sunny Morning: #f6d365 → #fda085
  LinearGradient(
    colors: [Color(0xFFf6d365), Color(0xFFfda085)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Rainy Ashville: #fbc2eb → #a6c1ee
  LinearGradient(
    colors: [Color(0xFFfbc2eb), Color(0xFFa6c1ee)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Frozen Dreams: #fdcbf1 → #e6dee9
  LinearGradient(
    colors: [Color(0xFFfdcbf1), Color(0xFFe6dee9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Winter Neva: #a1c4fd → #c2e9fb
  LinearGradient(
    colors: [Color(0xFFa1c4fd), Color(0xFFc2e9fb)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Dusty Grass: #d4fc79 → #96e6a1
  LinearGradient(
    colors: [Color(0xFFd4fc79), Color(0xFF96e6a1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Tempting Azure: #84fab0 → #8fd3f4
  LinearGradient(
    colors: [Color(0xFF84fab0), Color(0xFF8fd3f4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Heavy Rain: #cfd9df → #e2ebf0
  LinearGradient(
    colors: [Color(0xFFcfd9df), Color(0xFFe2ebf0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Amy Crisp: #a6c0fe → #f68084
  LinearGradient(
    colors: [Color(0xFFa6c0fe), Color(0xFFf68084)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Mean Fruit: #fccb90 → #d57eeb
  LinearGradient(
    colors: [Color(0xFFfccb90), Color(0xFFd57eeb)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Deep Blue: #e0c3fc → #8ec5fc
  LinearGradient(
    colors: [Color(0xFFe0c3fc), Color(0xFF8ec5fc)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Ripe Malinka: #f093fb → #f5576c
  LinearGradient(
    colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Cloudy Knoxville: #fdfbfb → #ebedee
  LinearGradient(
    colors: [Color(0xFFfdfbfb), Color(0xFFebedee)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Malibu Beach: #4facfe → #00f2fe
  LinearGradient(
    colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // New Life: #43e97b → #38f9d7
  LinearGradient(
    colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // True Sunset: #fa709a → #fee140
  LinearGradient(
    colors: [Color(0xFFfa709a), Color(0xFFfee140)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Morpheus Den: #30cfd0 → #330867
  LinearGradient(
    colors: [Color(0xFF30cfd0), Color(0xFF330867)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Rare Wind: #a8edea → #fed6e3
  LinearGradient(
    colors: [Color(0xFFa8edea), Color(0xFFfed6e3)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Near Moon: #5ee7df → #b490ca
  LinearGradient(
    colors: [Color(0xFF5ee7df), Color(0xFFb490ca)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Wild Apple: #d299c2 → #fef9d7
  LinearGradient(
    colors: [Color(0xFFd299c2), Color(0xFFfef9d7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Saint Petersburg: #f5f7fa → #c3cfe2
  LinearGradient(
    colors: [Color(0xFFf5f7fa), Color(0xFFc3cfe2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Arielle's Smile: Many colors
  LinearGradient(
    colors: [Color(0xFF16d9e3), Color(0xFF30c7ec), Color(0xFF46aef7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Plum Plate: #667eea → #764ba2
  LinearGradient(
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Everlasting Sky: #fdfcfb → #e2d1c3
  LinearGradient(
    colors: [Color(0xFFfdfcfb), Color(0xFFe2d1c3)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Happy Fisher: #89f7fe → #66a6ff
  LinearGradient(
    colors: [Color(0xFF89f7fe), Color(0xFF66a6ff)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Blessing: #fddb92 → #d1fdff
  LinearGradient(
    colors: [Color(0xFFfddb92), Color(0xFFd1fdff)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Sharpeye Eagle: #9890e3 → #b1f4cf
  LinearGradient(
    colors: [Color(0xFF9890e3), Color(0xFFb1f4cf)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Ladoga Bottom: #ebc0fd → #d9ded8
  LinearGradient(
    colors: [Color(0xFFebc0fd), Color(0xFFd9ded8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Lemon Gate: #96fbc4 → #f9f586
  LinearGradient(
    colors: [Color(0xFF96fbc4), Color(0xFFf9f586)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Itmeo Branding: #2af598 → #009efd
  LinearGradient(
    colors: [Color(0xFF2af598), Color(0xFF009efd)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Zeus Miracle: #cd9cf2 → #f6f3ff
  LinearGradient(
    colors: [Color(0xFFcd9cf2), Color(0xFFf6f3ff)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Old Hat: Many colors
  LinearGradient(
    colors: [
      Color(0xFFf093fb),
      Color(0xFFf5576c),
      Color(0xFFde6262),
      Color(0xFFffb88c)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Star Wine: Many colors
  LinearGradient(
    colors: [
      Color(0xFFe0c3fc),
      Color(0xFF8ec5fc),
      Color(0xFFa1c4fd),
      Color(0xFFc2e9fb)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Deep Blue: #6a11cb → #2575fc
  LinearGradient(
    colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Coup de Grace: Many colors
  LinearGradient(
    colors: [
      Color(0xFF43e97b),
      Color(0xFF38f9d7),
      Color(0xFF4facfe),
      Color(0xFF00f2fe)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Happy Acid: #37ecba → #72afd3
  LinearGradient(
    colors: [Color(0xFF37ecba), Color(0xFF72afd3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Awesome Pine: #ebbba7 → #cfc7f8
  LinearGradient(
    colors: [Color(0xFFebbba7), Color(0xFFcfc7f8)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // New York: #fff1eb → #ace0f9
  LinearGradient(
    colors: [Color(0xFFfff1eb), Color(0xFFace0f9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Shy Rainbow: Many colors
  LinearGradient(
    colors: [
      Color(0xFFfa709a),
      Color(0xFFfee140),
      Color(0xFFf6d365),
      Color(0xFFfda085)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Loon Crest: Many colors
  LinearGradient(
    colors: [
      Color(0xFFfbc2eb),
      Color(0xFFa6c1ee),
      Color(0xFF84fab0),
      Color(0xFF8fd3f4)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Mixed Hopes: #c471f5 → #fa71cd
  LinearGradient(
    colors: [Color(0xFFc471f5), Color(0xFFfa71cd)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Fly High: #48c6ef → #6f86d6
  LinearGradient(
    colors: [Color(0xFF48c6ef), Color(0xFF6f86d6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Strong Bliss: Many colors
  LinearGradient(
    colors: [
      Color(0xFF30cfd0),
      Color(0xFF330867),
      Color(0xFF5ee7df),
      Color(0xFFb490ca)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Fresh Milk: #feada6 → #f5efef
  LinearGradient(
    colors: [Color(0xFFfeada6), Color(0xFFf5efef)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Snow Again: #e6e9f0 → #eef1f5
  LinearGradient(
    colors: [Color(0xFFe6e9f0), Color(0xFFeef1f5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // February Ink: #accbee → #e7f0fd
  LinearGradient(
    colors: [Color(0xFFaccbee), Color(0xFFe7f0fd)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Kind Steel: #e9defa → #fbfcdb
  LinearGradient(
    colors: [Color(0xFFe9defa), Color(0xFFfbfcdb)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Soft Grass: #c1dfc4 → #deecdd
  LinearGradient(
    colors: [Color(0xFFc1dfc4), Color(0xFFdeecdd)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Grown Early: #0ba360 → #3cba92
  LinearGradient(
    colors: [Color(0xFF0ba360), Color(0xFF3cba92)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Sharp Blues: #00c6fb → #005bea
  LinearGradient(
    colors: [Color(0xFF00c6fb), Color(0xFF005bea)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Shady Water: #74ebd5 → #9face6
  LinearGradient(
    colors: [Color(0xFF74ebd5), Color(0xFF9face6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Dirty Beauty: #6a85b6 → #bac8e0
  LinearGradient(
    colors: [Color(0xFF6a85b6), Color(0xFFbac8e0)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Great Whale: #a3bded → #6991c7
  LinearGradient(
    colors: [Color(0xFFa3bded), Color(0xFF6991c7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Teen Notebook: #9795f0 → #fbc8d4
  LinearGradient(
    colors: [Color(0xFF9795f0), Color(0xFFfbc8d4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Polite Rumors: #a7a6cb → #8989ba
  LinearGradient(
    colors: [Color(0xFFa7a6cb), Color(0xFF8989ba)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Sweet Period: Many colors
  LinearGradient(
    colors: [
      Color(0xFFf093fb),
      Color(0xFFf5576c),
      Color(0xFFde6262),
      Color(0xFFffb88c)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
];

const List<Color> BrightColors = [
  Color(0xFF44F707), // Green
  Color(0xFF740081), // DarkPinK
  Color(0xFFFED60A), // Yellow
  Color(0xFFFB0007), // Red
  Color(0xFF3700FF), // Blue
  Color(0xFFFB13F3), // Pink
  Color(0xFFF9A704), // DarkPinK
  Color(0xFF033f63), // DarkPinK
  Color(0xFF8ec186), // DarkPinK
  Colors.deepOrange,
];

Color getColorForIndex(int index) {
  return BrightColors[index % 10];
}
