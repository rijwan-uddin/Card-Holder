import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  static const String routeName= '/';
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
    );
  }
}
