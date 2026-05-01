import "dart:convert";
import "package:http/http.dart" as http;

class WeatherService {
    final String _apiKey = "f25035f212261623861df400040716c5";
    final String _baseUrl = "https://api.openweathermap.org/data/2.5";

    Future<Map<String, dynamic>> getWeatherByCity(String city) async {
          final response = await http.get(
                  Uri.parse("$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric&lang=uz"),
                );

          if (response.statusCode == 200) {
                  return json.decode(response.body);
          } else {
                  throw Exception("Ob-havo ma'lumotlarini yuklab bo'lmadi");
          }
    }

    Future<Map<String, dynamic>> getWeatherByCoords(double lat, double lon) async {
          final response = await http.get(
                  Uri.parse("$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=uz"),
                );

          if (response.statusCode == 200) {
                  return json.decode(response.body);
          } else {
                  throw Exception("Ob-havo ma'lumotlarini yuklab bo'lmadi");
          }
    }

    Future<Map<String, dynamic>> getForecast(double lat, double lon) async {
          final response = await http.get(
                  Uri.parse("$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=uz"),
                );

          if (response.statusCode == 200) {
                  return json.decode(response.body);
          } else {
                  throw Exception("Prognoz ma'lumotlarini yuklab bo'lmadi");
          }
    }
}

}
