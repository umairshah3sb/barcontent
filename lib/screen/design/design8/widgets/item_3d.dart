import 'package:flutter/material.dart';

class Bar3D extends StatelessWidget {
  final String country;
  final String value;
  final Color color;
  final String flagUrl;

  const Bar3D({
    super.key,
    required this.country,
    required this.value,
    required this.color,
    required this.flagUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 250,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(6, 6),
            blurRadius: 10,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Flag
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              flagUrl,
              width: 40,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          // Country Name
          Container(
            color: Colors.amber,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              country,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // Value
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
