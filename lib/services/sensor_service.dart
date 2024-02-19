import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:logger/logger.dart';
import '../models/sensor_data_response.dart';
import 'package:http/http.dart' as http;

final logger = Logger();

class SensorService {
  Future<Map<String, dynamic>> getTemperatureData(String channelId, DateTime startDate, DateTime endDate) async {
    List<FlSpot> spots = [const FlSpot(0.0, 0.0)];
    List<FlSpot> outsideSpots = [const FlSpot(0.0, 0.0)];
    List<int> bottomTitleSpacer = <int>[];
    SensorDataResponse response = SensorDataResponse();

    try {
      response = await getSensorData(channelId, startDate.toIso8601String(), endDate.toIso8601String());
      spots = response.sensorData
          .map((entry) => FlSpot(
                entry.serverTime.toDouble(),
                double.parse((double.parse(entry.temperature) * (9 / 5) + 32).toStringAsFixed(2)),
              ))
          .toList();

      outsideSpots = response.sensorData
          .map((entry) => FlSpot(
                entry.serverTime.toDouble(),
                double.parse((double.parse(entry.outsideTemperature) * (9 / 5) + 32).toStringAsFixed(2)),
              ))
          .toList();

      bottomTitleSpacer = response.bottomTitleSpacer;
    } catch (e) {
      logger.e('Error getting sensor data: $e');
    }

    return <String, dynamic>{'spots': spots, 'outsideSpots': outsideSpots, 'bottomTitleSpacer': bottomTitleSpacer};
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
    return res;
  }
}
