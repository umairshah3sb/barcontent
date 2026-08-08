// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SocialMediaPostDesignTool extends StatefulWidget {
  @override
  _SocialMediaPostDesignToolState createState() =>
      _SocialMediaPostDesignToolState();
}

class _SocialMediaPostDesignToolState extends State<SocialMediaPostDesignTool> {
  // ---------- Image data ----------
  Uint8List? _bgImageBytes;
  String? _bgImageUrl;
  Uint8List? _logoBytes;
  String? _logoUrl;

  // ---------- Watermark ----------
  bool _showWatermark = true;
  String _logoPosition = 'top-left';
  double _logoSize = 100;

  // ---------- Text content ----------
  final TextEditingController _textController = TextEditingController(
    text:
        'WINNING BID\nPKR 2,450,000.00\nMost Expensive\nFranchise in History!\nMultan Sultans Bought\nby MyTech!',
  );

  // ---------- Text styling ----------
  double _fontSize = 24;
  Color _textColor = Colors.white;
  String _fontFamily = 'Poppins';
  Color _highlightBg = Color(0xfffdbd22);
  Color _highlightText = Colors.black;
  double _lineSpacing = 8;

  // ---------- Gradient overlay ----------
  double _gradientHeight = 60; // percent
  double _gradientOpacity = 0.9;
  Color _gradientColor = Colors.black;

  // ---------- Layout ----------
  String _aspectRatio = '5/4'; // width/height as string (e.g. '5/4')
  double _canvasWidth = 600;
  double _textPaddingBottom = 30;
  double _textPaddingHorizontal = 30;

  // ---------- Available fonts ----------
  final List<String> _fonts = [
    'Inter',
    'Poppins',
    'Arial',
    'Impact',
    'Arial Black',
    'Montserrat',
    'Russo One',
    'Oswald',
    'Bebas Neue',
    'Anton',
    'Raleway',
    'League Spartan',
    'Archivo',
    'DM Sans',
    'Manrope',
    'Sora',
    'Urbanist',
    'Outfit',
  ];

