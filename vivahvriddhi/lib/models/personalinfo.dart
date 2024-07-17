// for registration screen 1
class PersonalInfoModel {
  String name;
  String profileisfor;
  String gender;
  String dateofbirth;

  PersonalInfoModel({
    required this.name,
    required this.profileisfor,
    required this.gender,
    required this.dateofbirth,


  });
  // from map
  factory PersonalInfoModel.fromMap(Map<String, dynamic> map) {
    return PersonalInfoModel(
      name: map['name'] ?? '',
      profileisfor: map['profileisfor'] ?? '',
      gender: map['gender'] ?? '',
      dateofbirth: map['dateofbirth'] ?? '',


    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "profileisfor":profileisfor,
      "gender": gender,
      "dateofbirth": dateofbirth,

    };
  }
}