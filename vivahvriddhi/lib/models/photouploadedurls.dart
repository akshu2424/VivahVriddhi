// for registration screen 2
class PhotoUploadedModel {
  String photouploaded1;
  String photouploaded2;
  String photouploaded3;
  String photouploaded4;

  PhotoUploadedModel({
    required this.photouploaded1,
    required this.photouploaded2,
    required this.photouploaded3,
    required this.photouploaded4,

  });
  // from map
  factory PhotoUploadedModel.fromMap(Map<String, dynamic> map) {
    return PhotoUploadedModel(
      photouploaded1: map['photouploaded1'] ?? '',
      photouploaded2: map['photouploaded2'] ?? '',
      photouploaded3: map['photouploaded3'] ?? '',
      photouploaded4: map['photouploaded4'] ?? '',

    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "photouploaded1": photouploaded1,
      "photouploaded2": photouploaded2,
      "photouploaded3": photouploaded3,
      "photouploaded4": photouploaded4,
    };
  }
}