class BuildingData {
  String id;
  String streetNumber;
  String streetName;
  String city;
  String state;
  String postalCode;
  String country;
  String fullAddress;

  BuildingData({
    this.id = '',
    this.streetNumber = '',
    this.streetName = '',
    this.city = '',
    this.state = '',
    this.postalCode = '',
    this.country = '',
    required this.fullAddress,
  });

  factory BuildingData.fromJson(Map<String, dynamic> json) {
    return BuildingData(
      id: json['id'] as String,
      streetNumber: json['streetNumber'] as String,
      streetName: json['streetName'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      fullAddress: json['fullAddress'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'streetNumber': streetNumber,
      'streetName': streetName,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'fullAddress': fullAddress,
    };
  }
}
