import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherAppHomePage extends StatefulWidget {
  const WeatherAppHomePage({super.key});
  @override
  State<WeatherAppHomePage> createState() => _WeatherAppHomePageState();
}

class _WeatherAppHomePageState extends State<WeatherAppHomePage> {
  final _controller = TextEditingController();
  String? _city;
  String? _description;
  double? _temperature;
  String? _condition;
  final String _apiKey = '19b15efc74b01eb7cc0574d85791c65c';
  Future<void> _fetchWeather(String city) async {
    if (city.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a city name')));
      return;
    }

    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': city,
      'appid': _apiKey,
      'units': 'metric',
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (!mounted) return;

        setState(() {
          _city = data['name'] as String;
          _description = data['weather'][0]['description'] as String;
          _temperature = (data['main']['temp'] as num).toDouble();
          _condition = (data['weather'][0]['main'] as String).toLowerCase();
        });
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.statusCode == 401 ? 'Invalid API key' : 'City not found',
            ),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error fetching weather')));
    }
  }

  String _getImageForCondition(String? condition) {
    switch (condition) {
      case 'clear':
        return 'assets/icons/weather_clear.png';
      case 'rain':
        return 'assets/icons/weather_rain.png';
      case 'snow':
        return 'assets/icons/weather_snow.png';
      case 'clouds':
        return 'assets/icons/weather_cloud.png';
      case 'thunderstorm':
        return 'assets/icons/weather_clear.png';
      default:
        return 'assets/icons/weather_clear.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _fetchWeather(_controller.text.trim()),
                ),
              ),
              onSubmitted: (value) => _fetchWeather(value.trim()),
            ),
            SizedBox(height: 30),
            if (_city != null)
              Column(
                children: [
                  Image.asset(_getImageForCondition(_condition), height: 100),
                  SizedBox(height: 20),
                  Text(
                    _city!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_temperature?.toStringAsFixed(1)} °C',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(_description!, style: TextStyle(fontSize: 18)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
