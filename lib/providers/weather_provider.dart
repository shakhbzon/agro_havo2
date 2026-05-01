import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "../services/weather_service.dart";

class WeatherProvider extends ChangeNotifier {
    late Box _settingsBox;
    Map<String, dynamic>? _weatherData;
    bool _isLoading = false;
    String _error = "";

    WeatherProvider() {
          _init();
    }

    Map<String, dynamic>? get weatherData => _weatherData;
    bool get isLoading => _isLoading;
    String get error => _error;

    Future<void> _init() async {
          _settingsBox = Hive.box("settings_box");
          fetchWeather();
    }
    Future<void> fetchWeather({bool forceRefresh = false}) async {
          _isLoading = true;
          _error = "";
          notifyListeners();

          try {
                  final city = _settingsBox.get("city", defaultValue: "Tashkent");
                  final lat = _settingsBox.get("lat");
                  final lon = _settingsBox.get("lon");

                  if (lat != null && lon != null) {
                            _weatherData = await WeatherService().getWeatherByCoords(lat, lon);
                  } else {
                            _weatherData = await WeatherService().getWeatherByCity(city);
                  }
          } catch (e) {
                  _error = e.toString();
          } finally {
                  _isLoading = false;
                  notifyListeners();
          }
    }

    Future<void> updateLocation(String city, {double? lat, double? lon}) async {
          await _settingsBox.put("city", city);
          if (lat != null && lon != null) {
                  await _settingsBox.put("lat", lat);
                  await _settingsBox.put("lon", lon);
          } else {
                  await _settingsBox.delete("lat");
                  await _settingsBox.delete("lon");
          }
          fetchWeather();
    }
}

}
We 
