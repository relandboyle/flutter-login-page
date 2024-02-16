import 'temperature_entry.dart';

class SensorDataResponse {
  List<int> bottomTileSpacer;
  List<TemperatureEntry> sensorData;

  SensorDataResponse({
    this.bottomTileSpacer = const [],
    this.sensorData = const [],
  });

  factory SensorDataResponse.fromJson(Map<String, dynamic> json) {
    return SensorDataResponse(
      bottomTileSpacer: List<int>.from(json['bottomTileSpacer']),
      sensorData: List<TemperatureEntry>.from(json['sensorData'].map((x) => TemperatureEntry.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bottomTileSpacer': bottomTileSpacer,
      'sensorData': List<TemperatureEntry>.from(sensorData.map((x) => x.toJson())),
    };
  }
}
