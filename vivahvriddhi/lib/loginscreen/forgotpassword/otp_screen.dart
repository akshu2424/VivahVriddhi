import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/components/custom_button_in_mobile_auth.dart';
import 'package:vivahvriddhi/components/snackbar.dart';
import 'package:vivahvriddhi/loginscreen/forgotpassword/resetpasswordscree.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String PhoneNumber;
  const OtpScreen(
      {super.key, required this.verificationId, required this.PhoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
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
    //final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
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
                        //verifyOtp(context, otpCode!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen()
                            ));
                      } else {
                        showSnackBar(context, "Enter 6-Digit code");
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Didn't receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: _showResendText
                      ? (isResendingOtp
                          ? null
                          : () {
                              // Provider.of<AuthProvider>(context, listen: false).resendOtp(
                              //   phoneNumber: widget.PhoneNumber,
                              //   context: context,
                              //   onSuccess: () {
                              //     // Handle success if needed
                              //   },
                              //   onFailed: (error) {
                              //     // Handle failure if needed
                              //   },
                              // );
                            })
                      : null,
                  child: Text(
                    _showResendText
                        ? "Resend OTP"
                        : "Resend OTP in $_resendCountdown s",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _showResendText
                          ? (isResendingOtp ? Colors.grey : Color(0xFF841D34))
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  // void verifyOtp(BuildContext context, String userOtp) {
  //   final ap = Provider.of<AuthProvider>(context, listen: false);

  //   ap.verifyOtp(
  //     context: context,
  //     verificationId: widget.verificationId,
  //     userOtp: userOtp,
  //     onSuccess: () {
  //       ap.checkExistingUser().then(
  //         (value) async {
  //           if (value == true) {
  //             ap.getDataFromFirestore().then(
  //               (value) => ap.saveUserDataToSP().then(
  //                 (value) => ap.setSignIn().then(
  //                   (value) => Navigator.pushAndRemoveUntil(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => HomeScreen(),
  //                     ),
  //                     (route) => false,
  //                   ),
  //                 ),
  //               ),
  //             );
  //           } else {
  //             Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => UserInfromationScreen(),
  //               ),
  //               (route) => false,
  //             );
  //           }
  //         },
  //       );
  //     },
  //   );
  // }
}
