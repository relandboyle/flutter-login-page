class TemperatureEntry {
  final String entryId;
  final String channelId;
  final int serverTime;
  final int createdAt;
  final String fieldOneLabel;
  final String temperature;
  final String name;
  final String latitude;
  final String longitude;
  final String outsideTemperature;

  TemperatureEntry({
    this.entryId = '',
    this.channelId = '',
    this.serverTime = 0,
    this.createdAt = 0,
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
      serverTime: json["serverTime"] as int,
      createdAt: json["createdAt"] as int,
      fieldOneLabel: json["fieldOneLabel"] as String,
      temperature: json["temperature"] as String,
      name: json["name"] as String,
      latitude: json["latitude"] as String,
      longitude: json["longitude"] as String,
      outsideTemperature: json["outsideTemperature"] as String,
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
    };
  }
}
