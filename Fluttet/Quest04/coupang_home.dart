import 'package:flutter/material.dart';

class CoupangHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('coupang'),
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
                        child: Image.asset('images/main_scr.jpg', //width: 350,
                          height: 800, fit: BoxFit.fill,),
                      )
                    ],
                  )
              ),
              Container(
                color: Colors.white,
                //margin: EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [ //아이콘 6개두기
                    //Container(width: 30, height: 30, color: Colors.red,),
                    IconButton(
                      icon: Image.asset('images/icon/category_icon.png',  height: 30, fit: BoxFit.fill,),
                      onPressed: (){
                        Navigator.pushNamed(context, '/category'); //카테고리화면 호출하기
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/icon/coupang_icon.png', height: 30, fit: BoxFit.fill,),
                      onPressed: (){
                        Navigator.pushNamed(context, '/home'); //쿠팡홈화면 호출하기
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/icon/search_icon.png', height: 30, fit: BoxFit.fill,),
                      onPressed: (){
                        Navigator.pushNamed(context, '/serch'); //검색 화면 호출하기
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/icon/myinfo_icon.png', height: 30, fit: BoxFit.fill,),
                      onPressed: (){
                        Navigator.pushNamed(context, '/mycoupang'); //마이쿠팡 화면 호출하기
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/icon/carter_icon.png', height: 30, fit: BoxFit.fill,),
                      onPressed: (){
                        Navigator.pushNamed(context, '/carter'); //장바구니 화면 호출하기
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/icon/month_payment.png', height: 30, fit: BoxFit.fill,),
                      onPressed: (){
                        Navigator.pushNamed(context, '/monpay'); //월사용액 화면 호출하기
                      },
                    ),
                  ],
                ),
              ),
            ]
          )
        )
    );
  }
}