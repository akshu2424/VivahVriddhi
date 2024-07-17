import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/components/custom_button_in_mobile_auth.dart';
import 'package:vivahvriddhi/authprovider/authprovider.dart';
import 'package:vivahvriddhi/homescreen/vivahvriddhi_home_screen.dart';
import 'package:vivahvriddhi/registrationscreendetails/registrationscreen1.dart';
import 'package:vivahvriddhi/registrationscreendetails/userinformationscreen.dart';
import 'package:vivahvriddhi/subscriptionscreen/subscriptionscreen.dart';
import '../components/snackbar.dart';
import '../registrationscreendetails/registrationscreen2.dart';
import '../registrationscreendetails/registrationscreen3.dart';
import '../registrationscreendetails/registrationscreen4.dart';
import '../registrationscreendetails/registrationscreen5.dart';
import '../registrationscreendetails/registrationscreen6.dart';
import '../registrationscreendetails/registrationscreen7.dart';
import '../homescreen/components/uploadphotos/uploadphotoscreen.dart';
class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String PhoneNumber;
  const OtpScreen(
      {super.key, required this.verificationId, required this.PhoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String ?otpCode;
  bool isResendingOtp = false;
  bool _showResendText = false;
  int _resendCountdown = 30;
  late Timer _resendTimer;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        setState(() {
          _showResendText = true;
        });
        _resendTimer.cancel(); // Cancel the timer once countdown reaches zero
      }
    });
  }

  @override
  void dispose() {
    _resendTimer.cancel(); // Cancel the timer in the dispose method
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
        ? const Center(
        child: CircularProgressIndicator(
        color: Color(0xFF841D34),
    ),
    )
      :SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE8CCD2),
                  ),
                  child: Image.asset(
                    "assets/authimages/text.png",
                    height: 150.0,
                    width: 150.0,
                    alignment: Alignment.topCenter,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Otp Sent to ${widget.PhoneNumber}",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter the OTP sent to your phone number",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Pinput(
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xFF841D34),
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onCompleted: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    text: "Verify",
                    onPressed: () {
                      if (otpCode != null) {
                        verifyOtp(context, otpCode!);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ResetPasswordScreen()
                        //     ));
                      } else {
                        showSnackBar(context, "Enter 6-Digit code");
                      }
                    },
                  ),
                ),
                // const SizedBox(height: 20),
                // const Text(
                //   "Didn't receive any code?",
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black38,
                //   ),
                // ),
                // const SizedBox(height: 15),
                // InkWell(
                //   onTap: _showResendText
                //       ? (isResendingOtp
                //           ? null
                //           : () {
                //
                //             final ap =Provider.of<AuthProvider>(context, listen: false);
                //
                //
                //
                //             }
                //             )
                //       : null,
                //   child: Text(
                //     _showResendText
                //         ? "Resend OTP"
                //         : "Resend OTP in $_resendCountdown s",
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: _showResendText
                //           ? (isResendingOtp ? Colors.grey : Color(0xFF841D34))
                //           : Colors.grey,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      )),
    )
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () async {
        bool exists1=await ap.checkPersonalDataExists(context);
        bool exists2=await ap.checkCommunityDataExists(context);
        bool exists3=await ap.checkMaritalAndRegionDataExists(context);
        bool exists4=await ap.checkPhysicalStatusDataExists(context);
        bool exists5=await ap.checkEducationalAndOccupationDataExists(context);
        bool exists6=await ap.checkFamilyDetailsDataExists(context);
        bool exists7=await ap.checkPersonalContactDetailsDataExists(context);
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
          else if(exists6==true && exists8==false)
          {
            print("Registraion screen 7 fill nahi he ");
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationScreen7(),), (route) => false);
          }
          // else if(exists7==true && exists8==false)
          // {
          //   print("Registraion screen 8 fill nahi he ");
          //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UploadPhotosScreen(),), (route) => false);
          // }
          else
          {
            print("Home Screen pr jara  fill  he ");
            ap.checkPersonalDataExists(context).then(
                  (value) async
              {
                if (value == true) {
                  ap.getPersonalInfoDataFromFirestore().then(
                        (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                            (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>VivahVriddhiHomeScreen(),
                          ),
                              (route) => false,
                        ),
                      ),
                    ),
                  );
                }

              },
            );
          }

        }

        else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationScreen1(),
            ),
                (route) => false,
          );
        }

      },
    );
  }
}
