import 'dart:ui_web' as ui;
import 'dart:html' as html;
import 'package:flutter/material.dart';

class H1Widget extends StatelessWidget {
  final String text;

  H1Widget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
      'h1-element',
      (int viewId) => html.HeadingElement.h1()..text = text,
    );
    return const HtmlElementView(viewType: 'h1-element');
  }
}
