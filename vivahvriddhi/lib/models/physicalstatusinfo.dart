// for registration screen 1
class PhysicalStatusInfoModel {
  String physicalstatus;
  String heightincm;


  PhysicalStatusInfoModel ({
    required this.physicalstatus,
    required this.heightincm,


  });
  // from map
  factory PhysicalStatusInfoModel .fromMap(Map<String, dynamic> map) {
    return PhysicalStatusInfoModel (
      physicalstatus: map['physicalstatus'] ?? '',
      heightincm: map['heightincm'] ?? '',


    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "physicalstatus": physicalstatus,
      "heightincm":heightincm,
    };
  }
}