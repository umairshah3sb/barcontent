import 'package:flutter/material.dart';


class BusiestAirportsApp extends StatelessWidget {
  const BusiestAirportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(
          0xFFFBFBFB,
        ), // Light background to match the image
        body: Center(child: BusiestAirportsChart()),
      ),
    );
  }
}

// --- Data Model (No change) ---
class AirportData {
  final String name;
  final int passengers; // In millions
  final Color color;
  final String flagAsset; // Using simple text placeholders for flags

  AirportData(this.name, this.passengers, this.color, this.flagAsset);
}

// --- Main Chart Widget (No change) ---
class BusiestAirportsChart extends StatelessWidget {
  BusiestAirportsChart({super.key});

  final double maxHeight = 300.0;
  final int maxPassengers = 108; // Based on Atlanta's data

  final List<AirportData> data = [
    AirportData('ATLANTA', 108, const Color(0xFFE4273E), '🇺🇸'),
    AirportData('DUBAI', 92, const Color(0xFF1E8D50), '🇦🇪'),
    AirportData('DALLAS/FT WORTH', 88, const Color(0xFF1C52A5), '🇯🇵'),
    AirportData('LONDON', 84, const Color(0xFF1C52A5), '🇬🇧'),
    AirportData('ISTANBUL', 80, const Color(0xFF1C52A5), '🇺🇸'),
    AirportData('NEW DELHI', 78, const Color(0xFFFFA500), '🇮🇳'),
    AirportData('SHANGHAI', 77, const Color(0xFFE4273E), '🇨🇳'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'BUSIEST AIRPORTS IN THE WORLD',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: data.map((item) {
              double barHeight = (item.passengers / maxPassengers) * maxHeight;
              return BarChartItem(data: item, height: barHeight);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// --- UPDATED Individual Bar Widget (The 3D Element) ---
class BarChartItem extends StatelessWidget {
  final AirportData data;
  final double height;
  final double barWidth = 40.0;

  const BarChartItem({super.key, required this.data, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Flag and Value (No change here)
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(data.flagAsset, style: const TextStyle(fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: Text(
                '${data.passengers}M',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        // 3D Column (Main Bar) - **UPDATED FOR MORE 3D LOOK**
        Container(
          height: height,
          width: barWidth,
          decoration: BoxDecoration(
            color: data.color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(5.0),
            ),
            // **Enhanced BoxShadows for a more cylindrical/3D look**
            boxShadow: [
              // Bottom Shadow for lift and depth
              BoxShadow(
                color: data.color.withOpacity(
                  0.6,
                ), // Slightly stronger base shadow
                blurRadius: 12,
                offset: const Offset(0, 8), // More pronounced lift
              ),
              // Left side shadow for curvature
              BoxShadow(
                color: Colors.black.withOpacity(0.15), // Darker shadow
                blurRadius: 6,
                spreadRadius: 0,
                offset: const Offset(-5, 0), // Shifted to the left
              ),
              // Right side highlight/shadow for curvature
              BoxShadow(
                color: Colors.white.withOpacity(0.3), // Light highlight
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset(5, 0), // Shifted to the right
              ),
              // Inner top shadow for depth at the top edge (optional, but adds to depth)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                spreadRadius: -2, // Inset-like effect
                offset: const Offset(0, -3),
              ),
            ],
            // **Subtle Gradient for cylindrical lighting effect**
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                data.color.withOpacity(0.8), // Slightly darker on the left
                data.color,
                data.color.withOpacity(0.9), // Slightly darker on the right
              ],
              stops: const [0.0, 0.5, 1.0], // Control gradient spread
            ),
          ),
        ),

        // 3D Base (The white rounded platform) - **Slightly Enhanced**
        Container(
          width: barWidth + 10,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x44000000), // Slightly darker base shadow
                blurRadius: 12,
                offset: Offset(0, 8),
              ),
              // Inner shadow for the top edge of the base to make it look less flat
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: -1,
                offset: Offset(0, -2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Name (No change)
        SizedBox(
          width: barWidth + 20,
          child: Text(
            data.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
