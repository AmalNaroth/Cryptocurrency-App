import 'package:cryptocurrency_app/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    title: "Cryptocurrency-App",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: defaultTargetPlatform==TargetPlatform.android ? Colors.red : Colors.amber,
    primaryColor: defaultTargetPlatform==TargetPlatform.android ? Colors.red : Colors.amber),
    home:  CoinListScreen(),
  ));
}
