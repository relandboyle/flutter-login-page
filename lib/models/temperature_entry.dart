import 'package:fl_chart/fl_chart.dart';

class TemperatureEntry {
  final String entryId;
  final String channelId;
  final String serverTime;
  final String createdAt;
  final String fieldOneLabel;
  final String temperature;
  final String name;
  final String latitude;
  final String longitude;
  final String outsideTemperature;
  final FlSpot spot;

  TemperatureEntry({
    this.entryId = '',
    this.channelId = '',
    this.serverTime = '',
    this.createdAt = '',
    this.fieldOneLabel = '',
    this.temperature = '',
    this.name = '',
    this.latitude = '',
    this.longitude = '',
    this.outsideTemperature = '',
    this.spot = const FlSpot(0, 0),
  });

  factory TemperatureEntry.fromJson(dynamic json) {
    return TemperatureEntry(
      entryId: json["entryId"] as String,
      channelId: json["channelId"] as String,
      serverTime: json["serverTime"],
      createdAt: json["createdAt"],
      fieldOneLabel: json["fieldOneLabel"] as String,
      temperature: json["temperature"] as String,
      name: json["name"] as String,
      latitude: json["latitude"] as String,
      longitude: json["longitude"] as String,
      outsideTemperature: json["outsideTemperature"] as String,
      spot: FlSpot(
        DateTime.parse(json["serverTime"]).millisecondsSinceEpoch.toDouble() / 10000000000,
        double.parse((double.parse(json["temperature"]) * (9 / 5) + 32).toStringAsFixed(2)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entryId': entryId,
      'channelId': channelId,
      'serverTime': serverTime,
      'createdAt': createdAt,
      'fieldOneLabel': fieldOneLabel,
      'temperature': temperature,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'outsideTemperature': outsideTemperature,
      'spot': spot,
    };
  }
}
