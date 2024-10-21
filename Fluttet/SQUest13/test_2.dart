import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool is_cat = true;

  void handleOnPressed(bool b_cat) {
    is_cat = !b_cat;
    //debugPrint('is_cat : ${is_cat}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Test',
      home: Navigator(pages: [
        MaterialPage(child: FirstPage()),
        if (!is_cat) MaterialPage(child: SecondPage())
      ], onPopPage: (route, result) => route.didPop(result)),
    );
  }
}


class FirstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // AppBar color
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //아이콘 이미지 설정
            Icon( Icons.alarm, size: 40, color: Colors.red),
            Expanded(
              child: Text("First Page", textAlign: TextAlign.center, ),
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
              onPressed: () async{
                final result = await Navigator.pushNamed(
                    context,
                    '/two',
                    arguments: {
                      "arg1": 10
                    });
                //print('result:${(result as User).name}');
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
                  //color: Colors.red.withOpacity(0.5), // Color with opacity
                  color: Colors.red, // Color with opacity
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondPage'),
      ),
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SecondPage',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
