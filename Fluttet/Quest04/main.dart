import 'package:flutter/material.dart';
import 'coupang_home.dart';
import 'category.dart';
import 'search_coupang.dart';
import 'my_info.dart';
import 'order_list.dart';
import 'carter.dart';
import 'month_payment.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => CoupangHome(),
        '/category': (context) => Category(),
        '/serch': (context) => SerchPage(),
        '/mycoupang': (context) => MyCoupang(),
        '/orderlist': (context) => OrderList(),
        '/carter': (context) => CarterPage(),
        '/monpay': (context) => MonPayment(),
      },
      /*onGenerateRoute: (settings){
        if(settings.name == '/three'){
          return MaterialPageRoute(
              builder: (context) => ThreeScreen(),
              settings: settings
          );
        }else if(settings.name == '/four'){
          return MaterialPageRoute(
              builder: (context) => FourScreen(),
              settings: settings
          );
        }
      }, */
    );
  }
}