import 'package:cardholder/models/contact_model.dart';
import 'package:cardholder/pages/contact_details.dart';
import 'package:cardholder/pages/form_page.dart';
import 'package:cardholder/pages/home_page.dart';
import 'package:cardholder/pages/scan_page.dart';
import 'package:cardholder/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( ChangeNotifierProvider(
      create:(context) => ContactProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {

   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Contact',
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
  name: ContactDetails.routeName,
  path: ContactDetails.routeName,
      builder:(context , state ) => ContactDetails(id: state.extra! as int),
   ),
          GoRoute(
            name: ScanPage.routeName,
            path: ScanPage.routeName,
            builder: (context,state) => ScanPage(),
            routes: [
              GoRoute(
                name: FormPage.routeName,
                path: FormPage.routeName,
                builder: (context, state) => FormPage(contactModel : state.extra! as ContactModel,)
              ),
            ]
          ),
        ]

     )
    ]
  );

}





















