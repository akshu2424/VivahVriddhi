import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/homescreen/vivahvriddhi_home_screen.dart';
import '../authprovider/authprovider.dart';
import '../authprovider/authprovider.dart' as apx;
import '../components/custom_button_in_mobile_auth.dart';
import '../components/snackbar.dart';
class RegistrationScreen7Update extends StatefulWidget {
  static String routeName = "/registrationscreen1";
  @override
  _RegistrationScreen7UpdateState createState() => _RegistrationScreen7UpdateState();
}
class _RegistrationScreen7UpdateState extends State<RegistrationScreen7Update> {
  final TextEditingController gmailController = TextEditingController();
  String? gmailselected;

  @override
  void initState() {

    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    final ap = Provider.of<apx.AuthProvider>(context, listen: false);
    String gmail=await ap.getGmailAddressUser();
    setState(() {
      gmailselected=gmail;

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
                height: MediaQuery.of(context).size.height * 0.42,
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
                      child: Image.asset("assets/authimages/gmail.png"),
                    ),
                    SizedBox(height: 10,),
                    Center(
                        child:Text("Update Personal Contact Information",style:TextStyle(
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
                              controller: gmailController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  gmailController.text = value;
                                  gmailselected=gmailController.text.toString();
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "$gmailselected",
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

                    SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        //Text("Not registerd yet?"),
                        SizedBox(height: 6),
                        CustomButton(
                            text: "Save",
                            onPressed: () {
                              if (gmailselected==null) {
                                showSnackBar(context, "Name cannot be empty");
                              }
                              else {
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
    ap.saveUpdatedPersonalContactDetailsDataToFirebase(
      context: context,
      gmailaddress: gmailselected,
      onSuccess: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VivahVriddhiHomeScreen(),), (route) => false);
      showSnackBar(context, "Details Updated Sucessfully");
      },
    );


  }
}

