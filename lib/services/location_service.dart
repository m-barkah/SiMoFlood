import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LocationData {
  final String city;
  final DateTime dateTime;
  final double temperature;
  final String formattedDate;
  final String iconUrl;

  LocationData({
    required this.city,
    required this.dateTime,
    required this.temperature,
    required this.formattedDate,
    required this.iconUrl,
  });
}

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final _locationController = StreamController<LocationData>.broadcast();
  Stream<LocationData> get locationStream => _locationController.stream;

  Timer? _timer;

  final String city = 'Tangerang';
  final String apiKey = '75a07d8b3e03de97d2e890bed9711181';

  Future<void> init() async {
    print('[LocationService] Initializing...');
    await _fetchWeatherData();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      print('[LocationService] Fetching weather data every 1 minute...');
      _fetchWeatherData();
    });
  }

  Future<void> _fetchWeatherData() async {
    try {
      final locationData = await getLocationData();
      _locationController.add(locationData);
      print('[LocationService] LocationData sent to stream.');
    } catch (e) {
      print('[LocationService] Error in _fetchWeatherData: $e');
    }
  }

  /// ✅ Method baru: Ambil 1x data cuaca dan kembalikan sebagai LocationData
  Future<LocationData> getLocationData() async {
    try {
      final now = DateTime.now();
      final formattedDate = DateFormat('d MMMM').format(now);

      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=id';
      print('[LocationService] Requesting weather data from: $url');

      final response = await http.get(Uri.parse(url));
      print('[LocationService] Response status: ${response.statusCode}');
      print('[LocationService] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = (data['main']['temp'] as num).toDouble();
        final iconCode = data['weather'][0]['icon'];
        final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@2x.png';

        print('[LocationService] Parsed temperature: $temp');
        print('[LocationService] Parsed icon: $iconCode');

        return LocationData(
          city: city,
          dateTime: now,
          temperature: temp,
          formattedDate: formattedDate,
          iconUrl: iconUrl,
        );
      } else {
        throw Exception('Gagal mengambil data cuaca');
      }
    } catch (e) {
      print('[LocationService] Error in getLocationData: $e');
      final now = DateTime.now();
      return LocationData(
        city: city,
        dateTime: now,
        temperature: 29.0,
        formattedDate: DateFormat('d MMMM').format(now),
        iconUrl: 'https://openweathermap.org/img/wn/01d@2x.png', // fallback
      );
    }
  }

  void dispose() {
    _timer?.cancel();
    _locationController.close();
    print('[LocationService] Disposed.');
  }
}
