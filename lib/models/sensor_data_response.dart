import 'temperature_entry.dart';

class SensorDataResponse {
  List<TemperatureEntry> sensorData;
  List<int> bottomTileSpacer;

  SensorDataResponse({
    this.sensorData = const [],
    this.bottomTileSpacer = const [],
  });

  factory SensorDataResponse.fromJson(Map<String, List<dynamic>> json) {
    return SensorDataResponse(
      sensorData: List<TemperatureEntry>.from(json['sensorData']!.map((x) => TemperatureEntry.fromJson(x))),
      bottomTileSpacer: List<int>.from(json['bottomTileSpacer'] as Iterable),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sensorData': List<TemperatureEntry>.from(sensorData.map((x) => x.toJson())),
      'bottomTileSpacer': bottomTileSpacer,
    };
  }
}
