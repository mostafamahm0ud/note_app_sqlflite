import 'package:flutter/material.dart';
import 'package:note_app_sqlflite/data/sqldb.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SqlDb db = SqlDb();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        child: ListView(
          children: [
            Text('Home'),
          ]
          
        )
      ),
    );
  }
}
