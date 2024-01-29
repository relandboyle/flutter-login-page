class ChannelData {
  ChannelData({this.result = '', this.serverTime = '', required this.channels});

  final String result;
  final String serverTime;
  final List<dynamic> channels;

  factory ChannelData.fromJson(dynamic json) {
    return ChannelData(
        result: json["result"],
        serverTime: json["server_time"] as String,
        channels: json["channels"] as List<dynamic>);
  }
}

class SensorData {
  SensorData(
      {this.channelId = '', this.fieldOneLabel = '', this.lastValues = ''});

  final String channelId;
  final String fieldOneLabel;
  final String lastValues;

  factory SensorData.fromJson(dynamic json) {
    return SensorData(
        channelId: json["channel_id"] as String,
        fieldOneLabel: json["field1"] as String,
        lastValues: json["last_values"] as String);
  }
}

class LastValues {
  LastValues({required this.field1});

  final FieldOne field1;

  factory LastValues.fromJson(dynamic json) {
    return LastValues(field1: json["field1"] as FieldOne);
  }
}

class FieldOne {
  FieldOne({this.value = ''});

  final String value;

  factory FieldOne.fromJson(dynamic json) {
    return FieldOne(value: json["value"] as String);
  }
}
