import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/models/education_and_occupation_details.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen4.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen6.dart';
import '../authprovider/authprovider.dart';
import '../components/custom_button_in_mobile_auth.dart';
import '../components/snackbar.dart';
class RegistrationScreen5 extends StatefulWidget {
  static String routeName = "/registrationscreen5";
  @override
  _RegistrationScreen5State createState() => _RegistrationScreen5State();
}

class _RegistrationScreen5State extends State<RegistrationScreen5> {
  String? _educationdoneselected;
  String? _employedinselected;
  String? _occupationselectd;
  String? _annualincomeselected;
  TextEditingController _eduacationdoneselectedController=TextEditingController();
  TextEditingController _employedinselectedController=TextEditingController();
  TextEditingController _occupationselectedController=TextEditingController();
  TextEditingController _annualincomeselectedController=TextEditingController();

  final List<String> _educationlist = [
    "High School Diploma",
    "Associate's Degree",
    "Bachelor of Arts (BA)",
    "Bachelor of Science (BS)",
    "Bachelor of Commerce (BCom)",
    "Bachelor of Business Administration (BBA)",
    "Bachelor of Fine Arts (BFA)",
    "Bachelor of Education (BEd)",
    "Bachelor of Architecture (BArch)",
    "Bachelor of Computer Applications (BCA)",
    "Bachelor of Engineering (BE)",
    "Bachelor of Technology (B.Tech)",
    "Bachelor of Medicine, Bachelor of Surgery (MBBS)",
    "Doctor of Medicine (MD)",
    "Doctor of Philosophy (PhD)",
    "Master of Arts (MA)",
    "Master of Science (MS)",
    "Master of Commerce (MCom)",
    "Master of Business Administration (MBA)",
    "Master of Fine Arts (MFA)",
    "Master of Education (MEd)",
    "Master of Architecture (MArch)",
    "Master of Computer Applications (MCA)",
    "Master of Engineering (ME)",
    "Master of Technology (M.Tech)",
    "Master of Medicine (MMed)",
    "Master of Surgery (MSurg)",
    "Doctor of Education (EdD)",
    "Doctor of Engineering (EngD)",
    "Doctor of Business Administration (DBA)",
    "Other",
  ];

  final List<String> _employedinlist = [
    "Private", //
    "Government", //
    "Self-Employed", //
    "Freelance", //
    "Non-profit",
    "Unemployed", //
    "Retired", //
    "Student", //
    "Other", //
  ];
  // change it later
  final List<String> _occupationlist = [
    "Software Professional",
    "Teacher",
    "Engineer",
    "Doctor",
    "Lawyer",
    "Accountant",
    "Artist",
    "Writer",
    "Nurse",
    "Pilot",
    "Chef",
    "Entrepreneur",
    "Designer",
    "Manager",
    "Consultant",
    "Scientist",
    "Musician",
    "Photographer",
    "Salesperson",
    "Marketing Specialist",
    "Financial Analyst",
    "Human Resources Specialist",
    "Customer Service Representative",
    "Real Estate Agent",
    "Electrician",
    "Plumber",
    "Carpenter",
    "Mechanic",
    "Driver",
    "Laborer",
    "Other",
  ];

  final List<String> _annualincomelist = 
  [
  '0 - 1 Lakh',
  '1 - 2 Lakhs',
  '2 - 3 Lakhs',
  '3 - 4 Lakhs',
  '4 - 5 Lakhs',
  '5 - 6 Lakhs',
  '6 - 7 Lakhs',
  '7 - 8 Lakhs',
  '8 - 9 Lakhs',
  '9 - 10 Lakhs',
  '10 - 15 Lakhs',
  '15 - 20 Lakhs',
  '20 - 25 Lakhs',
  '25 - 30 Lakhs',
  '30 - 35 Lakhs',
  '35 - 40 Lakhs',
  '40 - 45 Lakhs',
  '45 - 50 Lakhs',
  '50 Lakhs & Above'
    
  ];
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
        ):Stack(
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
                height: MediaQuery.of(context).size.height * 0.70,
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
                    Container(
                      width: 90,
                      height: 90,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange[100],
                      ),
                      child: Image.asset("assets/authimages/workdetails.png"),
                    ),

                    const SizedBox(height: 20),
                    Center(
                        child:Text("Education and Occupation Details",
                          style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        )
                    ),
                    const SizedBox(height: 10),
                    // 1. for education  purpose
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
                              child: Image.asset("assets/authimages/graduation.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'select Education status',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _educationlist
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
                                  value: _educationdoneselected,
                                  onChanged: (value) {
                                    setState(() {
                                      _educationdoneselected= value;
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
                                    searchController: _eduacationdoneselectedController,
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
                                        controller:  _eduacationdoneselectedController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for Education...',
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
                                      _eduacationdoneselectedController.clear();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 2. for Employed In purpose

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
                              child: Image.asset("assets/authimages/employment.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'select Employed in status',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _employedinlist
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
                                  value: _employedinselected,
                                  onChanged: (value) {
                                    setState(() {
                                      _employedinselected= value;
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
                                    searchController: _employedinselectedController,
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
                                        controller: _employedinselectedController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for Employee in...',
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
                                      _employedinselectedController.clear();
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
                    // 3. foer occupation  purpose
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
                              child: Image.asset("assets/authimages/occupation.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'select Occupation status',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _occupationlist
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
                                  value: _occupationselectd,
                                  onChanged: (value) {
                                    setState(() {
                                      _occupationselectd= value;
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
                                    searchController: _occupationselectedController,
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
                                        controller: _occupationselectedController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for Occupation in...',
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
                                      _occupationselectedController.clear();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 4. for Annual Income  purpose
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
                              child: Image.asset("assets/authimages/salary.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'select Annual Income',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _annualincomelist
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
                                  value: _annualincomeselected,
                                  onChanged: (value) {
                                    setState(() {
                                      _annualincomeselected= value;
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
                                    searchController: _annualincomeselectedController,
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
                                        controller: _annualincomeselectedController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for Annual Income...',
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
                                      _annualincomeselectedController.clear();
                                    }
                                  },
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

                        CustomButton(
                            text: "       Save       ",
                            onPressed: () {
                              if (_educationdoneselected == null ||_educationdoneselected!.isEmpty)
                              {
                                showSnackBar(context, "Select Education");
                              }
                              else if(_employedinselected==null ||_employedinselected!.isEmpty)
                              {
                                showSnackBar(context, "Select Employement Sector");
                              }
                              else if(_occupationselectd==null ||_occupationselectd!.isEmpty)
                              {
                                showSnackBar(context, "Select Employement Sector");
                              }

                              else if(_annualincomeselected==null ||_annualincomeselected!.isEmpty)
                              {
                                showSnackBar(context, "Select Annual Income");
                              }
                              else
                              {
                                storeData();
                              }
                            }
                            )
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
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);


    EducationandOccupationInfoModel educationandOccupationInfoModel =EducationandOccupationInfoModel(educationdone: _educationdoneselected.toString(), employedin:_employedinselected.toString(), occupation: _occupationselectd.toString(), annualincome: _annualincomeselected.toString() );

    ap.saveEducationandOccupationInfoToFirebase(
      context: context,
      educationandOccupationInfoModel: educationandOccupationInfoModel,
      educationdone: _educationdoneselected.toString(),
      employedin: _employedinselected.toString(),
      occupation: _occupationselectd.toString(),
      annualincome: _annualincomeselected.toString(),
      onSuccess: () {

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationScreen6(),
            ),
                (route) => false);


      },
    );
  }
}
