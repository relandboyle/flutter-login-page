import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:logger/logger.dart';
import '../models/sensor_data_response.dart';
import '../models/temperature_entry.dart';
import 'package:http/http.dart' as http;

final logger = Logger();

class SensorService {
  Iterable<TemperatureEntry> temperatureEntries = <TemperatureEntry>[];

  Future<Map<String, List<FlSpot>>> getTemperatureData(String channelId, String startDate, String endDate) async {
    List<FlSpot> spots = [];
    List<FlSpot> outsideSpots = [];
    // request sensor data from the server passing channelId, startTime, and endTime
    SensorDataResponse temperatureEntries = await getSensorData(channelId, startDate, endDate);

    spots = temperatureEntries.sensorData
        .map((entry) => FlSpot(
              entry.serverTime.toDouble(),
              double.parse((double.parse(entry.temperature) * (9 / 5) + 32).toStringAsFixed(2)),
            ))
        .toList();

    outsideSpots = temperatureEntries.sensorData
        .map((entry) => FlSpot(
              entry.serverTime.toDouble(),
              double.parse((double.parse(entry.outsideTemperature) * (9 / 5) + 32).toStringAsFixed(2)),
            ))
        .toList();

    return <String, List<FlSpot>>{
      'spots': spots,
      'outsideSpots': outsideSpots,
    };
  }

  Future<SensorDataResponse> getSensorData(String? channelId, String dateRangeStart, String dateRangeEnd) async {
    final response = await http
        .post(
            // Uri.parse("http://localhost:8089/api/v1/sensor/filteredSensorData"),
            Uri.parse('https://heat-sync-534f0413abe0.herokuapp.com/api/v1/sensor/filteredSensorData'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String?>{
              'channelId': channelId,
              'dateRangeStart': dateRangeStart,
              'dateRangeEnd': dateRangeEnd,
            }))
        .catchError((onError) {
      logger.e('Error fetching temperature data: $onError');
      return onError;
    });

    SensorDataResponse res = SensorDataResponse.fromJson(json.decode(response.body));
    logger.i("RESPONSE: ${res.sensorData[0].flutterSpot['value0'].runtimeType}, ${res.sensorData[0].flutterSpot['value1'].runtimeType}");

    return res;
  }
}
