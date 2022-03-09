import 'package:flutter/material.dart';
import 'package:weather/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color.fromARGB(255, 21, 32, 43),
        primaryColor: const Color.fromARGB(255, 17, 29, 41),
        cardColor: const Color.fromARGB(255, 35, 51, 66),
      ),
      home: const WeatherHomePage(),
    );
  }
}
