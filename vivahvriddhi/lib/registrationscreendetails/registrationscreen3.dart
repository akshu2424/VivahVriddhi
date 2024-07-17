import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen2.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen4.dart';
import '../authprovider/authprovider.dart';
import '../components/custom_button_in_mobile_auth.dart';
import '../components/snackbar.dart';
import '../models/marital_status_and_region_details.dart';
class RegistrationScreen3 extends StatefulWidget {
  static String routeName = "/registrationscreen3";
  @override
  _RegistrationScreen3State createState() => _RegistrationScreen3State();
}
class _RegistrationScreen3State extends State<RegistrationScreen3> {
  final TextEditingController countrylivinginController = TextEditingController();
  final TextEditingController statelivinginController = TextEditingController();
  final TextEditingController citylivinginController = TextEditingController();
  final TextEditingController _maritalstatusselectedController = TextEditingController();

  final List<String> _maritsalstatuslist = [
    "Un Married",
    "Windower",
    "Divorced",
    "Awaiting Divorce"
  ];
  String ? _maritialstatusselected;


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
                height: MediaQuery.of(context).size.height * 0.6,
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
                        color: Color(0xFFE8CCD2),
                      ),
                      child:
                          Image.asset("assets/authimages/generaldetails.png"),
                    ),
                    const SizedBox(height: 10),
                    // 1. for religion purpose
                    Center(
                        child:Text("Marital Status and Region Details",
                          style:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                        )
                    ),

                    const SizedBox(height: 10),
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
                              child: Image.asset("assets/authimages/maritalstatus.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'select Maritial Status',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _maritsalstatuslist
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
                                  value: _maritialstatusselected,
                                  onChanged: (value) {
                                    setState(() {
                                      _maritialstatusselected= value;
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
                                    searchController: _maritalstatusselectedController,
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
                                        controller: _maritalstatusselectedController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for Status...',
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
                                      _maritalstatusselectedController.clear();
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
                    // 2. for country living in purpose

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CSCPicker(
                              layout: Layout.vertical,
                              //flagState: CountryFlag.DISABLE,


                              onCountryChanged: (value) {
                                countrylivinginController.text=value;
                                //print(countrylivinginController.text+"hdtcccccccghhhhhhhh");
                              },
                              onStateChanged: (value) {
                                statelivinginController.text=value??'';
                                //print(statelivinginController.text+"vubbbbbbbbbbbbbbbbbbbbbbbbivvvvvvvvvvvvvvk");
                              },
                              onCityChanged: (city) {
                                citylivinginController.text=city??'';
                                //print(citylivinginController.text+"hdbvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvj");
                              },
                              countryDropdownLabel: "Select Country",
                                 stateDropdownLabel: "Select State",
                                  cityDropdownLabel: "Select City",
                              //dropdownDialogRadius: 30,
                              //searchBarRadius: 30,
                            ),
                          ],
                        ),
                        
                      ),
                    ),

                    
                    // 3. for State living in purpose

                    const SizedBox(height: 20),
                    Column(
                      children: <Widget>[
                        //Text("Not registerd yet?"),

                        CustomButton(
                            text: "       Save       ",
                            onPressed: () {
                              if (_maritialstatusselected == null || _maritialstatusselected!.isEmpty) {
                                showSnackBar(
                                    context, "Select Marital Status");
                              }
                              else if (countrylivinginController.text.isEmpty || countrylivinginController.text.isEmpty == Null) {
                                showSnackBar(context, "Select Country Living In");
                              }
                              else if (statelivinginController.text.isEmpty || statelivinginController.text.isEmpty == Null) {
                                showSnackBar(context, "Select State Living In");
                              }
                              else if (citylivinginController.text.isEmpty || citylivinginController.text.isEmpty == Null) {
                                showSnackBar(context, "Select City Living In");
                              }
                              else {
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


    MaritalStatusRegionInfoModel maritalStatusRegionInfoModel =MaritalStatusRegionInfoModel(maritalstatus: _maritialstatusselected.toString(), contrylivingin: countrylivinginController.text.toString(), statelivingin: statelivinginController.text.toString(), citylivingin: citylivinginController.text.toString(),);

    ap.saveUserMartialandRegionDataToFirebase(
      context: context,
      maritalStatusRegionInfoModel: maritalStatusRegionInfoModel,
      maritalstatus: _maritialstatusselected.toString(),
      contrylivingin: countrylivinginController.text.toString(),
      statelivingin: statelivinginController.text.toString(),
      citylivingin:  citylivinginController.text.toString(),

      onSuccess: () {

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationScreen4(),
            ),
                (route) => false);


      },
    );


  }
}



