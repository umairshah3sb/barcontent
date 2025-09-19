import 'dart:html' as html;
import 'dart:ui_web' as ui; // <- this is the fix
import 'package:flutter/material.dart';

class HtmlFooter extends StatelessWidget {
  HtmlFooter({super.key}) {
    // Register HTML view
    ui.platformViewRegistry.registerViewFactory(
      'footer-html',
      (int viewId) {
        final footer = html.DivElement()
          ..setAttribute("style",
              "background:#000000;color:#FFFFFF;padding:3px 0 5px 0;text-align:center;");

        footer.appendHtml('''
          <footer>
            <p>© ${DateTime.now().year} Content Creator. All rights reserved.</p>
            <a href="/" style="color:#FFFF00;">Home</a>
            <a href="/sitemap.xml" style="color:#FFFF00 !important;">Sitemap</a>
          </footer>
        ''');

        return footer;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 75,
      child: HtmlElementView(viewType: 'footer-html'),
    );
  }
}
