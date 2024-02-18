import 'temperature_entry.dart';

class SensorDataResponse {
  final List<TemperatureEntry> sensorData;
  final List<int> bottomTitleSpacer;

  SensorDataResponse({
    this.sensorData = const [],
    this.bottomTitleSpacer = const [],
  });

  factory SensorDataResponse.fromJson(Map<String, dynamic> json) {
    return SensorDataResponse(
      sensorData: List<TemperatureEntry>.from(json['sensorData']!.map((x) => TemperatureEntry.fromJson(x))),
      bottomTitleSpacer: List<int>.from(json['bottomTitleSpacer'] as Iterable),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sensorData': List<TemperatureEntry>.from(sensorData.map((x) => x.toJson())),
      'bottomTitleSpacer': bottomTitleSpacer,
    };
  }
}
