import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/colors.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'App',
        style: TextStyle(
          color: Color(prussianBlue), // 3
        ),
      ),
    ));
  }
}
