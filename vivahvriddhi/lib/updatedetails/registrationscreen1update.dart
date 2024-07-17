import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/homescreen/vivahvriddhi_home_screen.dart';
import '../authprovider/authprovider.dart';
import '../authprovider/authprovider.dart' as apx;
import '../components/custom_button_in_mobile_auth.dart';
import '../components/snackbar.dart';
class RegistrationScreen1Update extends StatefulWidget {
  static String routeName = "/registrationscreen1";
  @override
  _RegistrationScreen1UpdateState createState() => _RegistrationScreen1UpdateState();
}
class _RegistrationScreen1UpdateState extends State<RegistrationScreen1Update> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  var myDateFormat = DateFormat('d-MM-yyyy');
  String? dobSelected;
  String? nameselected;

  @override
  void initState() {

    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    final ap = Provider.of<apx.AuthProvider>(context, listen: false);
    String name=await ap.getNameOfUser();
    String dateofbirth=await ap.getDateOfBirthForOfUser();
    setState(() {
      nameselected=name;
      dobSelected=dateofbirth;
    });
  }




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
                height: MediaQuery.of(context).size.height * 0.52,
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
                        child:Text("Update Personal Information",style:TextStyle(
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
                                  nameselected=nameController.text.toString();
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "$nameselected",
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
                                    dobController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
                                    dobSelected=dobController.text.toString();
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
                                    hintText: '$dobSelected',
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
                            text: "Save",
                            onPressed: () {
                              if (nameselected==null) {
                                showSnackBar(context, "Name cannot be empty");
                              }
                              else if (dobSelected==null) {
                                showSnackBar(context, "Date of birth is mandatory");
                              }
                              else {
                                storeData();
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

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.saveUserUpdatedPersonalDataToFirebase(
      context: context,
      name: nameselected,
      dateofbirth:dobSelected,
      onSuccess: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VivahVriddhiHomeScreen(),), (route) => false);
      showSnackBar(context, "Details Updated Sucessfully");
        },
    );


  }
}

