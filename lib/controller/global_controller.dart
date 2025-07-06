import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../api/fetch_weather.dart';
import '../model/hourly.dart';
import '../model/weather_info.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  final RxInt _currentIndex = 0.obs;

  final weatherInfo = WeatherInfo().obs;
  final hourlyInfo = WeatherInfo().hourly.obs;

  RxBool checkLoading() => _isLoading;

  RxDouble getLatitude() => _latitude;

  RxDouble getLongitude() => _longitude;

  Rx<WeatherInfo> getWeatherInfo() => weatherInfo;
  Rx<List<Hourly>?> getHourlyInfo() => hourlyInfo;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }

    super.onInit();
  }

  Future<void> getLocation() async {
    try {
      // Check if location services are enabled
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        return Future.error("Location services are disabled");
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission if denied
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error("Location permission is denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Optionally open app settings for the user to enable permission
        await Geolocator.openAppSettings();
        return Future.error("Location permission is permanently denied");
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latitude.value = position.latitude;
      _longitude.value = position.longitude;

      return FetchWeather()
          .fetchWeatherInfo(position.latitude, position.longitude)
          .then((value) {
        weatherInfo.value = value;
        hourlyInfo.value = value.hourly;
        _isLoading.value = false;
      });
    } catch (e) {
      // Handle any errors (e.g., permission issues, network issues)
      return Future.error("Failed to get location: $e");
    }
  }

  RxInt getIndex(){
    return _currentIndex;
  }

}
