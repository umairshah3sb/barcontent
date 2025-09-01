import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/util/helper.dart';

class FontFamilyDropdown extends StatefulWidget {
  final Function(String) onFontSelected;
  String text;

  FontFamilyDropdown({
    Key? key,
    required this.onFontSelected,
    required this.text,
  }) : super(key: key);

  @override
  _FontFamilyDropdownState createState() => _FontFamilyDropdownState();
}

class _FontFamilyDropdownState extends State<FontFamilyDropdown> {
  String _selectedFont = "Russo One"; // default font

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // fixed width

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.text),
          gap(h: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedFont,
                items: fontFamilies.map((font) {
                  return DropdownMenuItem(
                    value: font,
                    child: Text(
                      font,
                      style: GoogleFonts.getFont(font, fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFont = value!;
                  });
                  widget
                      .onFontSelected(_selectedFont); // send back selected font
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
