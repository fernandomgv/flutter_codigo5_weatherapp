
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_weatherapp/model/weather_model.dart';

import '../general/colors.dart';

class ItemForecastWidget extends StatelessWidget {
  //const ItemForecastWidget({Key? key}) : super(key: key);

  WeatherModel? weatherModel;
  String time;

  ItemForecastWidget({
    required this.weatherModel,
  required this.time,
});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.09),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ]
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Image.asset(
            "assets/icons/${weatherModel != null ? iconos[weatherModel!.weather[0].main] : "dom-1.png"}",
            height: 38.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            "${weatherModel != null ? weatherModel!.main.temp : "-"}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
