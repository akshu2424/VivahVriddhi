
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/components/snackbar.dart';

import '../components/custom_button_in_mobile_auth.dart';
import '../authprovider/authprovider.dart';

class LogIn extends StatefulWidget {
  static String routeName = "/loginscreen";
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );




  var border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Colors.white, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
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
                height: MediaQuery.of(context).size.height * 0.44,
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
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE8CCD2),
                      ),
                      child: Image.asset("assets/authimages/mobileauth.png"),
                    ),
                    const SizedBox(height: 20),
                    // 1. for the mobile number as input
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Color(0xFF841D34),
                              controller: phoneController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  phoneController.text = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Gmail Address",
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
                                // prefixIcon: Container(
                                //   padding: const EdgeInsets.all(12.0),
                                //   child: Text(
                                //     "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                //     style: const TextStyle(
                                //       fontSize: 18,
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(Icons.mail_outline_outlined),

                                ),
                                suffixIcon: phoneController.text.length > 0
                                    ? Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green, // main color
                                        ),
                                        child: const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),

                    // 2. for the password as input implement it later
                    // SizedBox(height: 20,),

                  //   Padding(
                  //   padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
                  //   child: Container(
                  //     child: Stack(
                  //       alignment: Alignment.center,
                  //       children: <Widget>[
                  //         TextFormField(
                  //           obscureText: true, // Set obscureText to true for password input
                  //           cursorColor: Colors.deepOrangeAccent,
                  //           //controller: nameController,
                  //           style: const TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           onChanged: (value) {
                  //             setState(() {
                  //               //nameController.text = value;
                  //             });
                  //           },
                  //           decoration: InputDecoration(
                  //             hintText: "Enter password",
                  //             hintStyle: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: 15,
                  //               color: Colors.grey.shade600,
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //               borderSide: BorderSide(color: Color(0xFFE8CCD2)), // Set border color
                  //             ),
                  //             focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //               borderSide: BorderSide(color: Color(0xFFE8CCD2)), // Set focused border color
                  //             ),
                  //             prefixIcon: Container(
                  //               padding: const EdgeInsets.all(12.0),
                  //               child: InkWell(
                  //                 child: Image.asset(
                  //                   "assets/authimages/password.png",
                  //                   height: 10,
                  //                   width: 10,
                  //                 ),
                  //               ),
                  //             ),
                  //             // suffixIcon: nameController.text.isNotEmpty
                  //             //     ? Container(
                  //             //         height: 30,
                  //             //         width: 30,
                  //             //         margin: const EdgeInsets.all(10.0),
                  //             //         decoration: BoxDecoration(
                  //             //           shape: BoxShape.circle,
                  //             //           color: Colors.deepOrangeAccent,
                  //             //         ),
                  //             //         child: Icon(
                  //             //           Icons.done,
                  //             //           color: Colors.white,
                  //             //           size: 20,
                  //             //         ),
                  //             //       )
                  //             //     : null,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(4)),
                  //       border: Border.all(width: 1, color: Colors.grey.shade400),
                  //     ),
                  //   ),
                  // ),

                    SizedBox(height: 40),
                    Column(
                      children: <Widget>[
                        //Text("Not registerd yet?"),
                        SizedBox(height: 6),

                            CustomButton1(text: "Continue", onPressed: (){
                              if(phoneController.text.length> 0)
                              {
                                sendPhoneNumber();
                              }
                              else
                              {
                                showSnackBar(context, "Please Enter Correct mobile number");
                              }
                            } )

                      ],
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    print(phoneNumber);
    ap.signInWithPhone(context, "$phoneNumber");
  }
}


