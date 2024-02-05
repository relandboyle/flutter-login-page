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
  });

  factory TemperatureEntry.fromJson(dynamic json) {
    return TemperatureEntry(
      entryId: json["entryId"] as String,
      channelId: json["channelId"] as String,
      serverTime: DateTime.parse(json["serverTime"]) as String,
      createdAt: DateTime.parse(json["createdAt"]) as String,
      fieldOneLabel: json["fieldOneLabel"] as String,
      temperature: json["temperature"] as String,
      name: json["name"] as String,
      latitude: json["latitude"] as String,
      longitude: json["longitude"] as String,
      outsideTemperature: json["outsideTemperature"] as String,
    );
  }
}
