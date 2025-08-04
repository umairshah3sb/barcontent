import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class TextEditorScreen extends StatefulWidget {
  @override
  _TextEditorScreenState createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  TextStyle _textStyle = TextStyle(
    fontSize: 24,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  String _text = "Edit Me!";
  Color _shadowColor = Colors.black54;
  double _shadowBlur = 3.0;
  Offset _shadowOffset = Offset(2, 2);

  void _openTextEditor() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Edit Text Style",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),

                    // Font Size Slider
                    Row(
                      children: [
                        Text("Font Size:"),
                        Expanded(
                          child: Slider(
                            value: _textStyle.fontSize ?? 24,
                            min: 10,
                            max: 100,
                            onChanged: (val) {
                              setModalState(() {
                                _textStyle = _textStyle.copyWith(fontSize: val);
                              });
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    // Color Picker
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Text Color:"),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Pick a color"),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor:
                                          _textStyle.color ?? Colors.black,
                                      onColorChanged: (color) {
                                        setModalState(() {
                                          _textStyle =
                                              _textStyle.copyWith(color: color);
                                        });
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("Done"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: _textStyle.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Font Weight Selector
                    DropdownButton<FontWeight>(
                      value: _textStyle.fontWeight ?? FontWeight.normal,
                      items: [
                        FontWeight.w100,
                        FontWeight.w300,
                        FontWeight.w400,
                        FontWeight.w500,
                        FontWeight.w700,
                        FontWeight.w900
                      ].map((weight) {
                        return DropdownMenuItem(
                          value: weight,
                          child: Text("Weight ${weight.index * 100 + 100}"),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setModalState(() {
                          _textStyle = _textStyle.copyWith(fontWeight: val);
                        });
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 16),

                    // Shadow Controls
                    ExpansionTile(
                      title: Text("Shadow Settings"),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shadow Color"),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Pick Shadow Color"),
                                      content: ColorPicker(
                                        pickerColor: _shadowColor,
                                        onColorChanged: (color) {
                                          setModalState(() {
                                            _shadowColor = color;
                                          });
                                          setState(() {});
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text("Done"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: _shadowColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Blur"),
                            Expanded(
                              child: Slider(
                                value: _shadowBlur,
                                min: 0,
                                max: 20,
                                onChanged: (val) {
                                  setModalState(() {
                                    _shadowBlur = val;
                                  });
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _textStyle = _textStyle.copyWith(
                            shadows: [
                              Shadow(
                                color: _shadowColor,
                                blurRadius: _shadowBlur,
                                offset: _shadowOffset,
                              )
                            ],
                          );
                        });
                        Navigator.pop(context);
                      },
                      child: Text("Apply"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Style Editor")),
      body: Center(
        child: Text(
          _text,
          style: _textStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openTextEditor,
        child: Icon(Icons.edit),
      ),
    );
  }
}
