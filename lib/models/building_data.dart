class BuildingData {
  String id;
  String city;
  String country;
  String postalCode;
  String state;
  String streetName;
  String streetNumber;
  String fullAddress; // New field

  BuildingData({
    this.id = '',
    this.city = '',
    this.country = '',
    this.postalCode = '',
    this.state = '',
    this.streetName = '',
    this.streetNumber = '',
    required this.fullAddress,
  });

  factory BuildingData.fromJson(Map<String, dynamic> json) {
    return BuildingData(
      id: json['id'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      postalCode: json['postalCode'] as String,
      state: json['state'] as String,
      streetName: json['streetName'] as String,
      streetNumber: json['streetNumber'] as String,
      fullAddress: json['fullAddress'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'state': state,
      'streetName': streetName,
      'streetNumber': streetNumber,
      'fullAddress': fullAddress,
    };
  }
}