  final ImagePicker _picker = ImagePicker();
  final GlobalKey _canvasKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Default gradient overlay
  }

  // ---------- Helper: parse text with *highlight* ----------
  List<InlineSpan> _parseText() {
    final lines = _textController.text.split('\n');
    final List<InlineSpan> spans = [];
    final textStyle = TextStyle(
      fontSize: _fontSize,
      color: _textColor,
      fontFamily: _fontFamily,
    );

    for (var line in lines) {
      if (line.trim().isEmpty) {
        spans.add(WidgetSpan(child: SizedBox(height: _lineSpacing)));
        continue;
      }

      if (line.contains('*')) {
        final parts = line.split('*');
        List<InlineSpan> lineSpans = [];
        for (int i = 0; i < parts.length; i++) {
          if (i.isOdd) {
            // Highlighted part
            lineSpans.add(
              WidgetSpan(
                child: Container(
                  color: _highlightBg,
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    parts[i],
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: _highlightText,
                      fontFamily: _fontFamily,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            );
          } else {
            if (parts[i].isNotEmpty) {
              lineSpans.add(TextSpan(text: parts[i]));
            }
          }
        }
        spans.addAll(lineSpans);
      } else {
        spans.add(TextSpan(text: line));
      }
      // Add line break with spacing
      spans.add(WidgetSpan(child: SizedBox(height: _lineSpacing)));
    }
    return spans;
  }

  // ---------- Update preview ----------
  void _updatePreview() => setState(() {});

  // ---------- Background image handlers ----------
  Future<void> _pickBackgroundImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _bgImageBytes = bytes;
        _bgImageUrl = null;
      });
    }
  }

  void _setBackgroundUrl(String url) {
    setState(() {
      _bgImageUrl = url;
      _bgImageBytes = null;
    });
  }

  // ---------- Logo handlers ----------
  Future<void> _pickLogo() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _logoBytes = bytes;
        _logoUrl = null;
      });
    }
  }

  void _setLogoUrl(String url) {
    setState(() {
      _logoUrl = url;
      _logoBytes = null;
    });
  }

  // ---------- Export image ----------
  Future<void> _exportImage() async {
    final boundary = _canvasKey.currentContext?.findRenderObject();
    if (boundary is RenderRepaintBoundary) {
      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        // save...
      }
    }
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Social Media Post Designer')),
      body: Row(
        children: [
          // Left panel - controls
          Container(
            width: 360,
            color: Colors.grey[900],
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Background image
                  _buildSection('📷 Background Image', [
                    _buildLabel('Upload image'),
                    ElevatedButton.icon(
                      onPressed: _pickBackgroundImage,
                      icon: Icon(Icons.image),
                      label: Text('Pick from gallery'),
                    ),
                    _buildLabel('Or image URL'),
                    TextField(
                      onSubmitted: _setBackgroundUrl,
                      decoration: InputDecoration(
                        hintText: 'https://...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),
                  SizedBox(height: 16),

                  // Watermark / Logo
                  _buildSection('🏷️ Watermark / Logo', [
                    _buildLabel('Upload logo'),
                    ElevatedButton.icon(
                      onPressed: _pickLogo,
                      icon: Icon(Icons.image),
                      label: Text('Pick from gallery'),
                    ),
                    _buildLabel('Or logo URL'),
                    TextField(
                      onSubmitted: _setLogoUrl,
                      decoration: InputDecoration(hintText: 'https://...'),
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _showWatermark,
                          onChanged: (v) => setState(() => _showWatermark = v!),
                        ),
                        Text(
                          'Show watermark',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    _buildLabel('Logo position'),
                    DropdownButton<String>(
                      value: _logoPosition,
                      dropdownColor: Colors.grey[800],
                      items:
                          [
                                'top-left',
                                'top-right',
                                'top-center',
                                'bottom-left',
                                'bottom-right',
                              ]
                              .map(
                                (p) =>
                                    DropdownMenuItem(value: p, child: Text(p)),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => _logoPosition = v!),
                    ),
                    _buildLabel('Logo size (px)'),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 30,
                            max: 300,
                            value: _logoSize,
                            onChanged: (v) => setState(() => _logoSize = v),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${_logoSize.round()}px',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(height: 16),

                  // Text content
                  _buildSection('✏️ Text Content', [
                    _buildLabel('Your text (use *text* for highlight)'),
                    TextField(
                      controller: _textController,
                      maxLines: 8,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter text...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      onChanged: (_) => _updatePreview(),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '💡 Wrap text in *asterisks* to add yellow background highlight',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ]),
                  SizedBox(height: 16),

                  // Text styling
                  _buildSection('🎨 Text Styling', [
                    _buildLabel('Font size'),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 14,
                            max: 60,
                            value: _fontSize,
                            onChanged: (v) => setState(() => _fontSize = v),
                          ),
                        ),
                        Text(
                          '${_fontSize.round()}px',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    _buildLabel('Text color'),
                    _buildColorPicker(_textColor, (c) => _textColor = c),
                    _buildLabel('Font family'),
                    DropdownButton<String>(
                      value: _fontFamily,
                      dropdownColor: Colors.grey[800],
                      items: _fonts
                          .map(
                            (f) => DropdownMenuItem(value: f, child: Text(f)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _fontFamily = v!),
                    ),
                    _buildLabel('Highlight background'),
                    _buildColorPicker(_highlightBg, (c) => _highlightBg = c),
                    _buildLabel('Highlight text color'),
                    _buildColorPicker(
                      _highlightText,
                      (c) => _highlightText = c,
                    ),
                    _buildLabel('Line spacing (px)'),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 0,
                            max: 30,
                            value: _lineSpacing,
                            onChanged: (v) => setState(() => _lineSpacing = v),
                          ),
                        ),
                        Text(
                          '${_lineSpacing.round()}px',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(height: 16),

                  // Gradient overlay
                  _buildSection('🎭 Gradient Overlay', [
                    _buildLabel('Gradient height (%)'),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 20,
                            max: 100,
                            value: _gradientHeight,
                            onChanged: (v) =>
                                setState(() => _gradientHeight = v),
                          ),
                        ),
                        Text(
                          '${_gradientHeight.round()}%',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    _buildLabel('Gradient opacity'),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 0,
                            max: 1,
                            divisions: 10,
                            value: _gradientOpacity,
                            onChanged: (v) =>
                                setState(() => _gradientOpacity = v),
                          ),
                        ),
                        Text(
                          _gradientOpacity.toStringAsFixed(1),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    _buildLabel('Gradient color'),
                    _buildColorPicker(
                      _gradientColor,
                      (c) => _gradientColor = c,
                    ),
                  ]),
                  SizedBox(height: 16),

                  // Layout settings
                  _buildSection('📐 Layout Settings', [
                    _buildLabel('Aspect ratio'),
                    DropdownButton<String>(
                      value: _aspectRatio,
                      dropdownColor: Colors.grey[800],
                      items: ['9/16', '4/5', '5/4', '1/1', '16/9', '3/4']
                          .map(
                            (r) => DropdownMenuItem(value: r, child: Text(r)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _aspectRatio = v!),
                    ),
                    _buildLabel('Canvas width (px)'),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 400,
                            max: 1080,
                            value: _canvasWidth,
                            onChanged: (v) => setState(() => _canvasWidth = v),
                          ),
                        ),
                        Text(
                          '${_canvasWidth.round()}px',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    _buildLabel('Text padding bottom (px)'),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 0,
                            max: 200,
                            value: _textPaddingBottom,
                            onChanged: (v) =>
                                setState(() => _textPaddingBottom = v),
                          ),
                        ),
                        Text(
                          '${_textPaddingBottom.round()}px',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    _buildLabel('Text padding horizontal (px)'),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 0,
                            max: 200,
                            value: _textPaddingHorizontal,
                            onChanged: (v) =>
                                setState(() => _textPaddingHorizontal = v),
                          ),
                        ),
                        Text(
                          '${_textPaddingHorizontal.round()}px',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(height: 20),

                  // Export button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _exportImage,
                      icon: Icon(Icons.download),
                      label: Text('EXPORT IMAGE'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right panel - canvas preview
          Expanded(
            child: Container(
              color: Colors.black,
              child: Center(
                child: RepaintBoundary(key: _canvasKey, child: _buildCanvas()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: build section with title
  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.indigo[300],
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey[400], fontSize: 12),
      ),
    );
  }

  // Simple color picker using flutter_colorpicker
  Widget _buildColorPicker(Color currentColor, Function(Color) onColorChanged) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Pick a color'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: onColorChanged,
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: currentColor,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  // Build the preview canvas
  Widget _buildCanvas() {
    // Parse aspect ratio
    final parts = _aspectRatio.split('/');
    final ratioW = double.parse(parts[0]);
    final ratioH = double.parse(parts[1]);
    final canvasHeight = _canvasWidth * (ratioH / ratioW);

    return Container(
      width: _canvasWidth,
      height: canvasHeight,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          if (_bgImageBytes != null)
            Image.memory(_bgImageBytes!, fit: BoxFit.cover)
          else if (_bgImageUrl != null && _bgImageUrl!.isNotEmpty)
            Image.network(
              _bgImageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey),
            )
          else
            Container(color: Colors.grey[850]),

          // Gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: (_gradientHeight / 100) * canvasHeight,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    _gradientColor.withOpacity(_gradientOpacity),
                    _gradientColor.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Watermark
          if (_showWatermark &&
              (_logoBytes != null ||
                  (_logoUrl != null && _logoUrl!.isNotEmpty)))
            Positioned(
              top: _logoPosition.contains('top') ? 20 : null,
              bottom: _logoPosition.contains('bottom') ? 20 : null,
              left: _logoPosition.contains('left') ? 20 : null,
              right: _logoPosition.contains('right') ? 20 : null,
              child: _logoPosition == 'top-center'
                  ? Center(child: _buildLogoImage())
                  : _buildLogoImage(),
            ),

          // Text overlay
          Positioned(
            bottom: _textPaddingBottom,
            left: _textPaddingHorizontal,
            right: _textPaddingHorizontal,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: _parseText()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoImage() {
    if (_logoBytes != null) {
      return Image.memory(_logoBytes!, width: _logoSize, fit: BoxFit.contain);
    } else if (_logoUrl != null) {
      return Image.network(_logoUrl!, width: _logoSize, fit: BoxFit.contain);
    }
    return SizedBox.shrink();
  }
}
