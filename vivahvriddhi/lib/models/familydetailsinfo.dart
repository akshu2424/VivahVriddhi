// for registration screen 1
class FamilyDetailsInfoModel {
  String familytype;
  String fathersoccupation;
  String motheroccupation;
  String totalfamilymembers;

  FamilyDetailsInfoModel({
    required this.familytype,
    required this.fathersoccupation,
    required this.motheroccupation,
    required this.totalfamilymembers,

  });
  // from map
  factory FamilyDetailsInfoModel.fromMap(Map<String, dynamic> map) {
    return FamilyDetailsInfoModel(
      familytype: map['familytype'] ?? '',
      fathersoccupation: map['fathersoccupation'] ?? '',
      motheroccupation: map['motheroccupation'] ?? '',
      totalfamilymembers: map['totalfamilymembers'] ?? '',

    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "familytype": familytype,
      "fathersoccupation":fathersoccupation,
      "motheroccupation": motheroccupation,
      "totalfamilymembers": totalfamilymembers,
    };
  }
}