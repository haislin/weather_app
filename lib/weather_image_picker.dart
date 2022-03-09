class WeatherImagePicker {
  String getImage(String weather, int time) {
    var date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    var hour = date.hour;
    if (weather == "few clouds" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/sun/27.png";
    } else if (weather == "few clouds" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/moon/15.png";
    } else if (weather == "scattered clouds" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/sun/6.png";
    } else if (weather == "scattered clouds" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/moon/2.2.png";
    } else if (weather == "broken clouds" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/sun/6.png";
    } else if (weather == "broken clouds" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/moon/2.2.png";
    } else if (weather == "shower rain" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/sun/8.png";
    } else if (weather == "shower rain" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/moon/1.png";
    } else if (weather == "rain" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/rain/39.png";
    } else if (weather == "rain" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/rain/39.png";
    } else if (weather == "thunderstorm" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/sun/16.png";
    } else if (weather == "thunderstorm" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/cloud/17.png";
    } else if (weather == "snow" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/snow/36.png";
    } else if (weather == "snow" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/snow/36.png";
    } else if (weather == "mist" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/cloud/35.png";
    } else if (weather == "mist" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/cloud/35.png";
    } else if (weather == "clear sky" && hour >= 6 && hour <= 18) {
      return "assets/3d_weather_icons/sun/26.png";
    } else if (weather == "clear sky" && hour >= 18 || hour <= 6) {
      return "assets/3d_weather_icons/moon/10.png";
    } else {
      return "assets/3d_weather_icons/sun/26.png";
    }
  }
}