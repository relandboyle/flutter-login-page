class TemperatureEntry {
  TemperatureEntry(
      {this.sensorId = '',
      this.channelId = '',
      this.serverTime = '',
      this.fieldOneLabel = '',
      this.temperature = '',
      this.name = '',
      this.unitId = ''});

  final String sensorId;
  final String channelId;
  final String serverTime;
  final String fieldOneLabel;
  final String temperature;
  final String name;
  final String unitId;

  factory TemperatureEntry.fromJson(dynamic json) {
    return TemperatureEntry(
      sensorId: json["sensorId"] as String,
      channelId: json["channelId"] as String,
      serverTime: json["serverTime"] as String,
      fieldOneLabel: json["fieldOneLabel"] as String,
      temperature: json["temperature"] as String,
      name: json["name"] as String,
      unitId: json["unitId"] as String,
    );
  }
}
