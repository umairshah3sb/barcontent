import 'dart:html' as html;

class MetaHelper {
  static void setMetaData({
    required String title,
    required String description,
    required String keywords,
    required String author,
    required String ogImage,
    required String ogUrl,
  }) {
    // Page Title
    html.document.title = title;

    // Description
    _updateMeta('description', description);

    // Keywords
    _updateMeta('keywords', keywords);
    _updateMeta('author', author);

    // Optional: Open Graph
    _updateMeta('og:title', title, property: true);
    _updateMeta('og:description', description, property: true);
    _updateMeta('og:image', ogImage, property: true);
    _updateMeta('twitter:card', ogImage, property: true);
    _updateMeta('og:url', ogImage, property: true);
  }

  static void _updateMeta(String name, String content,
      {bool property = false}) {
    var selector = property ? 'meta[property="$name"]' : 'meta[name="$name"]';
    var metaTag = html.document.querySelector(selector);

    if (metaTag != null) {
      metaTag.setAttribute('content', content);
    } else {
      final meta = html.MetaElement()..content = content;

      if (property) {
        meta.setAttribute('property', name);
      } else {
        meta.name = name;
      }

      html.document.head!.append(meta);
    }
  }
}
