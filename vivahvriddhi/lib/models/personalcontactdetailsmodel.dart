// for registration screen 7 personal contact
class PersonalContactInfoModel {
  String mailaddressdetails;


  PersonalContactInfoModel({
    required this.mailaddressdetails,


  });
  // from map
  factory PersonalContactInfoModel.fromMap(Map<String, dynamic> map) {
    return PersonalContactInfoModel(
      mailaddressdetails: map['mailaddressdetails'] ?? '',

    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "mailaddressdetails": mailaddressdetails,

    };
  }
}