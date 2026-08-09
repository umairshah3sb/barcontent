import 'dart:async';
import 'package:barcontent/screen/design/design15/controller/design15_controller.dart';
import 'package:barcontent/screen/design/design15/widgets/design15_item.dart';
import 'package:barcontent/util/app_routes.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/font_family_selector.dart';
import 'package:barcontent/util/helper.dart';
import 'package:barcontent/util/meta_data_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gradient_picker/flutter_gradient_picker.dart';

class Design15 extends StatefulWidget {
  const Design15({super.key});

  @override
  State<Design15> createState() => _Design15State();
}

class _Design15State extends State<Design15> {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final Design15Controller designController = Get.put(Design15Controller());
  TextEditingController videoTimer = TextEditingController();

  // NEW: lets the user paste raw CSV text instead of only picking a file.
  TextEditingController csvPasteController = TextEditingController();
  bool showCsvPaste = false;

  // NEW: which template layout is active — 0, 1, or 2.
  int selectedTemplate = 0;

  double containerSize = 360;
  bool cacheImages = false;
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      maxScroll,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    videoTimer.dispose();
    csvPasteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      drawer: drawerWidget(),
      key: _Key,
      body: GetBuilder<Design15Controller>(
        builder: (controller) {
          return Stack(
            children: [
              Positioned(
                right: 50,
                top: 0,
                bottom: 0,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: controller.aspectRatio,
                    child: Container(
                      height: (Get.height - 200),
                      width: containerSize,
                      decoration: BoxDecoration(
                        gradient: controller.backgroundGradient,
                      ),
                      child: controller.backgroundImage.text.isNotEmpty
                          ? Opacity(
                              opacity: (controller.backgroundImageOpacity / 10),
                              child: Image.network(
                                controller.backgroundImage.text,
                                fit: BoxFit.cover,
                              ),
                            )
                          : gap(),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 50,
                top: 0,
                bottom: 0,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: controller.aspectRatio,
                    child: Container(
                      width: containerSize,
                      height: Get.height,
                      padding: spacing(h: controller.VideoContainerSpacingH),
                      child: Column(
                        children: [
                          gap(h: 10),
                          Container(
                            alignment: Alignment.center,
                            margin: spacing(v: 10),
                            padding: spacing(h: 15),
                            child: Text(
                              controller.title.text,
                              style: GoogleFonts.getFont(
                                controller.titleFontFamily,
                                fontWeight: FontWeight.bold,
                                color: controller.titleFontColor,
                                fontSize: controller.titleFontSize,
                                shadows: [
                                  Shadow(
                                    color: controller.shadowColor.withAlpha(
                                      (255 *
                                              (controller.textShadowOpacity /
                                                  10))
                                          .toInt(),
                                    ),
                                    offset: Offset.zero,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Design15MainUI(
                            itemData: controller.csvData.isEmpty
                                ? controller.dumyData
                                : controller.csvData[controller.currentIndex],
                            key: Key(getRandomString(20)),
                          ),
                          gap(h: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              controller.isGenerating
                  ? gap()
                  : Positioned(
                      top: 15,
                      left: 15,
                      child: InkWell(
                        onTap: () {
                          _Key.currentState!.openDrawer();
                          setState(() {});
                        },
                        child: Container(
                          padding: spacing(h: 7, v: 7),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: borderRadius(50),
                            boxShadow: shadow,
                          ),
                          child: Icon(Icons.menu, color: halfBlack, size: 25),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------
  // CSV handling — shared parser used by both "choose file" and the
  // new "paste CSV" flow.
  // ---------------------------------------------------------------
  List<Map<String, dynamic>> _parseCsv(String csvString) {
    List<List<dynamic>> data = const CsvToListConverter().convert(csvString);
    List<Map<String, dynamic>> dataAsMap = [];

    if (data.isNotEmpty) {
      List<String> headers = data.first
          .map((e) => e.toString().trim())
          .toList();

      for (int i = 1; i < data.length; i++) {
        if (data[i].every((cell) => cell.toString().trim().isEmpty)) continue;
        Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length; j++) {
          row[headers[j]] = j < data[i].length ? data[i][j] : '';
        }
        dataAsMap.add(row);
      }
    }
    return dataAsMap;
  }

  Future<void> pickAndReadCsv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      String csvString = utf8.decode(fileBytes);
      final parsed = _parseCsv(csvString);

      if (parsed.isEmpty) {
        _showSnack('That file has no readable rows.', isError: true);
        return;
      }

      setState(() {
        designController.csvData = parsed;
      });
      _showSnack('Loaded ${parsed.length} rows from file.');
    }
  }

  // NEW: parse whatever is in the paste box and load it as csvData.
  void loadPastedCsv() {
    final text = csvPasteController.text.trim();
    if (text.isEmpty) {
      _showSnack('Paste some CSV data first.', isError: true);
      return;
    }

    try {
      final parsed = _parseCsv(text);
      if (parsed.isEmpty) {
        _showSnack('Could not find any data rows in that text.', isError: true);
        return;
      }
      setState(() {
        designController.csvData = parsed;
      });
      _showSnack('Loaded ${parsed.length} rows from pasted CSV.');
    } catch (e) {
      _showSnack('Could not parse that CSV: $e', isError: true);
    }
  }

  // ---------------------------------------------------------------
  // Template switcher — just changes an index (0, 1, 2). Nothing
  // else about colors/styling is touched here.
  // ---------------------------------------------------------------
  void _selectTemplate(int index) {
    selectedTemplate = index;

    if (selectedTemplate == 2) {
      designController.valueFontSize = 25;
      designController.picHMargin = 0;
      designController.picVMargin = 0;
      designController.flagContainerWidth = 220;
      designController.flagContainerHeight = 140;
      designController.valueContainerPosition = 210;
      designController.picContainerWidth = 450;
      designController.picContainerHeight = 260;
      designController.valueContainerPosition = 230;
      designController.picVgap = 60;
    }

    // TODO: point this at whatever actually decides which template
    // renders in the preview / export (e.g. swap Design15MainUI for
    // Design16MainUI / Design17MainUI based on `index`, or set a
    // `designController.templateIndex` field if you add one).
    designController.templateIndex = index;
    designController.update();

    setState(() {});
  }

  void _showSnack(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : darkBlue,
        behavior: SnackBarBehavior.floating,
        margin: spacing(h: 16, v: 16),
        shape: RoundedRectangleBorder(borderRadius: borderRadius(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ---------------------------------------------------------------
  // Reusable, professional-looking building blocks for the panel.
  // ---------------------------------------------------------------

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
    Widget? trailing,
  }) {
    return Container(
      width: double.infinity,
      margin: spacing(v: 8),
      padding: spacing(h: 16, v: 16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius(18),
        border: Border.all(color: halfBlack.withOpacity(0.08)),
        boxShadow: shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: spacing(h: 8, v: 8),
                decoration: BoxDecoration(
                  color: darkBlue.withOpacity(0.1),
                  borderRadius: borderRadius(10),
                ),
                child: Icon(icon, size: 16, color: darkBlue),
              ),
              gap(w: 10),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: halfBlack,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: halfBlack.withOpacity(0.08)),
          ),
          Wrap(spacing: 12, runSpacing: 12, children: children),
        ],
      ),
    );
  }

  Widget _labeledInput({
    required String label,
    required TextEditingController controller,
    String? hint,
    ValueChanged<String>? onChanged,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: halfBlack.withOpacity(0.7),
            ),
          ),
          gap(h: 6),
          Container(
            height: 46,
            padding: spacing(h: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: borderRadius(12),
              border: Border.all(color: halfBlack.withOpacity(0.15)),
            ),
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: hint ?? 'Enter $label',
                border: InputBorder.none,
                hintStyle: GoogleFonts.manrope(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: halfBlack.withOpacity(0.4),
                ),
              ),
              style: GoogleFonts.manrope(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: halfBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      width: 280,
      padding: spacing(h: 14, v: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: borderRadius(12),
        border: Border.all(color: halfBlack.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: halfBlack,
              ),
            ),
          ),
          Switch(value: value, onChanged: onChanged, activeColor: darkBlue),
        ],
      ),
    );
  }

  Widget _primaryButton({
    required String label,
    required VoidCallback onTap,
    IconData? icon,
    Color? color,
  }) {
    return InkWell(
      borderRadius: borderRadius(12),
      onTap: onTap,
      child: Container(
        padding: spacing(h: 18, v: 12),
        decoration: BoxDecoration(
          color: color ?? darkBlue,
          borderRadius: borderRadius(12),
          boxShadow: shadow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: whiteColor),
              gap(w: 8),
            ],
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _secondaryButton({
    required String label,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return InkWell(
      borderRadius: borderRadius(12),
      onTap: onTap,
      child: Container(
        padding: spacing(h: 16, v: 11),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: borderRadius(12),
          border: Border.all(color: darkBlue.withOpacity(0.4), width: 1.4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: darkBlue),
              gap(w: 8),
            ],
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _templateButton(int index) {
    final bool selected = selectedTemplate == index;

    return Expanded(
      child: InkWell(
        borderRadius: borderRadius(14),
        onTap: () => _selectTemplate(index),
        child: Container(
          height: 52,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: selected ? darkBlue : const Color(0xFFF7F8FA),
            borderRadius: borderRadius(14),
            border: Border.all(
              width: selected ? 2 : 1,
              color: selected ? darkBlue : halfBlack.withOpacity(0.2),
            ),
          ),
          child: Center(
            child: Text(
              'Template ${index + 1}',
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: selected ? whiteColor : halfBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _templateSection() {
    return _sectionCard(
      title: 'Template',
      icon: Icons.grid_view_rounded,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              _templateButton(0),
              _templateButton(1),
              _templateButton(2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _aspectChip(String label, double ratio) {
    final bool selected = designController.aspectRatio == ratio;
    return InkWell(
      borderRadius: borderRadius(14),
      onTap: () {
        designController.aspectRatio = ratio;
        designController.update();
        setState(() {});
      },
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: selected ? darkBlue : const Color(0xFFF7F8FA),
          border: Border.all(
            width: 1.4,
            color: selected ? darkBlue : halfBlack.withOpacity(0.2),
          ),
          borderRadius: borderRadius(14),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: selected ? whiteColor : halfBlack,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // The drawer / control panel itself
  // ---------------------------------------------------------------
  Widget drawerWidget() {
    return Container(
      width: Get.width * 0.42,
      height: Get.height,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F7),
        borderRadius: radiusOnly(topRight: 24, bottomRight: 24),
      ),
      child: Column(
        children: [
          // Panel header
          Container(
            width: double.infinity,
            padding: spacing(h: 20, v: 18),
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: radiusOnly(topRight: 24),
            ),
            child: Row(
              children: [
                Icon(Icons.tune_rounded, color: whiteColor, size: 20),
                gap(w: 10),
                Expanded(
                  child: Text(
                    'Design Settings',
                    style: GoogleFonts.manrope(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: whiteColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Icon(Icons.close_rounded, color: whiteColor, size: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: spacing(h: 14, v: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _templateSection(),
                  _importDataSection(),
                  _textContentSection(),
                  _teamSection(),
                  _layoutSection(),
                  _valueStylingSection(),
                  _backgroundAndShadowSection(),
                  _borderSection(),
                  _aspectRatioSection(),
                  gap(h: 10),
                  _actionButtons(),
                  gap(h: 20),
                  _csvColumnHelp(),
                  gap(h: 20),
                  Text(
                    '*  When "Different pic" is on, each row needs pic1 and pic2 — pic can be left empty in that case.',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: halfBlack.withOpacity(0.6),
                    ),
                  ),
                  gap(h: 20),
                  if (cacheImages) _cachePreview(),
                  gap(h: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---- Section: Import Data (file picker + paste CSV) ----
  Widget _importDataSection() {
    return _sectionCard(
      title: 'Import Data',
      icon: Icons.upload_file_rounded,
      children: [
        Row(
          children: [
            _primaryButton(
              label: 'Choose CSV File',
              icon: Icons.folder_open_rounded,
              onTap: pickAndReadCsv,
            ),
            gap(w: 10),
            _secondaryButton(
              label: showCsvPaste ? 'Hide Paste Box' : 'Paste CSV Instead',
              icon: Icons.content_paste_rounded,
              onTap: () {
                setState(() {
                  showCsvPaste = !showCsvPaste;
                });
              },
            ),
          ],
        ),
        if (showCsvPaste)
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paste CSV text (first row = headers)',
                  style: GoogleFonts.manrope(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: halfBlack.withOpacity(0.7),
                  ),
                ),
                gap(h: 6),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FA),
                    borderRadius: borderRadius(12),
                    border: Border.all(color: halfBlack.withOpacity(0.15)),
                  ),
                  padding: spacing(h: 14, v: 10),
                  child: TextFormField(
                    controller: csvPasteController,
                    maxLines: 6,
                    minLines: 4,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: halfBlack,
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText:
                          'name,pic,value1,value2\nPakistan,https://...,2627,4201\n...',
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: halfBlack.withOpacity(0.35),
                      ),
                    ),
                  ),
                ),
                gap(h: 10),
                Row(
                  children: [
                    _primaryButton(
                      label: 'Load Pasted CSV',
                      icon: Icons.check_circle_outline_rounded,
                      onTap: loadPastedCsv,
                    ),
                    gap(w: 10),
                    if (csvPasteController.text.isNotEmpty)
                      _secondaryButton(
                        label: 'Clear',
                        icon: Icons.close_rounded,
                        onTap: () {
                          setState(() {
                            csvPasteController.clear();
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        if (designController.csvData.isNotEmpty)
          Container(
            width: double.infinity,
            padding: spacing(h: 12, v: 10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.08),
              borderRadius: borderRadius(10),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.green, size: 16),
                gap(w: 8),
                Text(
                  '${designController.csvData.length} rows loaded',
                  style: GoogleFonts.manrope(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.green.shade800,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ---- Section: Title / Verse / Animation ----
  Widget _textContentSection() {
    return _sectionCard(
      title: 'Text Content',
      icon: Icons.title_rounded,
      children: [
        _labeledInput(
          label: 'Animation Gap',
          controller: videoTimer,
          hint: 'Enter animation gap (seconds)',
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
        ),
        _labeledInput(
          label: 'Verse Image URL',
          controller: designController.verserImage,
          onChanged: (x) => setState(() {}),
        ),
        _labeledInput(
          label: 'Title',
          controller: designController.title,
          onChanged: (x) => setState(() {}),
        ),
        _labeledInput(
          label: 'Background Image URL',
          controller: designController.backgroundImage,
          onChanged: (v) => designController.update(),
        ),
        FontFamilyDropdown(
          text: 'Title Font Family',
          onFontSelected: (font) {
            designController.titleFontFamily = font;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.titleFontSize,
          max: 200,
          title: 'Title Font Size: ${designController.titleFontSize.toInt()}',
          onChanged: (value) {
            designController.titleFontSize = value;
            designController.update();
            setState(() {});
          },
        ),
        ColorPickerItem(
          hintText: 'Title Text Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.titleFontColor,
              onChange: (color) {
                designController.titleFontColor = color;
                designController.update();
              },
            );
          },
          currentColor: designController.titleFontColor,
        ),
      ],
    );
  }

  // ---- Section: Names / Logos / Country styling ----
  Widget _teamSection() {
    return _sectionCard(
      title: 'Names & Logos',
      icon: Icons.groups_rounded,
      children: [
        _labeledInput(
          label: 'Name 1',
          controller: designController.name1,
          onChanged: (x) => setState(() {}),
        ),
        _labeledInput(
          label: 'Logo 1 URL',
          controller: designController.logo1,
          onChanged: (x) => setState(() {}),
        ),
        _labeledInput(
          label: 'Name 2',
          controller: designController.name2,
          onChanged: (x) => setState(() {}),
        ),
        _labeledInput(
          label: 'Logo 2 URL',
          controller: designController.logo2,
          onChanged: (x) => setState(() {}),
        ),
        FontFamilyDropdown(
          text: 'Name Font Family',
          onFontSelected: (font) {
            designController.nameFontFamily = font;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.nameTextSize,
          max: 200,
          title: 'Name Font Size: ${designController.nameTextSize.toInt()}',
          onChanged: (value) {
            designController.nameTextSize = value;
            designController.update();
            setState(() {});
          },
        ),
        ColorPickerItem(
          hintText: 'Name Font Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.nameFontColor,
              onChange: (color) {
                designController.nameFontColor = color;
                designController.update();
              },
            );
          },
          currentColor: designController.nameFontColor,
        ),
        FontFamilyDropdown(
          text: 'Country Font Family',
          onFontSelected: (font) {
            designController.countryFontFamily = font;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.countryNameFontSize,
          max: 200,
          title:
              'Country Font Size: ${designController.countryNameFontSize.toInt()}',
          onChanged: (value) {
            designController.countryNameFontSize = value;
            designController.update();
            setState(() {});
          },
        ),
        ColorPickerItem(
          hintText: 'Country Name Text Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.countryNameFontColor,
              onChange: (color) {
                designController.countryNameFontColor = color;
                designController.update();
              },
            );
          },
          currentColor: designController.countryNameFontColor,
        ),
      ],
    );
  }

  // ---- Section: Picture / logo sizing, video container, layout style ----
  Widget _layoutSection() {
    return _sectionCard(
      title: 'Layout & Picture',
      icon: Icons.dashboard_customize_rounded,
      children: [
        FontSizer(
          hintText: 'Logo Radius',
          fontSize: designController.logoRadius.toInt(),
          increase: () {
            designController.logoRadius++;
            designController.update();
            setState(() {});
          },
          decrease: () {
            designController.logoRadius--;
            designController.update();
            setState(() {});
          },
        ),
        FontSizer(
          hintText: 'Logo Size',
          fontSize: designController.logoSize.toInt(),
          increase: () {
            designController.logoSize++;
            designController.update();
            setState(() {});
          },
          decrease: () {
            designController.logoSize--;
            designController.update();
            setState(() {});
          },
        ),
        FontSizer(
          hintText: 'Data Container Size',
          fontSize: designController.valueContainerSize.toInt(),
          increase: () {
            designController.valueContainerSize++;
            designController.update();
            setState(() {});
          },
          decrease: () {
            designController.valueContainerSize--;
            designController.update();
            setState(() {});
          },
        ),
        FontSizer(
          hintText: 'Data Container Spacing',
          fontSize: designController.dataContainerSpacing.toInt(),
          increase: () {
            designController.dataContainerSpacing++;
            designController.update();
            setState(() {});
          },
          decrease: () {
            designController.dataContainerSpacing--;
            designController.update();
            setState(() {});
          },
        ),
        FontSizer(
          hintText: 'Data Container Width',
          fontSize: designController.dataContainerWidth.toInt(),
          increase: () {
            designController.dataContainerWidth++;
            designController.update();
            setState(() {});
          },
          decrease: () {
            designController.dataContainerWidth--;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.VideoContainerSpacingH,
          max: 150,
          title:
              'Video Container Horizontal Padding: ${designController.VideoContainerSpacingH.toInt()}',
          onChanged: (value) {
            designController.VideoContainerSpacingH = value;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.VideoContainerHeight,
          max: 1200,
          title:
              'Video Container Height: ${designController.VideoContainerHeight.toInt()}',
          onChanged: (value) {
            designController.VideoContainerHeight = value;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.flagContainerWidth,
          max: 1000,
          title:
              'Flag Container Width: ${designController.flagContainerWidth.toInt()}',
          onChanged: (value) {
            designController.flagContainerWidth = value;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.flagContainerHeight,
          max: 1000,
          title:
              'Flag Container Height: ${designController.flagContainerHeight.toInt()}',
          onChanged: (value) {
            designController.flagContainerHeight = value;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.picHMargin,
          max: 200,
          title:
              'Pic Horizontal Margin: ${designController.picHMargin.toInt()}',
          onChanged: (value) {
            designController.picHMargin = value;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.picVMargin,
          max: 200,
          title: 'Pic Vertical Margin: ${designController.picVMargin.toInt()}',
          onChanged: (value) {
            designController.picVMargin = value;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.picVgap,
          max: 200,
          title: 'Pic Vertical Gap: ${designController.picVgap.toInt()}',
          onChanged: (value) {
            designController.picVgap = value;
            designController.update();
            setState(() {});
          },
        ),
        ColorPickerItem(
          hintText: 'Pic Container Background Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.picBackground,
              onChange: (color) {
                designController.picBackground = color;
                designController.update();
              },
            );
          },
          currentColor: designController.picBackground,
        ),
        if (designController.templateIndex == 2)
          NewValueSlider(
            value: designController.picContainerWidth,
            max: 1000,
            title:
                'Pic Container Width: ${designController.picContainerWidth.toInt()}',
            onChanged: (value) {
              designController.picContainerWidth = value;
              designController.update();
              setState(() {});
            },
          ),
        if (designController.templateIndex == 2)
          NewValueSlider(
            value: designController.picContainerHeight,
            max: 1000,
            title:
                'Pic Container Height: ${designController.picContainerHeight.toInt()}',
            onChanged: (value) {
              designController.picContainerHeight = value;
              designController.update();
              setState(() {});
            },
          ),
        FontSizer(
          hintText: 'Pic Container Radius',
          fontSize: designController.picContainerRadius.toInt(),
          increase: () {
            designController.picContainerRadius++;
            designController.update();
            setState(() {});
          },
          decrease: () {
            designController.picContainerRadius--;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.vsImageWidth,
          max: 300,
          title: 'VS Image Width: ${designController.vsImageWidth.toInt()}',
          onChanged: (value) {
            designController.vsImageWidth = value;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.vsImageSpaceLeft,
          max: 300,
          title:
              'VS Image Spacing Left: ${designController.vsImageSpaceLeft.toInt()}',
          onChanged: (value) {
            designController.vsImageSpaceLeft = value;
            designController.update();
            setState(() {});
          },
        ),
        gap(h: 4),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _toggleRow(
              label: 'Different Pic',
              value: designController.differencePic,
              onChanged: (value) {
                designController.differencePic = value;
                setState(() {});
              },
            ),
            _toggleRow(
              label: 'No Pic',
              value: designController.noPic,
              onChanged: (value) {
                designController.noPic = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  // ---- Section: Value styling ----
  Widget _valueStylingSection() {
    return _sectionCard(
      title: 'Value Styling',
      icon: Icons.format_size_rounded,
      children: [
        NewValueSlider(
          value: designController.valueContainerPosition,
          max: 1200,
          title:
              'Value Container Position: ${designController.valueContainerPosition.toInt()}',
          onChanged: (value) {
            designController.valueContainerPosition = value;
            designController.update();
            setState(() {});
          },
        ),

        NewValueSlider(
          value: designController.valueContainerHSpacing,
          max: 1200,
          title:
              'Value Container H Spacing: ${designController.valueContainerHSpacing.toInt()}',
          onChanged: (value) {
            designController.valueContainerHSpacing = value;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.valueWidth,
          max: 1200,
          title: 'Value Width: ${designController.valueWidth.toInt()}',
          onChanged: (value) {
            designController.valueWidth = value;
            designController.update();
            setState(() {});
          },
        ),
        FontFamilyDropdown(
          text: 'Value Font Family',
          onFontSelected: (font) {
            designController.valueFontFamily = font;
            designController.update();
            setState(() {});
          },
        ),
        NewValueSlider(
          value: designController.valueFontSize,
          max: 200,
          title: 'Value Font Size: ${designController.valueFontSize.toInt()}',
          onChanged: (value) {
            designController.valueFontSize = value;
            designController.update();
            setState(() {});
          },
        ),
        ColorPickerItem(
          hintText: 'Value Container Animation Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.valueContainerAnimation,
              onChange: (color) {
                designController.valueContainerAnimation = color;
                designController.update();
              },
            );
          },
          currentColor: designController.valueContainerAnimation,
        ),
        ColorPickerItem(
          hintText: 'Value Container Left Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.valueContainerLeft,
              onChange: (color) {
                designController.valueContainerLeft = color;
                designController.update();
              },
            );
          },
          currentColor: designController.valueContainerLeft,
        ),
        ColorPickerItem(
          hintText: 'Value Container Right Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.valueContainerRight,
              onChange: (color) {
                designController.valueContainerRight = color;
                designController.update();
              },
            );
          },
          currentColor: designController.valueContainerRight,
        ),
        ColorPickerItem(
          hintText: 'Value Text Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.valueFontColor,
              onChange: (color) {
                designController.valueFontColor = color;
                designController.update();
              },
            );
          },
          currentColor: designController.valueFontColor,
        ),
      ],
    );
  }

  // ---- Section: Background + shadows ----
  Widget _backgroundAndShadowSection() {
    return _sectionCard(
      title: 'Background & Shadows',
      icon: Icons.gradient_rounded,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Text(
                'Background Gradient',
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: halfBlack,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  designController.showBackgroundGradient =
                      !designController.showBackgroundGradient;
                  designController.update();
                  setState(() {});
                },
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    gradient: designController.backgroundGradient,
                    borderRadius: borderRadius(8),
                    border: Border.all(color: halfBlack.withOpacity(0.2)),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (designController.showBackgroundGradient)
          SizedBox(
            width: double.infinity,
            child: FlutterGradientPicker(
              onGradientChanged: (gradient) {
                designController.backgroundGradient = gradient;
                designController.update();
                setState(() {});
              },
            ),
          ),
        FontSizer(
          hintText: 'Background Image Opacity',
          fontSize: designController.backgroundImageOpacity.toInt(),
          increase: () {
            if (designController.backgroundImageOpacity <= 10) {
              designController.backgroundImageOpacity++;
              designController.update();
              setState(() {});
            }
          },
          decrease: () {
            if (designController.backgroundImageOpacity >= 0) {
              designController.backgroundImageOpacity--;
              designController.update();
              setState(() {});
            }
          },
        ),
        ColorPickerItem(
          hintText: 'Text Shadow Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.shadowColor,
              onChange: (color) {
                designController.shadowColor = color;
                designController.update();
              },
            );
          },
          currentColor: designController.shadowColor,
        ),
        FontSizer(
          hintText: 'Text Shadow Opacity',
          fontSize: designController.textShadowOpacity.toInt(),
          increase: () {
            if (designController.textShadowOpacity <= 10) {
              designController.textShadowOpacity++;
              designController.update();
              setState(() {});
            }
          },
          decrease: () {
            if (designController.textShadowOpacity >= 0) {
              designController.textShadowOpacity--;
              designController.update();
              setState(() {});
            }
          },
        ),
        ColorPickerItem(
          hintText: 'Flag Shadow Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.flagShadowColor,
              onChange: (color) {
                designController.flagShadowColor = color;
                designController.update();
              },
            );
          },
          currentColor: designController.flagShadowColor,
        ),
        FontSizer(
          hintText: 'Flag Shadow Opacity',
          fontSize: designController.flagShadowOpacity.toInt(),
          increase: () {
            if (designController.flagShadowOpacity <= 10) {
              designController.flagShadowOpacity++;
              designController.update();
              setState(() {});
            }
          },
          decrease: () {
            if (designController.flagShadowOpacity >= 0) {
              designController.flagShadowOpacity--;
              designController.update();
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  // ---- Section: Borders ----
  Widget _borderSection() {
    return _sectionCard(
      title: 'Borders',
      icon: Icons.border_style_rounded,
      children: [
        ColorPickerItem(
          hintText: 'Pic Border Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.picBorderColor,
              onChange: (color) {
                designController.picBorderColor = color;
                designController.update();
              },
            );
          },
          currentColor: designController.picBorderColor,
        ),
        FontSizer(
          hintText: 'Pic Border Size',
          fontSize: designController.picBorderSize.toInt(),
          increase: () {
            designController.picBorderSize++;
            designController.update();
            setState(() {});
          },
          decrease: () {
            designController.picBorderSize--;
            designController.update();
            setState(() {});
          },
        ),
        ColorPickerItem(
          hintText: 'Flag Border Color',
          pickerTap: () {
            colorPicker(
              currentColor: designController.flagBorderColor,
              onChange: (color) {
                designController.flagBorderColor = color;
                designController.update();
              },
            );
          },
          currentColor: designController.flagBorderColor,
        ),
        FontSizer(
          hintText: 'Flag Border Size',
          fontSize: designController.flagBorderSize.toInt(),
          increase: () {
            designController.flagBorderSize++;
            designController.update();
            setState(() {});
          },
          decrease: () {
            designController.flagBorderSize--;
            designController.update();
            setState(() {});
          },
        ),
      ],
    );
  }

  // ---- Section: Aspect ratio ----
  Widget _aspectRatioSection() {
    return _sectionCard(
      title: 'Aspect Ratio',
      icon: Icons.aspect_ratio_rounded,
      children: [
        Row(
          children: [
            _aspectChip('9/16', 9 / 16),
            gap(w: 8),
            _aspectChip('16/9', 16 / 9),
            gap(w: 8),
            _aspectChip('3/4', 3 / 4),
            gap(w: 8),
            _aspectChip('4/3', 4 / 3),
            gap(w: 8),
            _aspectChip('1/1', 1 / 1),
          ],
        ),
      ],
    );
  }

  // ---- Action buttons: Generate + Cache preview toggle ----
  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: _primaryButton(
            label: 'Generate',
            icon: Icons.play_arrow_rounded,
            onTap: () {
              designController.isGenerating = true;
              if (videoTimer.text.toString().isNotEmpty) {
                designController.animationGap = int.parse(
                  videoTimer.text.toString().trim(),
                );
              }
              designController.updateFlow();
              setState(() {});
            },
          ),
        ),
        gap(w: 12),
        Expanded(
          child: _secondaryButton(
            label: cacheImages ? 'Hide Preview' : 'Cache Images',
            icon: Icons.image_search_rounded,
            onTap: () {
              cacheImages = !cacheImages;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  // ---- Required CSV columns helper ----
  Widget _csvColumnHelp() {
    return _sectionCard(
      title: 'Required CSV Columns',
      icon: Icons.table_chart_rounded,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            tableItems('name'),
            tableItems('pic'),
            tableItems('pic1'),
            tableItems('pic2'),
            tableItems('value1'),
            tableItems('value2'),
          ],
        ),
      ],
    );
  }

  // ---- Cache / preview list ----
  Widget _cachePreview() {
    return Container(
      height: Get.height * 0.4,
      padding: spacing(h: 12, v: 12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius(16),
        border: Border.all(color: halfBlack.withOpacity(0.08)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(designController.csvData.length, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: borderRadius(8),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: CachedNetworkImage(
                        imageUrl: designController.differencePic
                            ? designController.csvData[index]['pic1']
                            : designController.csvData[index]['pic'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  gap(w: 10),
                  Icon(
                    Icons.compare_arrows_rounded,
                    size: 16,
                    color: halfBlack.withOpacity(0.4),
                  ),
                  gap(w: 10),
                  ClipRRect(
                    borderRadius: borderRadius(8),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: CachedNetworkImage(
                        imageUrl: designController.differencePic
                            ? designController.csvData[index]['pic2']
                            : designController.csvData[index]['pic'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  colorPicker({
    required Color currentColor,
    required Function(Color) onChange,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: borderRadius(16)),
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onChange,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                shape: RoundedRectangleBorder(borderRadius: borderRadius(10)),
              ),
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
