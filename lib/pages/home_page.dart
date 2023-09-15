import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/pages/search_page.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/widgets/no_weather_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateUi() {
    setState(() {});
  }

  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage(updateUi: updateUi);
                }));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: weatherData == null
          ? const NoWeatherBody()
          : Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      weatherData!.getThemeColor(),
                      weatherData!.getThemeColor()[300]!,
                      weatherData!.getThemeColor()[100]!,
                    ]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Column(
                  children: [
                    Text(
                      Provider.of<WeatherProvider>(context).cityName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      'Updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
                      style:const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(weatherData!.getImage()),
                        Text(
                          '$weatherData!.temp.toInt()',
                          style:const TextStyle(fontSize: 50),
                        ),
                        Column(
                          children: [
                            Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                            Text('minTemp :${weatherData!.minTemp.toInt()}'),
                          ],
                        )
                      ],
                    ),
                  const  SizedBox(height: 40),
                    Text(
                      weatherData!.weatherStateName,
                      style:  const  TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
