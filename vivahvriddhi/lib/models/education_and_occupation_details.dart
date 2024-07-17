// for registration screen 1
class EducationandOccupationInfoModel {
  String educationdone;
  String employedin;
  String occupation;
  String annualincome;

  EducationandOccupationInfoModel({
    required this.educationdone,
    required this.employedin,
    required this.occupation,
    required this.annualincome,

  });
  // from map
  factory EducationandOccupationInfoModel.fromMap(Map<String, dynamic> map) {
    return EducationandOccupationInfoModel(
      educationdone: map['educationdone'] ?? '',
      employedin: map['employedin'] ?? '',
      occupation: map['occupation'] ?? '',
      annualincome: map['annualincome'] ?? '',

    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "educationdone": educationdone,
      "employedin":employedin,
      "occupation": occupation,
      "annualincome": annualincome,
    };
  }
}