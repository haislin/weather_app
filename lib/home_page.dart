import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:weather/config.dart';
import 'package:weather/weather_image_picker.dart';
import 'package:weather/weather_info_card.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

//http request
  Future<Map> getWeather(String lang, String units) async {
    String apiKey = Config().apiKey;
    Position position = await _determinePosition();
    String lat = position.latitude.toString();
    String lon = position.longitude.toString();
    String langCode = lang;
    String unit = units;
    String url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=$unit&lang=$langCode';
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  final List<String> _titles = [
    "Humidity",
    "Wind",
    "Pressure",
    "Clouds",
    "Min Temp",
    "Max Temp",
    "Feels Like",
    "Visibility",
  ];

  final List<String> _weatherFacts = [
    "The fastest wind ever recorded was over 7,000 km/h.",
    "The highest atmospheric pressure ever recorded was over 1,100 bars.",
    "The most cloudy day was on March 21, 2019.",
    "The lowest temperature ever recorded was -89.2°C.",
    "The highest temperature ever recorded was -89.2°C.",
    "The longest visibility ever recorded was over 1,000 km.",
    "The lowest humidity ever recorded was 0%.",
    "A thunderstorm can produce 160kmph winds.",
    "About 2,000 thunderstorms rain down on Earth every minute."
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: getWeather('en', 'metric'),
        builder: (context, AsyncSnapshot<Map> snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Lottie.asset('assets/loading.json', repeat: true)),
                  Text(
                    _weatherFacts[Random().nextInt(_weatherFacts.length)],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
                child: Text(
              "No Data",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ));
          } else {
            Map<dynamic, dynamic>? content = snapshot.data;
            List<String> _weatherData = [
              content!["main"]["humidity"].toString() + "%",
              content["wind"]["speed"].toString() + "m/s",
              content["main"]["pressure"].toString() + "hPa",
              content["clouds"]["all"].toString() + "%",
              content["main"]["temp_min"].toString() + "°C",
              content["main"]["temp_max"].toString() + "°C",
              content["main"]["feels_like"].toString() + "°C",
              content["visibility"].toString() + "m",
            ];
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.search)),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        WeatherImagePicker().getImage(
                            content['weather'][0]['description'].toString(),
                            content["dt"]),
                        width: size.width * 0.5,
                      ),
                      Text(
                        content["sys"]["country"].toString() +
                            " " +
                            content['name'].toString(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        content['main']['temp'].toString() + "°C",
                        style: const TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        content['weather'][0]['description'],
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  )),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return InfoCard(
                          title: _titles[index],
                          info: _weatherData[index].isEmpty
                              ? "N/A"
                              : _weatherData[index]);
                    },
                    childCount: _titles.length,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
