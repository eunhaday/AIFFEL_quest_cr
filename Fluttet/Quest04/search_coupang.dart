import 'package:flutter/material.dart';

class SerchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white, // AppBar color
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //아이콘 이미지 설정
                  IconButton(
                    icon: Image.asset('images/icon/back_home_icon.png',  height: 30, fit: BoxFit.fill,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text("검색", textAlign: TextAlign.left,),
                  ),
                ],
              ),
            ),
            body: Column(
                children: [
                  Container(
                      color: Colors.white,
                      //margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            //color: Colors.white,
                            child: Image.asset(
                              'images/serch_page.jpg', //width: 350,
                              height: 860,
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      )
                  ),
                ]
            )
        )

    );
  }
}