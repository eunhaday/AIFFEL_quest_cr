import 'package:flutter/material.dart';

class CarterPage extends StatelessWidget {
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
                    child: Text("장바구니", textAlign: TextAlign.left,),
                  ),
                ],
              ),
            ),
            body: Column(
                children: [
                  Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.white,
                            child: Image.asset(
                              'images/carter_1.png', //width: 350,
                              height: 800,
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      color: Colors.white,
                      //margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.white,
                            child: IconButton(
                              icon: Image.asset('images/icon/coupang_icon.png',  height: 30, fit: BoxFit.fill,),
                              onPressed: (){
                                Navigator.pushNamed(context, '/home'); //마이쿠팡 화면 호출하기
                              },
                            ),
                          )
                        ],
                      )
                  )
                ]
            )
        )
    );
  }
}


