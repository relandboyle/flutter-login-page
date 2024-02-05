import 'dart:async';
import 'dart:convert';
import 'package:logger/logger.dart';
import '../models/temperature_entry.dart';
import 'package:http/http.dart' as http;

final logger = Logger();

class SensorService {

  Iterable<TemperatureEntry> temperatureEntries = <TemperatureEntry>[];

  Future<Iterable<TemperatureEntry>> getSensorData(String channelId, String dateRangeStart, String dateRangeEnd) async {
    final response = await http.post(
        Uri.parse("http://localhost:8089/api/v1/sensor/filteredSensorData"),
        // Uri.parse('https://heat-sync-534f0413abe0.herokuapp.com/api/v1/sensor/filteredSensorData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'channelId': channelId,
          'dateRangeStart': dateRangeStart,
          'dateRangeEnd': dateRangeEnd,
        }));

    Iterable res = json.decode(response.body);
    logger.i('$res');
    temperatureEntries = List<TemperatureEntry>.from(res.map((model) => TemperatureEntry.fromJson(model)));

     return temperatureEntries;
  }
}
