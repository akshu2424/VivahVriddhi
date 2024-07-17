import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/homescreen/vivahvriddhi_home_screen.dart';
import 'package:vivahvriddhi/models/communityinfo.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen1.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen3.dart';
import '../authprovider/authprovider.dart';
import '../authprovider/authprovider.dart' as apx;
import '../components/custom_button_in_mobile_auth.dart';
import '../components/snackbar.dart';
class RegistrationScreen2Update extends StatefulWidget {
  static String routeName = "/registrationscreen2";
  @override
  _RegistrationScreen2UpdateState createState() => _RegistrationScreen2UpdateState();
}

class _RegistrationScreen2UpdateState extends State<RegistrationScreen2Update> {
  final TextEditingController casteController = TextEditingController();
  final TextEditingController subcasteController = TextEditingController();
  final TextEditingController _religionselectedController = TextEditingController();
  final TextEditingController _communitydecisionselectedController = TextEditingController();
  String ? _communitydecisionselected;
  String ? _religionselected;
  String? _casteselected;
  String ? _subcasteselected;


  final List<String> _communitydecision = ["Yes", "No"];
  // religion list
  final List<String> _religionlist = [
    "Hindu",
    "Christianity",
    "Buddhism",
    "Judaism",
    "Sikhism",
    "Jainism",
    "Shinto",
    "Taoism",
    "Zoroastrianism",
    "Other",
  ];

  @override
  void initState() {

    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    final ap = Provider.of<apx.AuthProvider>(context, listen: false);
    String religion=await ap.getReligionOfUser();
    String caste=await ap.getCasteOfUser();
    String subcaste=await ap.getSubCasteOfUser();
    String commdecision=await ap.getWheatherTheyMarrywithOtherCommunityOfUser();

    setState(() {
      _religionselected=religion;
      _casteselected=caste;
      _subcasteselected=subcaste;
      _communitydecisionselected=commdecision;
    });
  }


  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
        body: Center(
          child: Center(
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
                    height: MediaQuery.of(context).size.height * 0.75,
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
                          child: Image.asset("assets/authimages/community.png"),
                        ),
                        const SizedBox(height: 20),
                        // 1. for religion purpose
                        Center(
                            child:Text("Update Community Information",style:TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                            )
                        ),

                        const SizedBox(height: 10),
                        // for religon info assets/authimages/profileisfor.png

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
                                        'select Religion',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: _religionlist
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
                                      value: _religionselected,
                                      onChanged: (value) {
                                        setState(() {
                                          _religionselected = value;
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
                                        searchController: _religionselectedController,
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
                                            controller: _religionselectedController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search for Religion...',
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
                                          _religionselectedController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 2. for caste purpose
                        const SizedBox(height: 20),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 4),
                          child: Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                TextFormField(
                                  //keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFF841D34),
                                  controller: casteController,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      casteController.text = value;
                                      _casteselected=casteController.text.toString();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "$_casteselected",
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
                                      padding: const EdgeInsets.all(12.0),
                                      child: InkWell(
                                        child: Image.asset(
                                          "assets/authimages/caste.png",
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

                        // 3. for sub cast optional
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 4),
                          child: Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                TextFormField(
                                  //keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFF841D34),
                                  controller: subcasteController,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      subcasteController.text = value;
                                      _subcasteselected=subcasteController.text.toString();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "$_subcasteselected (Sub caste optional)",
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
                                      padding: const EdgeInsets.all(12.0),
                                      child: InkWell(
                                        child: Image.asset(
                                          "assets/authimages/caste.png",
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

                        // will you marry from another community  assets/authimages/decisionmaking.png
                        Padding(padding: EdgeInsets.only(left: 20, right: 20,),
                          child:Text(
                            'Will you marry from another community',
                            style: TextStyle(color: Colors.grey),
                          ),

                        ),
                        // Padding(
                        //     padding:
                        //     const EdgeInsets.only(left: 20, right: 20, top: 4),
                        //     child: FlutterDropdownSearch(
                        //       textController: _communitydecisionselectedController,
                        //       items: _communitydecision,
                        //       hintText: "select Decision ",
                        //       dropdownHeight: 300,
                        //       prefixIconImagePath: "assets/authimages/decisionmaking.png",
                        //     )
                        // ),

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
                                  child: Image.asset("assets/authimages/decisionmaking.png",width: 25,height: 25,),
                                ),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Community Decision',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: _communitydecision
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
                                      value: _communitydecisionselected,
                                      onChanged: (value) {
                                        setState(() {
                                          _communitydecisionselected = value;
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
                                        searchController: _communitydecisionselectedController,
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
                                            controller: _communitydecisionselectedController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Community decision',
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
                                          _communitydecisionselectedController.clear();
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
                                text: "Save",
                                onPressed: () {
                                  if (_religionselected == null || _religionselected!.isEmpty) {
                                    showSnackBar(context, "Select Religion");
                                  }
                                  else if (_casteselected== null || _casteselected!.isEmpty) {
                                    showSnackBar(
                                        context, "Caste cannot be empty");
                                  }
                                  else if(_communitydecisionselected == null || _communitydecisionselected !.isEmpty)
                                  {
                                    showSnackBar(context, "Select Community Decision");
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
        )
    );
  }
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    ap.saveUserUpdatedCommunityDataToFirebase(
      context: context,
      religion: _religionselected,
      caste: _casteselected,
      subcaste: _subcasteselected,
      othercommunitymarrydecision:_communitydecisionselected,

      onSuccess: () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VivahVriddhiHomeScreen(),), (route) => false);
        showSnackBar(context, "Details Updated Sucessfully");

      },
    );


  }
}
