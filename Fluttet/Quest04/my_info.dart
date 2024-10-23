import 'package:flutter/material.dart';

class MyCoupang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('My정보'),
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
                            color: Colors.white,
                            child: Image.asset(
                              'images/mycoupang_scr1.png', //width: 350,
                              height: 150,
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
                            //color: Colors.white,
                            child: IconButton(
                              icon: Image.asset('images/icon/order_list_icon.png', height: 110, fit: BoxFit.fill,),
                              onPressed: (){
                                Navigator.pushNamed(context, '/orderlist'); //주문목록화면 호출하기
                              },
                            ),
                          ),
                          Container(
                            //color: Colors.white,
                            child: Image.asset(
                              'images/mycoupang_scr2.png', //width: 350,
                              height: 120,
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
                            //color: Colors.white,
                            child: Image.asset(
                              'images/mycoupang_scr3.png', //width: 350,
                              height: 200,
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
                            //color: Colors.white,
                            child: Image.asset(
                              'images/mycoupang_scr4.png', //width: 350,
                              height: 330,
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