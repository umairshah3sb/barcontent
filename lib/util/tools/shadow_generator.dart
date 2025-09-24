import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ShadowGeneratorScreen extends StatefulWidget {
  final Function(List<BoxShadow>) onApply;
  String text;

  ShadowGeneratorScreen({
    Key? key,
    required this.onApply,
    required this.text,
  }) : super(key: key);

  @override
  _ShadowGeneratorScreenState createState() => _ShadowGeneratorScreenState();
}

class _ShadowGeneratorScreenState extends State<ShadowGeneratorScreen> {
  // Store the current shadows (initially empty)
  List<BoxShadow> _shadows = [
    const BoxShadow(
      color: Colors.transparent,
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  // Show shadow generator dialog
  Future<void> _showShadowGeneratorDialog(BuildContext context) async {
    final List<BoxShadow>? result = await showDialog<List<BoxShadow>>(
      context: context,
      builder: (context) {
        // Temporary shadow properties for dialog
        double tempOffsetX = 0.0;
        double tempOffsetY = 4.0;
        double tempBlurRadius = 8.0;
        double tempSpreadRadius = 2.0;
        Color tempShadowColor = Colors.black.withOpacity(0.2);

        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Generate temporary shadow for preview
            final tempShadow = BoxShadow(
              color: tempShadowColor,
              offset: Offset(tempOffsetX, tempOffsetY),
              blurRadius: tempBlurRadius,
              spreadRadius: tempSpreadRadius,
            );

            // Generate code snippet for display
            String getShadowCode() {
              return '''BoxShadow(
  color: Color(0x${tempShadowColor.value.toRadixString(16).padLeft(8, '0')}),
  offset: Offset(${tempOffsetX.toStringAsFixed(2)}, ${tempOffsetY.toStringAsFixed(2)}),
  blurRadius: ${tempBlurRadius.toStringAsFixed(2)},
  spreadRadius: ${tempSpreadRadius.toStringAsFixed(2)},
)''';
            }

            return AlertDialog(
              title: const Text('Customize Shadow'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Preview
                    Container(
                      width: 200,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [tempShadow],
                      ),
                      child: const Center(
                        child: Text(
                          'Preview Card',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Offset X Slider
                    Text('Offset X: ${tempOffsetX.toStringAsFixed(1)}'),
                    Slider(
                      value: tempOffsetX,
                      min: -20.0,
                      max: 20.0,
                      divisions: 80,
                      label: tempOffsetX.toStringAsFixed(1),
                      onChanged: (value) {
                        setDialogState(() {
                          tempOffsetX = value;
                        });
                      },
                    ),
                    // Offset Y Slider
                    Text('Offset Y: ${tempOffsetY.toStringAsFixed(1)}'),
                    Slider(
                      value: tempOffsetY,
                      min: -20.0,
                      max: 20.0,
                      divisions: 80,
                      label: tempOffsetY.toStringAsFixed(1),
                      onChanged: (value) {
                        setDialogState(() {
                          tempOffsetY = value;
                        });
                      },
                    ),
                    // Blur Radius Slider
                    Text('Blur Radius: ${tempBlurRadius.toStringAsFixed(1)}'),
                    Slider(
                      value: tempBlurRadius,
                      min: 0.0,
                      max: 50.0,
                      divisions: 100,
                      label: tempBlurRadius.toStringAsFixed(1),
                      onChanged: (value) {
                        setDialogState(() {
                          tempBlurRadius = value;
                        });
                      },
                    ),
                    // Spread Radius Slider
                    Text(
                        'Spread Radius: ${tempSpreadRadius.toStringAsFixed(1)}'),
                    Slider(
                      value: tempSpreadRadius,
                      min: -10.0,
                      max: 20.0,
                      divisions: 60,
                      label: tempSpreadRadius.toStringAsFixed(1),
                      onChanged: (value) {
                        setDialogState(() {
                          tempSpreadRadius = value;
                        });
                      },
                    ),
                    // Color Picker
                    const Text('Shadow Color'),
                    const SizedBox(height: 8),
                    ColorPicker(
                      pickerColor: tempShadowColor,
                      onColorChanged: (color) {
                        setDialogState(() {
                          tempShadowColor = color;
                        });
                      },
                      enableAlpha: true,
                      displayThumbColor: true,
                      pickerAreaHeightPercent: 0.7,
                    ),
                    // Code Output
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: SelectableText(
                        getShadowCode(),
                        style: const TextStyle(
                            fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Return a List<BoxShadow> with the configured shadow
                    Navigator.pop(context, [
                      BoxShadow(
                        color: tempShadowColor,
                        offset: Offset(tempOffsetX, tempOffsetY),
                        blurRadius: tempBlurRadius,
                        spreadRadius: tempSpreadRadius,
                      ),
                    ]);
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );

    // Call onApply with the returned shadows
    if (result != null) {
      setState(() {
        _shadows = result;
      });
      widget.onApply(result); // Invoke the onApply callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _showShadowGeneratorDialog(context),
        child: Container(
          width: 200,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _shadows,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
