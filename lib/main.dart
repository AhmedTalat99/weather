import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/providers/weather_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: WeatherApp(),
    create: (context) {
      return WeatherProvider();
    },
  ));
}

class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});

  WeatherModel? weather;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch:
              Provider.of<WeatherProvider>(context).weatherData == null
                  ? Colors.blue
                  : Provider.of<WeatherProvider>(context)
                      .weatherData!
                      .getThemeColor()),
      home: const HomePage(),
    );
  }
}
