import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  SearchPage({this.updateUi, super.key});
  VoidCallback? updateUi;

  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Search a City',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (data) {
              // onChanged is useful to show suggestions when user starts of typing
              cityName = data;
            },
            onSubmitted: (data) async {
              // onSubmitted submits data once
              cityName = data;
              WeatherService service = WeatherService();
              WeatherModel? weather =
                  await service.getWeather(cityName: cityName!);

              // ignore: use_build_context_synchronously
              Provider.of<WeatherProvider>(context,listen: false).weatherData =  weather;
              // ignore: use_build_context_synchronously
              Provider.of<WeatherProvider>(context, listen: false).cityName =
                  cityName;
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            decoration:  InputDecoration(
              contentPadding:
                 const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              label:const Text('Search'),
              border:const OutlineInputBorder(),
              hintText: 'Enter City Name',
              hintStyle:const TextStyle(color: Colors.grey),
              suffixIcon: GestureDetector(onTap: ()async{
                          WeatherService service = WeatherService();
              WeatherModel? weather =
                  await service.getWeather(cityName: cityName!);

              Provider.of<WeatherProvider>(context,listen: false).weatherData =  weather;
              Provider.of<WeatherProvider>(context, listen: false).cityName =
                  cityName;
              Navigator.pop(context);
              }, child:const Icon(Icons.search, color: Colors.black)),
              labelStyle:const TextStyle(color: Colors.orange),
            ),
          ),
        ),
      ),
    );
  }
}
