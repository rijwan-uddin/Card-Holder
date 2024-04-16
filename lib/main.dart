import 'dart:js';

import 'package:cardholder/pages/home_page.dart';
import 'package:cardholder/pages/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig:  _router,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

    );
  }

  final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name:homepage.routeName,
        path: homepage.routeName,
        builder: (context, state) =>const homepage(),
        routes: [
          GoRoute(
            name: ScanPage.routeName,
            path: ScanPage.routeName,
            builder: (context,state) => ScanPage()
          ),
        ]

     )
    ]
  );

}
//103.  5.04


//104 f























