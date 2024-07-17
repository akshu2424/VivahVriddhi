// for registration screen 1
class EducationVerificationInfoModel {
  String uploadeducationcertificate;

  EducationVerificationInfoModel({
    required this.uploadeducationcertificate,
  });
  // from map
  factory EducationVerificationInfoModel.fromMap(Map<String, dynamic> map) {
    return EducationVerificationInfoModel(
      uploadeducationcertificate: map['uploadeducationcertificate'] ?? '',

    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "uploadeducationcertificate": uploadeducationcertificate,
    };
  }
}