

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_weatherapp/model/weather_model.dart';
import 'package:geolocator/geolocator.dart';


import '../services/api_service.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/item_forecast_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage({Key? key}) : super(key: key);

  ApiService _service = ApiService();
  TextEditingController cityNameController = TextEditingController();
  WeatherModel? weatherModel;
  bool isLoading = true;
  String speed = "-";



  getDataWeather() async{
    isLoading = true;
    setState(() {

    });
    String cityName = cityNameController.text == "" ? "Lima" : cityNameController.text;
    print(cityName);
    weatherModel = await _service.getDataWeather(cityName);
    speed = weatherModel!.wind.speed.toString();
    isLoading = false;
    setState(() {

    });

  }

  getDataWeatherLocation() async{
    isLoading = true;
    setState(() {

    });
    Position _position = await Geolocator.getCurrentPosition();
    print(_position);
    weatherModel = await _service.getDataWeatherLocation(_position.latitude,_position.longitude);
    speed = weatherModel!.wind.speed.toString();
    isLoading = false;
    setState(() {

    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getDataWeatherLocation();
    //getDataWeather();

  }

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      appBar: AppBar(
        title: Text("WeatherApp"),
        centerTitle: true,
        backgroundColor:kBrandPrimaryColor ,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
              this.isLoading=true;
              getDataWeatherLocation();
            },
            icon: Icon(Icons.location_on),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Image.asset("assets/icons/${weatherModel != null ? iconos[weatherModel!.weather[0].main] : "dom-1.png"}",
                    height: height*0.16,
                  ),
                  const SizedBox(height: 12,),
                  Text(
                    weatherModel != null ? weatherModel!.weather[0].main : "-",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weatherModel != null ? weatherModel!.main.temp.toStringAsFixed(0) : "0",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height*0.08,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(width: 6,),
                      Text(
                        "°C",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height*0.02,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  Text(
                    weatherModel != null ? "${weatherModel!.name}, ${weatherModel!.sys.country} ": "-",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                      //fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 12,),
                  TextField(
                    controller: cityNameController,
                    decoration: InputDecoration(
                        hintText: "Enter city name",
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none
                        ),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            this.isLoading = true;
                            getDataWeather();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kBrandPrimaryColor,
                            ),
                            child: Icon(Icons.search,
                              color: Colors.white,),
                          ),
                        )
                    ),
                    onSubmitted: (value){
                      getDataWeather();
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ItemForecastWidget(weatherModel: weatherModel != null ? weatherModel! : null ,time: "7:00 AM",),
                        ItemForecastWidget(weatherModel: weatherModel != null ? weatherModel! : null ,time: "9:00 AM",),
                        ItemForecastWidget(weatherModel: weatherModel != null ? weatherModel! : null ,time: "11:00 AM",),
                        ItemForecastWidget(weatherModel: weatherModel != null ? weatherModel! : null ,time: "1:00 PM",),
                        ItemForecastWidget(weatherModel: weatherModel != null ? weatherModel! : null ,time: "3:00 PM",),
                        ItemForecastWidget(weatherModel: weatherModel != null ? weatherModel! : null ,time: "5:00 PM",),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff2E3341),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("15 minutes ago",
                              style: TextStyle(
                                  color: Colors.white60
                              ),
                            ),
                            const SizedBox(height: 12,),

                            Text("The wind speed is ${speed} today! This is not the time for yacht trip",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: -70,
                          right: 50,
                          child: Image.asset("assets/icons/${weatherModel != null ? iconos[weatherModel!.weather[0].main] : "dom-1.png"}",
                            height: height*0.09,
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
         isLoading ? Container(
            color: kBrandPrimaryColor.withOpacity(0.95),
             child: Center(
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                ),
              )
          )
          : Container(),
        ],
      )
    );
  }
}
