class UnitData {
  String unitId;
  String tenantName;
  String unitNumber;
  String buildingId;
  String fullUnit; // New field

  UnitData({
    this.unitId = '',
    this.tenantName = '',
    this.unitNumber = '',
    this.buildingId = '',
    required this.fullUnit,
  });

  factory UnitData.fromJson(Map<String, dynamic> json) {
    return UnitData(
      unitId: json['unitId'] as String,
      tenantName: json['tenantName'] as String,
      unitNumber: json['unitNumber'] as String,
      buildingId: json['buildingId'] as String,
      fullUnit: json['fullUnit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'tenantName': tenantName,
      'unitNumber': unitNumber,
      'buildingId': buildingId,
      'fullUnit': fullUnit,
    };
  }
}