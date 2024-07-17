// for registration screen 2
class CommunityInfoModel {
  String religion;
  String caste;
  String subcaste;
  String othercommunitymarrydecision;

  CommunityInfoModel({
    required this.religion,
    required this.caste,
    required this.subcaste,
    required this.othercommunitymarrydecision,

  });
  // from map
  factory CommunityInfoModel.fromMap(Map<String, dynamic> map) {
    return CommunityInfoModel(
      religion: map['religion'] ?? '',
      caste: map['caste'] ?? '',
      subcaste: map['subcaste'] ?? '',
      othercommunitymarrydecision: map['othercommunitymarrydecision'] ?? '',

    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "religion": religion,
      "caste":caste,
      "subcaste": subcaste,
      "othercommunitymarrydecision": othercommunitymarrydecision,
    };
  }
}