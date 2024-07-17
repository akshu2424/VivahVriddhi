import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/models/personalcontactdetailsmodel.dart';
import 'package:vivahvriddhi/homescreen/components/uploadphotos/uploadphotoscreen.dart';
import '../authprovider/authprovider.dart';
import '../components/custom_button_in_mobile_auth.dart';
import '../components/snackbar.dart';
class RegistrationScreen7 extends StatefulWidget {
  static String routeName = "/registrationscreen7";
  @override
  _RegistrationScreen7State createState() => _RegistrationScreen7State();
}

class _RegistrationScreen7State extends State<RegistrationScreen7> {
  final TextEditingController emailcontroller = TextEditingController();

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
                height: MediaQuery.of(context).size.height * 0.55,
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
                      child: Image.asset("assets/authimages/gmail.png"),
                    ),
                    SizedBox(height: 10,),
                    Center(
                        child:Text("This mail address is used to send interests",style:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        )
                    ),

                    // 1. for giving email  to send the interests
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            TextFormField(
                              //obscureText: true, // Set obscureText to true for password input
                              cursorColor: Color(0xFF9A1F3C),
                              controller: emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (value) {
                                setState(() {
                                 emailcontroller.text = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Gmail",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xFFE8CCD2)), // Set border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xFFE8CCD2)), // Set focused border color
                                ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  child: InkWell(
                                    child: Image.asset(
                                      "assets/authimages/gmail.png",
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                // suffixIcon: nameController.text.isNotEmpty // to make password storng
                                //     ? Container(
                                //         height: 30,
                                //         width: 30,
                                //         margin: const EdgeInsets.all(10.0),
                                //         decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: Colors.deepOrangeAccent,
                                //         ),
                                //         child: Icon(
                                //           Icons.done,
                                //           color: Colors.white,
                                //           size: 20,
                                //         ),
                                //       )
                                //     : null,
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
                            text: "Register",
                            onPressed: () {

                              if(emailcontroller.text.isEmpty || emailcontroller.text.isEmpty==Null)
                              {
                                showSnackBar(context, "Enter Gmail");
                              }

                              else {
                                storeData();
                              }
                            })
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

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    PersonalContactInfoModel personalContactInfoModel =PersonalContactInfoModel(mailaddressdetails: emailcontroller.text.toString());

    ap.savePersonalContactInfoToFirebase(
      context: context,
      personalContactInfoModel: personalContactInfoModel,
      personalgmaildetails: emailcontroller.text.toString(),

      onSuccess: () {

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UploadPhotosScreen()), (route) => false);


      },
    );
  }

}




















/*


 // 1. for the mobile number as input for whats app contact
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.number,
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
                                hintText: "Enter phone number",
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
                                    onTap: () {
                                      showCountryPicker(
                                          context: context,
                                          countryListTheme:
                                              const CountryListThemeData(
                                            bottomSheetHeight: 500,
                                          ),
                                          onSelect: (value) {
                                            setState(() {
                                              selectedCountry = value;
                                            });
                                          });
                                    },
                                    child: Text(
                                      "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                suffixIcon: phoneController.text.length > 9
                                    ? Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:Colors.green, // main color
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



         // 3. for the password as input
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            TextFormField(
                              obscureText:
                                  true, // Set obscureText to true for password input
                              cursorColor: Colors.deepOrangeAccent,
                              controller: passwordcontroller,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  passwordcontroller.text = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Enter password",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xFFE8CCD2)), // Set border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xFFE8CCD2)), // Set focused border color
                                ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  child: InkWell(
                                    child: Image.asset(
                                      "assets/authimages/password.png",
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                // suffixIcon: nameController.text.isNotEmpty // to make password storng
                                //     ? Container(
                                //         height: 30,
                                //         width: 30,
                                //         margin: const EdgeInsets.all(10.0),
                                //         decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: Colors.deepOrangeAccent,
                                //         ),
                                //         child: Icon(
                                //           Icons.done,
                                //           color: Colors.white,
                                //           size: 20,
                                //         ),
                                //       )
                                //     : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),




*/