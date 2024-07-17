import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/models/personalinfo.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen2.dart';
import '../authprovider/authprovider.dart';
import '../components/custom_button_in_mobile_auth.dart';
import '../components/snackbar.dart';
class RegistrationScreen1 extends StatefulWidget {
  static String routeName = "/registrationscreen1";
  @override
  _RegistrationScreen1State createState() => _RegistrationScreen1State();
}
class _RegistrationScreen1State extends State<RegistrationScreen1> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController _profileisforController=TextEditingController();
  final TextEditingController _GenderisController=TextEditingController();
  var myDateFormat = DateFormat('d-MM-yyyy');
  String? dobSelected;

  final List<String> _profileisfor = [
    "Myself",
    "My Son",
    "My Daughter",
    "My Brother",
    "My Sister",
    "My Friend",
    "My Relative"
  ];
  String? _profileselectedvalue;


  final List<String> _genderis = ["Male", "Female"];
  String? _genderselectedvalue;

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: Center(
        child: isLoading == true ?
        Center(
          child: CircularProgressIndicator(
            color: Color(0xFF841D34),
          ),
        )
              :Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // width: 70,
                    // height: 70,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      //radius: ,
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/logo/logo.png'),
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    "ivahVriddhi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 45.0,
                      spreadRadius: 1.0,
                      offset: Offset(5.0, 2.0),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ListView(
                  children: <Widget>[
                    // Padding(
                    //   padding: EdgeInsets.only(left: 20, top: 40),
                    //   child: Text(
                    //     "Phone Number",
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    Container(
                      width: 90,
                      height: 90,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE8CCD2),
                      ),
                      child: Image.asset("assets/authimages/people.png"),
                    ),
                    SizedBox(height: 10,),
                    Center(
                        child:Text("Personal Information",style:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                    )
                    ),
                    // 1. for name purpose
                    const SizedBox(height: 20),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(

                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            TextFormField(
                              // keyboardType: TextInputType.number,
                              cursorColor: Color(0xFF841D34),
                              controller: nameController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  nameController.text = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter full name",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  const BorderSide(color: Colors.black12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  const BorderSide(color: Colors.black12),
                                ),
                                prefixIcon: Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: InkWell(
                                    child: Image.asset(
                                      "assets/authimages/user.png",
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // 2. profile is for  purpose
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(
                        // Outer container with border and rounded corners
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon on the left-hand side
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset("assets/authimages/profileisfor.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Profile is for',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _profileisfor
                                      .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: _profileselectedvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      _profileselectedvalue = value;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 200,
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                  dropdownSearchData: DropdownSearchData(
                                    searchController: _profileisforController,
                                    searchInnerWidgetHeight: 50,
                                    searchInnerWidget: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextFormField(
                                        expands: true,
                                        maxLines: null,
                                        controller: _profileisforController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Profile is for...',
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.search,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          hintStyle: const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return item.value.toString().toLowerCase().contains(searchValue.toString().toLowerCase());
                                    },
                                  ),
                                  // This to clear the search value when you close the menu
                                  onMenuStateChange: (isOpen) {
                                    if (!isOpen) {
                                      _profileisforController.clear();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                    // 3. gender selection purpose

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(
                        // Outer container with border and rounded corners
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon on the left-hand side
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset("assets/authimages/malefemale.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select gender',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _genderis
                                      .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: _genderselectedvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      _genderselectedvalue = value;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 200,
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                  dropdownSearchData: DropdownSearchData(
                                    searchController: _GenderisController,
                                    searchInnerWidgetHeight: 50,
                                    searchInnerWidget: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextFormField(
                                        expands: true,
                                        maxLines: null,
                                        controller: _GenderisController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for gender...',
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.search,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          hintStyle: const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return item.value.toString().toLowerCase().contains(searchValue.toString().toLowerCase());
                                    },
                                  ),
                                  // This to clear the search value when you close the menu
                                  onMenuStateChange: (isOpen) {
                                    if (!isOpen) {
                                      _GenderisController.clear();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 4. date of birth purpose
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime.now(),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    // Update the date selected
                                    dobController.text =
                                        DateFormat('dd-MM-yyyy')
                                            .format(selectedDate);
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: dobController,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Select Date of Birth',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12),
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      child: InkWell(
                                        child: Image.asset(
                                          "assets/authimages/calendar.png",
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),

                    SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        //Text("Not registerd yet?"),
                        SizedBox(height: 6),
                        CustomButton(
                            text: "Next",
                            onPressed: () {

                              if (nameController.text.trim().isEmpty || nameController.text.trim().isEmpty==Null) {
                                showSnackBar(context, "Name cannot be empty");
                              }

                              else if (_profileselectedvalue == null || _profileselectedvalue!.isEmpty)
                              {
                                showSnackBar(context, "Profile is for is mandatory");
                              }

                              else if (_genderselectedvalue == null || _genderselectedvalue!.isEmpty)
                              {
                                showSnackBar(context, "Select the gender");
                              }
                              else if (dobController.text.isEmpty) {
                                showSnackBar(context, "Date of birth is mandatory");
                              }
                              else {
                                showAlertDialog(context);
                               print(dobController.text.toString() +"vbhjjjjjjjjjjjjjjjjjj");
                              }
                            })
                      ],
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }
  // Function to show status update dialog
  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Personal Info')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("You can't able to modify gender later!"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPressed: () {
                      storeData();
                      Navigator.of(context).pop();
                    },
                    text: 'Save',
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: 'Cancel',
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);


    PersonalInfoModel personalInfoModel = PersonalInfoModel(
     name: nameController.text.toString(),
      profileisfor:_profileselectedvalue.toString(),
      gender: _genderselectedvalue.toString(),
      dateofbirth:dobController.text.toString(),
    );

      ap.saveUserPersonalDataToFirebase(
        context: context,
        personalInfoModel: personalInfoModel,
        name: nameController.text.toString(),
        profileisfor: _profileselectedvalue.toString(),
        gender: _genderselectedvalue.toString(),
        dateofbirth:  dobController.text.toString(),

        onSuccess: () {

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RegistrationScreen2(),
              ),
                  (route) => false);


        },
      );


  }
}






// Positioned(
//   top: MediaQuery.of(context).size.height * 0.82,
//   left: MediaQuery.of(context).size.width * 0.1,
//   right: MediaQuery.of(context).size.width * 0.1,
//   child: Column(
//     children: <Widget>[
//       Text("Not registerd yet?"),
//       SizedBox(height: 6),
//       CustomButton(text: "Register", onPressed: ()=>Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>Registerscreen()),
//       (route) => false))
//     ],
//   ),
// ),