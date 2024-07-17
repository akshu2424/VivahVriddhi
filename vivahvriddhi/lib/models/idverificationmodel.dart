// for registration screen 1
class IDVerificationInfoModel {
  String uploadidphoto;

  IDVerificationInfoModel({
    required this.uploadidphoto,
  });
  // from map
  factory IDVerificationInfoModel.fromMap(Map<String, dynamic> map) {
    return IDVerificationInfoModel(
      uploadidphoto: map['uploadidphoto'] ?? '',

    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "uploadidphoto": uploadidphoto,
    };
  }
}