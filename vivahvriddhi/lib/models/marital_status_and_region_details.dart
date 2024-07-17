// for registration screen 3
class MaritalStatusRegionInfoModel {
  String maritalstatus;
  String contrylivingin;
  String statelivingin;
  String citylivingin;

  MaritalStatusRegionInfoModel({
    required this.maritalstatus,
    required this.contrylivingin,
    required this.statelivingin,
    required this.citylivingin,

  });
  // from map
  factory MaritalStatusRegionInfoModel.fromMap(Map<String, dynamic> map) {
    return MaritalStatusRegionInfoModel(
      maritalstatus: map['maritalstatus'] ?? '',
      contrylivingin: map['contrylivingin'] ?? '',
      statelivingin: map['statelivingin'] ?? '',
      citylivingin: map['citylivingin'] ?? '',

    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "maritalstatus": maritalstatus,
      "contrylivingin":contrylivingin,
      "statelivingin": statelivingin,
      "citylivingin": citylivingin,
    };
  }
}