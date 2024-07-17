import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/loginscreen/login.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen1.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen3.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen5.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen6.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen7.dart';
import 'package:vivahvriddhi/homescreen/components/uploadphotos/uploadphotoscreen.dart';
import '../components/custom_button_in_mobile_auth.dart';
import '../authprovider/authprovider.dart';
import '../homescreen/vivahvriddhi_home_screen.dart';
import '../registrationscreendetails/registrationscreen2.dart';
import '../registrationscreendetails/registrationscreen4.dart';
class SplashScreen extends StatefulWidget {
  static String routeName = "/splashscreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/authimages/background.png",
                  height: 300,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Let's get started",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "VivahVriddhi Where Hearts Find Their Perfect Beat!",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                // custom button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () async {
                      var connectivityResult = await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.none) {
                        // No internet connection
                        showNoInternetAlertDialog(context);
                      }
                      else
                        {
                          bool exists1=await ap.checkPersonalDataExists(context);
                          bool exists2=await ap.checkCommunityDataExists(context);
                          bool exists3=await ap.checkMaritalAndRegionDataExists(context);
                          bool exists4=await ap.checkPhysicalStatusDataExists(context);
                          bool exists5=await ap.checkEducationalAndOccupationDataExists(context);
                          bool exists6=await ap.checkFamilyDetailsDataExists(context);
                          //bool exists7=await ap.checkPersonalContactDetailsDataExists(context);
                          bool exists8=await ap.checkUserUploadedPhotoDataExists(context);

                          if(ap.isSignedIn == true)
                          {
                            print("------------signed in he bhai -----------------------------------");
                            if(exists1==false)
                            {
                              print("Registraion screen 1 fill nahi he ");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationScreen1(),), (route) => false);
                            }
                            else if(exists1==true && exists2==false)
                            {
                              print("Registraion screen 2 fill nahi he ");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationScreen2(),), (route) => false);
                            }
                            else if(exists2==true && exists3==false)
                            {
                              print("Registraion screen 3 fill nahi he ");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationScreen3(),), (route) => false);
                            }
                            else if(exists3==true && exists4==false)
                            {
                              print("Registraion screen 4 fill nahi he ");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationScreen4(),), (route) => false);
                            }
                            else if(exists4==true && exists5==false)
                            {
                              print("Registraion screen 5 fill nahi he ");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationScreen5(),), (route) => false);
                            }
                            else if(exists5==true && exists6==false)
                            {
                              print("Registraion screen 6 fill nahi he ");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationScreen6(),), (route) => false);
                            }
                            // else if(exists6==true && exists7==false)
                            // {
                            //   print("Registraion screen 7 fill nahi he ");
                            //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationScreen7(),), (route) => false);
                            // }
                            else if(exists6==true && exists8==false)
                            {
                              print("Registraion screen 8 fill nahi he ");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UploadPhotosScreen(),), (route) => false);
                            }
                            else
                            {
                              print("Home Screen pr jara  fill nahi he ");
                              await ap.getDataFromSP().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VivahVriddhiHomeScreen(),),),);
                            }

                          }

                          else
                          {
                            print("Signed in nahi he ---------------------------");
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn(),),);
                          }
                        }

                      },
                    text: "Get started",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
  void showNoInternetAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet Connection"),
          content: Text("Please check your internet connection and try again."),
          actions: <Widget>[
            TextButton(
              child: Text("OK",style: TextStyle(color: Color(0xFF841D34)),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}