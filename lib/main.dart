import 'package:flutter/material.dart';
import 'package:flutter_task/country_screen.dart';
import 'package:flutter_task/home.dart';
import 'package:flutter_task/rate_exchange_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const CountryListScreen(),
        routes: {
          ExchangeRateScreen.routeName: (context) => const ExchangeRateScreen(),
        });
  }
}
