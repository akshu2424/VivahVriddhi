import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen3.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen5.dart';
import '../authprovider/authprovider.dart';
import '../components/custom_button_in_mobile_auth.dart';
import '../components/snackbar.dart';
import '../models/physicalstatusinfo.dart';
class RegistrationScreen4 extends StatefulWidget {
  static String routeName = "/registrationscreen4";
  @override
  _RegistrationScreen4State createState() => _RegistrationScreen4State();
}
class _RegistrationScreen4State extends State<RegistrationScreen4> {
  final TextEditingController _heightenterController = TextEditingController();
  final TextEditingController _physicalstatusController = TextEditingController();
  final List<String> _physicalstatuslist = [
    "Normal",
    "Physically Challenged",
    
  ];
  String? _physicalstatusselected;

  final List<String> _heightList = [
    '4 Ft 6 In',
    '4 Ft 7 In',
    '4 Ft 8 In',
    '4 Ft 9 In',
    '4 Ft 10 In',
    '4 Ft 11 In',
    '5 Ft 0 In',
    '5 Ft 1 In',
    '5 Ft 2 In',
    '5 Ft 3 In',
    '5 Ft 4 In',
    '5 Ft 5 In',
    '5 Ft 6 In',
    '5 Ft 7 In',
    '5 Ft 8 In',
    '5 Ft 9 In',
    '5 Ft 10 In',
    '5 Ft 11 In',
    '6 Ft 0 In',
    '6 Ft 1 In',
    '6 Ft 2 In',
    '6 Ft 3 In',
    '6 Ft 4 In',
    '6 Ft 5 In',
    '6 Ft 6 In',
    '6 Ft 7 In',
    '6 Ft 8 In',
    '6 Ft 9 In',
    '6 Ft 10 In',
    '6 Ft 11 In',
    '7 Ft 0 In'
  ];
  String? _heightselected;
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
                  
                  SizedBox(width:3),
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
                height: MediaQuery.of(context).size.height * 0.5,
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
                      child: Image.asset("assets/authimages/body.png"),
                    ),
                    const SizedBox(height: 20),
                    // 1. for physical status purpose
                    Center(
                        child:Text("Physical Status Details",
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
                              child: Image.asset("assets/authimages/monitoring.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'select Physical status',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _physicalstatuslist
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
                                  value: _physicalstatusselected,
                                  onChanged: (value) {
                                    setState(() {
                                      _physicalstatusselected= value;
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
                                    searchController: _physicalstatusController,
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
                                        controller: _physicalstatusController,
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
                                      _physicalstatusController.clear();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 2. for  enter height in cm
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
                              child: Image.asset("assets/authimages/height.png",width: 25,height: 25,),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'select Height',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _heightList
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
                                  value: _heightselected,
                                  onChanged: (value) {
                                    setState(() {
                                      _heightselected= value;
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
                                    searchController: _heightenterController,
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
                                        controller: _heightenterController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for height...',
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
                                      _heightenterController.clear();
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
                       
                        CustomButton(text: "       Save       ",
                            onPressed: ()
                        {
                          if(_physicalstatusselected == null || _physicalstatusselected!.isEmpty)
                          {
                              showSnackBar(context, "Select Physical Status");
                          }
                          else if(_heightselected == null || _heightselected!.isEmpty)
                          {
                              showSnackBar(context, "Select Height");
                          }
                          else
                          {
                            storeData();
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

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);


    PhysicalStatusInfoModel physicalStatusInfoModel =PhysicalStatusInfoModel( physicalstatus: _physicalstatusselected.toString(), heightincm: _heightselected.toString(),);

    ap.savePhysicalStatusInfoToFirebase(
      context: context,
      physicalStatusInfoModel: physicalStatusInfoModel,
      physicalstatus: _physicalstatusselected.toString(),
      heightincmn: _heightselected.toString(),
      onSuccess: () {

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationScreen5(),
            ),
                (route) => false);


      },
    );


  }
}
