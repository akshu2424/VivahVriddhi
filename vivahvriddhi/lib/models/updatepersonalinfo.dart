// for registration screen 1
class PersonalInfoUpdateModel {
  String name;
  String dateofbirth;

  PersonalInfoUpdateModel({
    required this.name,
    required this.dateofbirth,


  });
  // from map
  factory PersonalInfoUpdateModel.fromMap(Map<String, dynamic> map) {
    return PersonalInfoUpdateModel(
      name: map['name'] ?? '',
      dateofbirth: map['dateofbirth'] ?? '',


    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "dateofbirth": dateofbirth,

    };
  }
}