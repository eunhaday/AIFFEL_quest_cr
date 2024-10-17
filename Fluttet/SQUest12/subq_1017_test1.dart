import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppScreen(),
    );
  }
}

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // AppBar color
        //leading: Icon(Icons.menu), // Icon on the top left
        //title: Text("플러터 앱만들기"), // Centered title
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                Icons.alarm,
                size: 40,
                color: Colors.red
            ),
            Expanded(
              child: Text(
                "플러터 앱만들기",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, //기본축 기준 중앙에
        children: [
          // Centered Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                debugPrint("버튼이 눌려졌습니다.");
              },
              child: Text("Text"), // Button label
            ),
          ),
          SizedBox(height: 100), // 둘간의 간격
          Container(
            alignment: Alignment.bottomCenter,
            child: Stack(
              //alignment: Alignment.center,
              children: [
                // Outermost container
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.red.withOpacity(0.5), // Color with opacity
                ),
                // Second container
                Container(
                  width: 240,
                  height: 240,
                  color: Colors.green.withOpacity(0.5),
                ),
                // Third container
                Container(
                  width: 180,
                  height: 180,
                  color: Colors.blue.withOpacity(0.5),
                ),
                // Fourth container
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.orange.withOpacity(0.5),
                ),
                // Innermost container
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.purple.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
