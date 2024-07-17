import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/components/custom_button_in_mobile_auth.dart';
import 'package:vivahvriddhi/components/snackbar.dart';
import '../authprovider/authprovider.dart' as apx;
import 'package:http/http.dart' as http;

String name = "";

class DiscoverMatchesByName extends StatefulWidget {
  DiscoverMatchesByName({Key? key}) : super(key: key);

  @override
  State<DiscoverMatchesByName> createState() => _DiscoverMatchesByNameState();
}

class _DiscoverMatchesByNameState extends State<DiscoverMatchesByName> {
  String ?CollectionToSelect;

  // to send interest
  String?nname;
  String?occupation;
  String?employedin;
  String?annualincome;
  String?education;
  String?dob;
  String?physicalstatus;
  String?height;
  String?maritalstatus;
  String?religion;
  String?caste;
  String?subcaste;
  String?country;
  String?state;
  String?city;
  String?familytype;
  String?fathersoccupation;
  String?mothersoccupation;
  String?emailaddress;

  String? get paymentSessionId => null;

  @override
  void initState() {
    initializeData();
    super.initState();
  }
  Future<void> initializeData() async {
    final ap = Provider.of<apx.AuthProvider>(context, listen: false);
    String gender=await ap.getGenderOfUser();

    // to share the personal details that you want to share profile
    String Name=await ap.getNameOfUser();
    String Occupation=await ap.getOccupationOfUser();
    String EmployedIn=await ap.getEmployedinOfUser();
    String AnnualIncome=await ap.getAnnualIncomeOfUser();
    String Education=await ap.getEducationOfUser();
    String DOB=await ap.getDateOfBirthForOfUser();
    String PhysicalStatus=await ap.getPhysicalOfUser();
    String Height=await ap.getHeightOfUser();
    String MaritalStatus=await ap.getMaritalStatusOfUser();
    String Religion=await ap.getReligionOfUser();
    String Caste=await ap.getCasteOfUser();
    String SubCaste=await ap.getSubCasteOfUser();
    String Country=await ap.getCOuntryOfUser();
    String State=await ap.getStateOfUser();
    String City=await ap.getCityOfUser();
    String FamilyType=await ap.getFamilyTypeOfUser();
    String FathersOccupation=await ap.getFathersOccupationOfUser();
    String MothersOccupation=await ap.getMothersOccupationOfUser();
    String EmailAddress=await ap.getGmailAddressUser();

    // remaing only photos url to share we will look it later




    if(mounted)
      {
        setState(() {
          print(gender+"--------------------------------------------------------");
          if(gender=="Male")
          {
            print("Yes you are Male"+"--------------------------------------------------------");

            CollectionToSelect="DisplayFemale";
            nname=Name;
            occupation=Occupation;
            employedin=EmployedIn;
            annualincome=AnnualIncome;
            education=Education;
            dob=DOB;
            physicalstatus=PhysicalStatus;
            height=Height;
            maritalstatus=MaritalStatus;
            religion=Religion;
            caste=Caste;
            subcaste=SubCaste;
            country=Country;
            state=State;
            city=City;
            familytype=FamilyType;
            fathersoccupation=FathersOccupation;
            mothersoccupation=MothersOccupation;
            emailaddress=EmailAddress;
          }
          else
          {
            print("Yes you are Female "+"-----------------------------------------------------");
            CollectionToSelect="DisplayMale";
            nname=Name;
            occupation=Occupation;
            employedin=EmployedIn;
            annualincome=AnnualIncome;
            education=Education;
            dob=DOB;
            physicalstatus=PhysicalStatus;
            height=Height;
            maritalstatus=MaritalStatus;
            religion=Religion;
            caste=Caste;
            subcaste=SubCaste;
            country=Country;
            state=State;
            city=City;
            familytype=FamilyType;
            fathersoccupation=FathersOccupation;
            mothersoccupation=MothersOccupation;
            emailaddress=EmailAddress;
          }


        });
      }
  }


  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    hintText: 'Search by name ...',
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val.toLowerCase();
                    });
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("$CollectionToSelect").snapshots(), // Remove the specific document ID

                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {

                        List<DocumentSnapshot> searchResults = snapshot.data!.docs.where((doc) => name.isEmpty || doc['name'].toString().toLowerCase().contains(name)).toList();
                        if (searchResults.isEmpty || !snapshot.hasData) {
                          // If no cars are in the "In" status, display a message
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF841D34),
                            ),
                          );
                        }
                      print("yes collection have data -------------------------------------------"+"${snapshot.data!.docs.length}");
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ScrollController _scrollController = ScrollController();

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                // Handle onTap
                              },
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 1 / 0.9,
                                  width: MediaQuery.of(context).size.width * 1 / 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xFFF5F6F9),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // 1. to display the photos
                                        Row(
                                          children: [

                                            Expanded(
                                              child: Scrollbar(
                                                controller: _scrollController,
                                                interactive: true,
                                                thumbVisibility: true,
                                                trackVisibility: true, // Ensure scrollbar is always shown
                                                thickness: 8.0,
                                                child: SizedBox(
                                                  height: 300, // Set a fixed height for the row
                                                  child: ListView(
                                                    controller: _scrollController,
                                                    scrollDirection: Axis.horizontal,
                                                    children: [
                                                      // First card
                                                      SizedBox(
                                                        width: 300, // Width of each card
                                                        child: Card(
                                                          elevation: 4,
                                                          margin: EdgeInsets.all(10),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Image.network(
                                                            '${snapshot.data?.docs[index]['photouploaded1']}', // Replace this with the actual URL of the first image
                                                            fit: BoxFit.fill, // Adjust the image to cover the entire space
                                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                              if (loadingProgress == null) return child;
                                                              return Center(
                                                                child: CircularProgressIndicator(
                                                                  color: Color(0xFF841D34),
                                                                  value: loadingProgress.expectedTotalBytes != null
                                                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                                      : null,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      // Second card
                                                      SizedBox(
                                                        width: 300, // Width of each card
                                                        child: Card(
                                                          elevation: 4,
                                                          margin: EdgeInsets.all(10),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Image.network(
                                                            '${snapshot.data?.docs[index]['photouploaded2']}', // Replace this with the actual URL of the second image
                                                            fit: BoxFit.fill, // Adjust the image to cover the entire space
                                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                              if (loadingProgress == null) return child;
                                                              return Center(
                                                                child: CircularProgressIndicator(
                                                                  color: Color(0xFF841D34),
                                                                  value: loadingProgress.expectedTotalBytes != null
                                                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                                      : null,
                                                                ),
                                                              );
                                                            },

                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      // Third card
                                                      SizedBox(
                                                        width: 300, // Width of each card
                                                        child: Card(
                                                          elevation: 4,
                                                          margin: EdgeInsets.all(10),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Image.network(
                                                            '${snapshot.data?.docs[index]['photouploaded3']}', // Replace this with the actual URL of the third image
                                                            fit: BoxFit.fill, // Adjust the image to cover the entire space
                                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                              if (loadingProgress == null) return child;
                                                              return Center(
                                                                child: CircularProgressIndicator(
                                                                  color: Color(0xFF841D34),
                                                                  value: loadingProgress.expectedTotalBytes != null
                                                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                                      : null,
                                                                ),
                                                              );
                                                            },

                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      // Fourth card
                                                      SizedBox(
                                                        width: 300, // Width of each card
                                                        child: Card(
                                                          elevation: 4,
                                                          margin: EdgeInsets.all(10),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Image.network(
                                                            '${snapshot.data?.docs[index]['photouploaded4']}', // Replace this with the actual URL of the fourth image
                                                            fit: BoxFit.fill, // Adjust the image to cover the entire space
                                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                              if (loadingProgress == null) return child;
                                                              return Center(
                                                                child: CircularProgressIndicator(
                                                                  color: Color(0xFF841D34),
                                                                  value: loadingProgress.expectedTotalBytes != null
                                                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                                      : null,
                                                                ),
                                                              );
                                                            },

                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height:  10,
                                        ),
                                        //2. to display the name
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Name : ${snapshot.data?.docs[index]['name']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // 3. to display the occupation
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Occupation : ${snapshot.data?.docs[index]['occupation']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 4. to display employed in
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Employed In : ${snapshot.data?.docs[index]['employedin']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // 5. to display annual income
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Annual Income : ${snapshot.data?.docs[index]['annualincome']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 6. to display education
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Education : ${snapshot.data?.docs[index]['educationdone']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 7. to display date of birth
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Date of Birth : ${snapshot.data?.docs[index]['dateofbirth']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 8. to display physical status
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Physical Status : ${snapshot.data?.docs[index]['physicalstatus']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 9. to display height
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Height : ${snapshot.data?.docs[index]['heightincm']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 10. to display marital status
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Marital Status : ${snapshot.data?.docs[index]['maritalstatus']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),


                                        // 11. to display religion
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Religion : ${snapshot.data?.docs[index]['religion']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 12. to display caste
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Caste : ${snapshot.data?.docs[index]['caste']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 13. to display sub caste
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Sub caste : ${snapshot.data?.docs[index]['subcaste']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 14. to display country living in
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Country : ${snapshot.data?.docs[index]['contrylivingin']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 15. to display state living in
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "State : ${snapshot.data?.docs[index]['statelivingin']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 16. to display city living in
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "City : ${snapshot.data?.docs[index]['citylivingin']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 17. to display family type
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Family type : ${snapshot.data?.docs[index]['familytype']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 18. to display family members
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Family members : ${snapshot.data?.docs[index]['totalfamilymembers']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 19. to display father's occupation
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Father's occupation : ${snapshot.data?.docs[index]['fathersoccupation']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 20. to display mother's occupation
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Mother's occupation : ${snapshot.data?.docs[index]['motheroccupation']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 21. to display wheather willing to marry to another community
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Willing to marry with another " ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                " community : ${snapshot.data?.docs[index]['othercommunitymarrydecision']}" ,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 22 . to show the personal contact details no need to show if payment done then and then only

                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     // CategoryCard1(icon: "assets/icons/Bill Icon.svg", press: () {}),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     Expanded(
                                        //       child: Text(
                                        //         "Gmail : ${snapshot.data?.docs[index]['mailaddressdetails']}" ,
                                        //         style: TextStyle(
                                        //           fontSize: 16,
                                        //           color: Colors.black,
                                        //         ),
                                        //         maxLines: 1,
                                        //         overflow: TextOverflow.ellipsis,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),

                                        SizedBox(height: 10,),

                                        Center(
                                          //child: CustomButton(text: "Send Interest via 💌", onPressed: () {  sendGmail(name: "$nname", email: "${snapshot.data?.docs[index]['mailaddressdetails']}".toString(), subject: "People were Interested In you !",fromwhombcc: "$emailaddress".toString(), message: "People Interested In you Details \n Name : $nname \n Occupation : $occupation \n Employed In : $employedin \n Annual Income : $annualincome \n Education : $education \n Date of Birth : $dob \n Physical Status : $physicalstatus \n Height : $height \n Marital Status : $maritalstatus \n Religion : $religion \n Caste : $caste \n Sub caste : $subcaste \n Country : $country \n State : $state \n City : $city \n Family type : $familytype \n Father's occupation : $fathersoccupation \n Mother's occupation : $mothersoccupation \n " );},), // here we are going to integrate the payment gatway
                                          child: CustomButton(text: "Pay",onPressed: initiatePay,
                                             //call here the payment function
                                          ),
                                          ),

                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.width / 1.2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Skeleton(
                              height: 120,
                              width: 120,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Skeleton(width: 80),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Skeleton(),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Skeleton(),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: const [
                                      Expanded(child: Skeleton()),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(child: Skeleton()),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
  //payment function using cashfree
  void initiatePay()
  {
    try{
      var session =CFSessionBuilder().setEnvironment(CFEnvironment.PRODUCTION).setOrderId("order_id_always_unique").setPaymentSessionId(paymentSessionId!);
    }
    catch(e)
    {

    }

  }










  Future sendGmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String fromwhombcc,

  }) async{
    final serviceId='service_gdys3jg';
    final templateId='template_i1clxkf';
    final userId='4w7u6aJX5nYAvbTYQ';
    final url=Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response= await http.post(
        url,
        headers: {
          'origin':'http://localhost',
          'Content-Type':'application/json',
        },
        body: json.encode(
            {
              'service_id':serviceId,
              'template_id':templateId,
              'user_id':userId,
              'template_params':{
                'user_name':name,
                'user_email':email,
                'user_subject':subject,
                'user_message':message,
                'fromwhom_bcc_mail':fromwhombcc
              }

            }
        )
    );

    if(response.body=="OK")
    {
      showSnackBar(context, "Gmail Send Sucessfully");
    }
    else
    {
      showSnackBar(context, "Some thing went wrong");
    }

  }




}

class CategoryCard1 extends StatelessWidget {
  const CategoryCard1({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String? icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 50,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

const Color primaryColor = Color(0xFF2967FF);
const Color grayColor = Color(0xFF8D8D8E);

const double defaultPadding = 16.0;

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(defaultPadding)),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}