import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NewMatchesListData {
  NewMatchesListData({
    this.imagePath = '',
    this.nameTxt='',
    this.startColor = '',
    this.endColor = '',
    this.profession = '',
    this.location = '',
    //this.kacl = 0,
  });

  String imagePath;
  String nameTxt;
  String startColor;
  String endColor;
  String profession;
  String location;

  static List<NewMatchesListData> tabIconsList = [];

  static Future<void> fetchDataFromFirestore() async {
    try {
      // Fetch data from Firestore
      DocumentSnapshot snapshot1 = await FirebaseFirestore.instance.collection("Member1").doc('member1data').get();
      DocumentSnapshot snapshot2 = await FirebaseFirestore.instance.collection("Member2").doc('member2data').get();
      DocumentSnapshot snapshot3 = await FirebaseFirestore.instance.collection("Member3").doc('member3data').get();
      DocumentSnapshot snapshot4 = await FirebaseFirestore.instance.collection("Member4").doc('member4data').get();
      if (snapshot1.exists)
      {
        String name1=snapshot1.get('nameTxt');
        String location1=snapshot1.get('location');
        String profession1=snapshot1.get('profession');
        String startcolor1=snapshot1.get('startColor');
        String endcolor1=snapshot1.get('endColor');

        // Create the first NewMatchesListData instance with the retrieved name
        NewMatchesListData firstMember = NewMatchesListData(
          imagePath: 'assets/new_matches/user.png',
          nameTxt: "$name1",
          location:"$location1",
          profession: "$profession1",
          startColor: "$startcolor1",
          endColor: "$endcolor1",
        );



        // Add the first member to tabIconsList
        tabIconsList.assign(firstMember);

      }
      if(snapshot2.exists)
      {
        String name2=snapshot2.get('nameTxt');
        String location2=snapshot2.get('location');
        String profession2=snapshot2.get('profession');
        String startcolor2=snapshot2.get('startColor');
        String endcolor2=snapshot2.get('endColor');

        // Create the first NewMatchesListData instance with the retrieved name
        NewMatchesListData secondMember = NewMatchesListData(
            imagePath: 'assets/new_matches/user.png',
            nameTxt: "$name2",
            location:"$location2",
            profession: "$profession2",
            startColor: "$startcolor2",
            endColor: "$endcolor2",
        );

        tabIconsList.insert(1, secondMember);
      }
      if(snapshot3.exists)
      {
        String name3=snapshot3.get('nameTxt');
        String location3=snapshot3.get('location');
        String profession3=snapshot3.get('profession');
        String startcolor3=snapshot3.get('startColor');
        String endcolor3=snapshot3.get('endColor');

        // Create the first NewMatchesListData instance with the retrieved name
        NewMatchesListData secondMember = NewMatchesListData(
          imagePath: 'assets/new_matches/user.png',
          nameTxt: "$name3",
          location:"$location3",
          profession: "$profession3",
          startColor: "$startcolor3",
          endColor: "$endcolor3",
        );
        tabIconsList.insert(2, secondMember);

      }

      if(snapshot4.exists)
      {
        String name4=snapshot4.get('nameTxt');
        String location4=snapshot4.get('location');
        String profession4=snapshot4.get('profession');
        String startcolor4=snapshot4.get('startColor');
        String endcolor4=snapshot4.get('endColor');

        // Create the first NewMatchesListData instance with the retrieved name
        NewMatchesListData secondMember = NewMatchesListData(
          imagePath: 'assets/new_matches/user.png',
          nameTxt: "$name4",
          location:"$location4",
          profession: "$profession4",
          startColor: "$startcolor4",
          endColor: "$endcolor4",
        );
        tabIconsList.insert(3, secondMember);
      }
      else{
        print("-----------------------------------------doc empty--------");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
