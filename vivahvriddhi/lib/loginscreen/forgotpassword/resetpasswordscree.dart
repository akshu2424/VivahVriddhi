import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:vivahvriddhi/components/custom_button_in_mobile_auth.dart';
class ResetPasswordScreen extends StatefulWidget {
  static String routeName = "/otpscreen";

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? otpCode;
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
                    "assets/authimages/resetpassword.png",
                    height: 150.0,
                    width: 150.0,
                    alignment: Alignment.topCenter,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 10),
                // Text(
                //   "Otp Sent to ",
                //   style: TextStyle(
                //     fontSize: 10,
                //     color: Colors.black,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                // const SizedBox(height: 10),
                const Text(
                  "Enter new Password",
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
                    text: "Enter",
                    onPressed: () {
                      // if (otpCode != null) {
                      //   //verifyOtp(context, otpCode!);
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               VivahVriddhiHomeScreen()));
                      // } else {
                      //   showSnackBar(context, "Enter 6-Digit code");
                      // }
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
                //const SizedBox(height: 15),
                // InkWell(
                //   onTap: _showResendText
                //       ? (isResendingOtp
                //           ? null
                //           : () {
                //               // Provider.of<AuthProvider>(context, listen: false).resendOtp(
                //               //   phoneNumber: widget.PhoneNumber,
                //               //   context: context,
                //               //   onSuccess: () {
                //               //     // Handle success if needed
                //               //   },
                //               //   onFailed: (error) {
                //               //     // Handle failure if needed
                //               //   },
                //               // );
                //             })
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
    );
  }

  // CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('Password');

  // Future<bool> verifyOtp(String userOtp) async {
  //   // Logic to verify OTP
  //   // You can use your existing logic here
  //   // For example, querying Firestore for the OTP
  //   // If the OTP is correct, return true, otherwise return false
  //   // For demonstration purposes, let's assume the correct OTP is "123456"
  //   QuerySnapshot querySnapshot = await _collectionRef.get();

  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  //   Map<String, dynamic> mp = allData[0] as Map<String, dynamic>;
  //   return userOtp == mp['password'];
  // }

  // Future<void> launchWhatsApp(String number) async {
  //   final link = WhatsAppUnilink(
  //     phoneNumber: number,
  //     text: "Hello, I Need OTP for Login NSSB Park Application.",
  //   );
  //   await launch('$link');
  // }
}

class WhatsAppUnilink {}
