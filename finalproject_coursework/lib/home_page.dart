import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add change language button and logout button
      appBar: AppBar(
        title: Text('Have a Chat'),
      ),
      body: Column(
        children: [
          Text('Hello')
        ],
      ),
    );
  }
}
