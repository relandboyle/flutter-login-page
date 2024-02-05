class UnitData {
  final String unitId;
  final String tenantName;
  final String unitNumber;
  final String buildingId;
  final String channelId;
  final String fullUnit; // New field

  UnitData({
    this.unitId = '',
    this.tenantName = '',
    this.unitNumber = '',
    this.buildingId = '',
    this.channelId = '',
    required this.fullUnit,
  });

  factory UnitData.fromJson(Map<String, dynamic> json) {
    return UnitData(
      unitId: json['unitId'] as String,
      tenantName: json['tenantName'] as String,
      unitNumber: json['unitNumber'] as String,
      buildingId: json['buildingId'] as String,
      channelId: json['channelId'] as String,
      fullUnit: json['fullUnit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'tenantName': tenantName,
      'unitNumber': unitNumber,
      'buildingId': buildingId,
      'channelId': channelId,
      'fullUnit': fullUnit,
    };
  }
}
