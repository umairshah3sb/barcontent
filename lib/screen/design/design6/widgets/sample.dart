import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedUIWidget extends StatefulWidget {
  @override
  _AnimatedUIWidgetState createState() => _AnimatedUIWidgetState();
}

class _AnimatedUIWidgetState extends State<AnimatedUIWidget>
    with TickerProviderStateMixin {
  bool showContent = false;
  int currentIndex = 0;

  late List<Map<String, String>> items;
  Timer? animationTimer;
  Timer? switchTimer;

  @override
  void initState() {
    super.initState();

    // Your content list: each item has 2 images and 2 texts
    items = [
      {
        'img1':
            'https://upload.wikimedia.org/wikipedia/commons/3/32/Flag_of_Pakistan.svg',
        'img2':
            'https://upload.wikimedia.org/wikipedia/commons/3/32/Flag_of_Pakistan.svg',
        'text1': 'First Text A',
        'text2': 'Second Text A',
      },
      {
        'img1':
            'https://upload.wikimedia.org/wikipedia/commons/3/32/Flag_of_Pakistan.svg',
        'img2':
            'https://upload.wikimedia.org/wikipedia/commons/3/32/Flag_of_Pakistan.svg',
        'text1': 'First Text B',
        'text2': 'Second Text B',
      },
      // Add more sets if needed
    ];

    startAnimationCycle();
  }

  void startAnimationCycle() {
    animationTimer?.cancel();
    switchTimer?.cancel();

    // Delay 1 second then show animation
    animationTimer = Timer(Duration(seconds: 1), () {
      setState(() => showContent = true);
    });

    // After 5 seconds, reset animation and go to next item
    switchTimer = Timer(Duration(seconds: 5), () {
      setState(() {
        showContent = false;
        currentIndex = (currentIndex + 1) % items.length;
      });

      // Restart the cycle
      Future.delayed(Duration(milliseconds: 500), startAnimationCycle);
    });
  }

  @override
  void dispose() {
    animationTimer?.cancel();
    switchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = items[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: AnimatedOpacity(
            opacity: showContent ? 1 : 0,
            duration: Duration(milliseconds: 800),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(currentItem['img1']!, width: 150)),
                SizedBox(height: 10),
                SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(currentItem['img2']!, width: 150)),
                SizedBox(height: 10),
                Text(currentItem['text1']!,
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                Text(currentItem['text2']!,
                    style: TextStyle(color: Colors.white70, fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
