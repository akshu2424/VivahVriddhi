import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vivahvriddhi/components/snackbar.dart';
import 'package:vivahvriddhi/mobileauth/otp_screen.dart';
import 'package:vivahvriddhi/models/educationverificationmodel.dart';
import 'package:vivahvriddhi/models/marital_status_and_region_details.dart';
import 'package:vivahvriddhi/models/personalcontactdetailsmodel.dart';
import 'package:vivahvriddhi/models/personalinfo.dart';
import 'package:vivahvriddhi/models/usermodel.dart';
import '../models/communityinfo.dart';
import '../models/education_and_occupation_details.dart';
import '../models/familydetailsinfo.dart';
import '../models/idverificationmodel.dart';
import '../models/photouploadedurls.dart';
import '../models/physicalstatusinfo.dart';
import '../models/updatepersonalinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;


  bool _isLoading = false;
  bool get isLoading => _isLoading;


  String? _uid;
  String get uid => _uid!;

  String?_verifiedPhoneno;

  String get verifiedPhoneno=>_verifiedPhoneno!;

  String ?_genderselected;
  String get genderselected=>_genderselected!;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  // for storing personal info
  PersonalInfoModel ?_personalInfoModel;
  PersonalInfoModel get personalInfoModel=>_personalInfoModel!;

  // for updating personal info

  PersonalInfoUpdateModel?_personalInfoUpdateModel;
  PersonalInfoUpdateModel get personalInfoUpdateModel=>_personalInfoUpdateModel!;

  // for storing community information
  CommunityInfoModel ? _communityInfoModel;
  CommunityInfoModel get communityInfoModel => _communityInfoModel!;

  // for storing physical status information
  PhysicalStatusInfoModel ?_physicalStatusInfoModel;
  PhysicalStatusInfoModel get physicalStatusInfoModel=> _physicalStatusInfoModel!;

  // for storing the Marital and Region Information
  MaritalStatusRegionInfoModel ? _maritalStatusRegionInfoModel;
  MaritalStatusRegionInfoModel get maritalStatusRegionInfoModel=> _maritalStatusRegionInfoModel!;

  // for storing the Education and Occupation Information
  EducationandOccupationInfoModel ? _educationandOccupationInfoModel;
  EducationandOccupationInfoModel get educationandOccupationInfoModel=>_educationandOccupationInfoModel!;

  // for storing the Family Details
  FamilyDetailsInfoModel? _familyDetailsInfoModel;
  FamilyDetailsInfoModel get familyDetailsInfoModel => _familyDetailsInfoModel!;

  // to upload the photos to firebase

  PhotoUploadedModel?_photoUploadedModel;
  PhotoUploadedModel get photoUploadedModel=>_photoUploadedModel!;

  // to save personal contact info model

  PersonalContactInfoModel?_personalContactInfoModel;
  PersonalContactInfoModel get personalContactInfoModel=>_personalContactInfoModel!;



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;


  AuthProvider() {
    checkSign();
  }


  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }




  Future sendGmailOTP({
    required String name,
    required String email,
    required String subject,
    required String message,
    required BuildContext context,

  }) async{
    final serviceId='service_dcgixol';
    final templateId='template_evzs88d';
    final userId='4w7u6aJX5nYAvbTYQ';
    final url=Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response= await http.post(
        url,
        headers: {
          'origin':'http://localhost',
          'Content-Type':'application/json',
        },
        body: json.encode(
        {
          'service_id':serviceId,
          'template_id':templateId,
          'user_id':userId,
          'template_params':{
            'user_name':name,
            'user_email':email,
            'user_subject':subject,
            'user_message':message,
          }

            }
        )
    );

    if(response.body=="OK")
    {
      showSnackBar(context, "OTP  Send on Gmail Sucessfully");
    }
    else
    {
      showSnackBar(context, "Some thing went wrong");
    }

  }
  // signin

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      //
      final random=Random();
      int verficationId=100000+random.nextInt(900000);
      print("$verficationId"+"    siddhant finaaly you will get otp");

      sendGmailOTP(name: "User", email: "$phoneNumber", subject: "Verification OTP", message: "$verficationId".toString(), context: context);
      _uid="$phoneNumber";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            verificationId: verficationId.toString(),
            PhoneNumber: phoneNumber,
          ),
        ),
      );






      // String otpVerificationurl='https://www.fast2sms.com/dev/bulkV2?authorization=hKjJg9CpzO4W57fwTBml6PrRQias8vtyqGboxNceduDULkI0XS52BUsoPlV0iGxgTjwRhcz9WkpvNm6t&route=otp&variables_values=$verficationId&flash=0&numbers=$phoneNumber';
      // Response response= await GetConnect().get(otpVerificationurl);
      // if(response.body['message']=="API closed, use DLT SMS API for sending bulk sms in india.") // now lets change url condition for testing purpose chang the condition after testing
      // {
      //       print("Sms Send Sucessfully vdsjkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      //       _uid="$phoneNumber";
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => OtpScreen(
      //             verificationId: verficationId.toString(),
      //             PhoneNumber: phoneNumber,
      //           ),
      //         ),
      //       );
      //
      // }


    }  catch (e) {
      showSnackBar(context, "Error occured try after some time");
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {

      if(userOtp==verificationId)
        {
          saveUserDataToSP();
          getDataFromSP();
          setSignIn();
          onSuccess();

        }
      else
        {
          showSnackBar(context, "InValid OTP");
        }
      _isLoading = false;
      notifyListeners();
    }  catch (e) {
      showSnackBar(context, "InValid OTP or Error Occured Try after Some time");
      _isLoading = false;
      notifyListeners();
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser() async {

    DocumentSnapshot snapshot = await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER"+"$_uid");
      return false;
    }
  }

  // function to save registeration information details
  void saveUserDataToFirebase({
   required BuildContext context,
    required UserModel userModel,
    required name,
    required gmail,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      // await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
      //   final now = DateTime.now();
      //   final formattedDate = DateFormat("dd-MM-yyyy").format(now);
      //   userModel.profilePic = value;
      //   userModel.createdAt = formattedDate.toString();
      //   userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      //   userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      // });
      userModel.uid = _verifiedPhoneno!;
      userModel.phoneNumber = _verifiedPhoneno!;
      userModel.name=name;
      userModel.email=gmail;

      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }


  // upload Id for verification

  void saveUserUploadedIDPhotoToFirebase({
    required BuildContext context,
    required IDVerificationInfoModel idVerificationInfoModel,
    required File uploadidphoto,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("IDPhotoUploadedInfo/$_uid/uploadidphoto", uploadidphoto).then((value) {
        idVerificationInfoModel.uploadidphoto=value;
      }
      );

      // uploading to database

      IDVerificationInfoModel idverificationphoto =idVerificationInfoModel;
      if(_genderselected=="Male")
      {
        await _firebaseFirestore.collection("Male").doc(_uid).collection("IDPhotoUploadedInfo").doc(_uid)
            .set(idverificationphoto.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("IDPhotoUploadedInfo").doc(_uid)
            .set(idverificationphoto.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }


  // save uploaded photo about education

  void saveUserUploadedEducationDetailsPhotoToFirebase({
    required BuildContext context,
    required EducationVerificationInfoModel educationVerificationInfoModel,
    required File uploadeducationcertificate,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("EducationTranscriptPhotoUploadedInfo/$_uid/uploadeducationcertificate", uploadeducationcertificate).then((value) {
        educationVerificationInfoModel.uploadeducationcertificate=value;
      }
      );

      // uploading to database

      EducationVerificationInfoModel educationverificationphoto =educationVerificationInfoModel;
      if(_genderselected=="Male")
      {
        await _firebaseFirestore.collection("Male").doc(_uid).collection("EducationTranscriptPhotoUploadedInfo").doc(_uid)
            .set(educationverificationphoto.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("EducationTranscriptPhotoUploadedInfo").doc(_uid)
            .set(educationverificationphoto.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }









  // function to upload the photos to firebasestorage
  void saveUserUploadedPhotoToFirebase({
    required BuildContext context,
    required PhotoUploadedModel photoUploadedModel,
    required File photouploaded1,
    required File photouploaded2,
    required File photouploaded3,
    required File photouploaded4,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("PhotoUploadedFolder/$_uid/photoupload1", photouploaded1).then((value) {
        photoUploadedModel.photouploaded1=value;
      }
      );

      await storeFileToStorage("PhotoUploadedFolder/$_uid/photoupload2", photouploaded2).then((value) {
        photoUploadedModel.photouploaded2=value;
      }
      );

      await storeFileToStorage("PhotoUploadedFolder/$_uid/photoupload3", photouploaded3).then((value) {
        photoUploadedModel.photouploaded3=value;
      }
      );

      await storeFileToStorage("PhotoUploadedFolder/$_uid/photoupload4", photouploaded4).then((value) {
        photoUploadedModel.photouploaded4=value;
      }
      );


      // uploading to database

      PhotoUploadedModel photomodel =photoUploadedModel;
      if(_genderselected=="Male")
      {
        await _firebaseFirestore.collection("Male").doc(_uid).collection("PhotoUploadedInfo").doc(_uid)
            .set(photomodel.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayMale").doc(_uid).update(photomodel.toMap());
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("PhotoUploadedInfo").doc(_uid)
            .set(photomodel.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayFemale").doc(_uid).update(photomodel.toMap());
          _isLoading = false;
          notifyListeners();
        });

      }

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }


  // function for getting the 4 url of uploaded by users

  // for photo 1

  Future<String> getURLforPhoto1() async
  {
    DocumentSnapshot snapshotM = await FirebaseFirestore.instance.collection("Male").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
    if(snapshotM.exists)
    {

      String Photo1 = snapshotM.get('photouploaded1');
      return Photo1;
    }

    if(snapshotF.exists)
      {
        String Photo1 = snapshotF.get('photouploaded1');
        return Photo1;
      }

    return 'https://firebasestorage.googleapis.com/v0/b/vivahvriddhi-53b90.appspot.com/o/LoadingPhotos%2Fuser.png?alt=media&token=88ca00f5-4be8-4a17-83b4-b736fc5f4bf9';

  }

  // for photo 2

  Future<String> getURLforPhoto2() async
  {
    DocumentSnapshot snapshotM = await FirebaseFirestore.instance.collection("Male").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String Photo2 = snapshotM.get('photouploaded2');
      return Photo2;
    }

    if(snapshotF.exists)
    {
      String Photo2 = snapshotF.get('photouploaded2');
      return Photo2;
    }

    return 'https://firebasestorage.googleapis.com/v0/b/vivahvriddhi-53b90.appspot.com/o/LoadingPhotos%2Fuser.png?alt=media&token=88ca00f5-4be8-4a17-83b4-b736fc5f4bf9';

  }

  // for photo 3

  Future<String> getURLforPhoto3() async
  {
    DocumentSnapshot snapshotM = await FirebaseFirestore.instance.collection("Male").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String Photo3 = snapshotM.get('photouploaded3');
      return Photo3;
    }

    if(snapshotF.exists)
    {
      String Photo3 = snapshotF.get('photouploaded3');
      return Photo3;
    }

    return 'https://firebasestorage.googleapis.com/v0/b/vivahvriddhi-53b90.appspot.com/o/LoadingPhotos%2Fuser.png?alt=media&token=88ca00f5-4be8-4a17-83b4-b736fc5f4bf9';

  }

  // for photo 4

  Future<String> getURLforPhoto4() async
  {
    DocumentSnapshot snapshotM = await FirebaseFirestore.instance.collection("Male").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String Photo4 = snapshotM.get('photouploaded4');
      return Photo4;
    }

    if(snapshotF.exists)
    {
      String Photo4 = snapshotF.get('photouploaded4');
      return Photo4;
    }

    return 'https://firebasestorage.googleapis.com/v0/b/vivahvriddhi-53b90.appspot.com/o/LoadingPhotos%2Fuser.png?alt=media&token=88ca00f5-4be8-4a17-83b4-b736fc5f4bf9';

  }

  Future<bool> checkUserUploadedPhotoDataExists(BuildContext context) async {

    bool check = false;
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF841D34),),
        );
      },
    );

    try {
      // Perform Firestore operation
      bool value = await getDataFromSP();
      if (value) {
        DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
        DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PhotoUploadedInfo").doc(_uid).get();
        if (snapshotM.exists || snapshotF.exists) {
          print("-------------------------------8 USER EXISTS");
          check= true;
        } else {
          print("-----------------------------8  NEW USER");
          check= false;
        }
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    } finally {
      // Close the progress indicator dialog
      Navigator.pop(context);
    }

    return check;


  }


  // function to save the personal information

  void saveUserPersonalDataToFirebase({
    required BuildContext context,
    required PersonalInfoModel personalInfoModel,
    required Function onSuccess,
    required name,
    required profileisfor,
    required gender,
    required dateofbirth
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      PersonalInfoModel model =PersonalInfoModel(name: name, profileisfor: profileisfor, gender: gender, dateofbirth: dateofbirth,);

      // uploading to database
      print(gender+"dvwhhhhhhhhhhhhhhhhhhj");
      if(gender=="Male")
        {
          _genderselected="Male";
          await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalInfo").doc(_uid)
              .set(model.toMap())
              .then((value) {

            onSuccess();
            _firebaseFirestore.collection("DisplayMale").doc(_uid).set(model.toMap());
            _isLoading = false;
            notifyListeners();
          });
          saveUserDataToSP();
        }
      else
        {
          _genderselected="Female";
          await _firebaseFirestore
              .collection("Female")
              .doc(_uid).collection("PersonalInfo").doc(_uid).set(model.toMap())
              .then((value) {

            onSuccess();
            _firebaseFirestore.collection("DisplayFemale").doc(_uid).set(model.toMap());

            _isLoading = false;
            notifyListeners();
          });
          saveUserDataToSP();
        }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to Update personal information of the user
  Future<void> updatePersonalInfo(String documentId, String Gender,String name,String dob) async {
    try {
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("PersonalInfo").doc(documentId).update({'name': name});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("PersonalInfo").doc(documentId).update({'dateofbirth':dob});
      if(Gender=="Male")
      {
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'name': name});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'dateofbirth':dob});
      }
      else
      {
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'name': name});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'dateofbirth':dob});
      }
      print('Status updated successfully');
    } catch (e) {
      print('Error updating status: $e');
    }
  }


  void saveUserUpdatedPersonalDataToFirebase({
    required BuildContext context,
    required Function onSuccess,
    required name,
    required dateofbirth
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.


      // uploading to database
      if(_genderselected=="Male")
      {
        updatePersonalInfo(_uid!,"Male",name,dateofbirth)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        updatePersonalInfo(_uid!,"Female",name,dateofbirth)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> getNameOfUser() async
  {

    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String name = snapshotM.get('name');
      return name;
    }

    if(snapshotF.exists)
    {
      String name = snapshotF.get('name');
      return name;
    }
    return '';

  }

  // function to get gender of the user

  Future<String> getGenderOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String gender = "Male";
      return gender;
    }

    if(snapshotF.exists)
    {
      String gender = "Female";
      return gender;
    }

    return '';

  }

  // profile is for selected
  Future<String> getProfileisForOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String profilesisfor = snapshotM.get('profileisfor');
      return profilesisfor;
    }

    if(snapshotF.exists)
    {
      String profilesisfor = snapshotF.get('profileisfor');
      return profilesisfor;
    }

    return '';

  }

  // function to get date of birth

  Future<String> getDateOfBirthForOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String dateofbirth= snapshotM.get('dateofbirth');
      return dateofbirth;
    }

    if(snapshotF.exists)
    {
      String dateofbirth = snapshotF.get('dateofbirth');
      return dateofbirth;
    }

    return '';

  }






  // function to check personal data in database exists or not
  Future<bool> checkPersonalDataExists(BuildContext context) async {
    bool check = false;
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF841D34),),
        );
      },
    );

    try {
      // Perform Firestore operation
      bool value = await getDataFromSP();
      if (value) {
        DocumentSnapshot snapshotM = await _firebaseFirestore
            .collection("Male")
            .doc("$_uid")
            .collection("PersonalInfo")
            .doc("$_uid")
            .get();
        DocumentSnapshot snapshotF = await _firebaseFirestore
            .collection("Female")
            .doc("$_uid")
            .collection("PersonalInfo")
            .doc("$_uid")
            .get();

        if (snapshotM.exists || snapshotF.exists) {
          print("USER EXISTS");
          check = true;
        } else {
          print("NEW USER Ye he Uid $_uid");
          check = false;
        }
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    } finally {
      // Close the progress indicator dialog
      Navigator.pop(context);
    }

    return check;
  }


  // function to store the community information
  void saveUserCommunityDataToFirebase({
    required BuildContext context,
    required CommunityInfoModel communityInfoModel,
    required Function onSuccess,
    required religion,
    required caste,
    required subcaste,
    required othercommunitymarrydecision
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      CommunityInfoModel model =CommunityInfoModel(religion: religion, caste: caste, subcaste: subcaste, othercommunitymarrydecision: othercommunitymarrydecision,);
      if(_genderselected=="Male")
      {
        await _firebaseFirestore
            .collection("Male")
            .doc(_uid).collection("CommunityInfo").doc(_uid)
            .set(model.toMap())
            .then((value) {

          onSuccess();
          _firebaseFirestore.collection("DisplayMale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("CommunityInfo").doc(_uid)
            .set(model.toMap())
            .then((value) {

          onSuccess();
          _firebaseFirestore.collection("DisplayFemale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to check community data exists to firebase or not
  Future<bool> checkCommunityDataExists(BuildContext context) async {
    bool check = false;
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF841D34),),
        );
      },
    );

    try {
      // Perform Firestore operation
      bool value = await getDataFromSP();
      if (value) {
        DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc("$_uid").collection("CommunityInfo").doc("$_uid").get();
        DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc("$_uid").collection("CommunityInfo").doc("$_uid").get();
        if (snapshotM.exists || snapshotF.exists)
        {
          print("----------2 USER EXISTS $_uid");
          check= true;
        } else {
          print("----------2 NEW USER $_uid");
          check= false;
        }
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    } finally {
      // Close the progress indicator dialog
      Navigator.pop(context);
    }

    return check;



  }


  // function to get religion info

  Future<String> getReligionOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("CommunityInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("CommunityInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String religion = snapshotM.get('religion');
      return religion;
    }

    if(snapshotF.exists)
    {
      String religion = snapshotF.get('religion');
      return religion;
    }

    return '';

  }

  // function to get caste of the user

  Future<String> getCasteOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("CommunityInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("CommunityInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String caste = snapshotM.get('caste');
      return caste;
    }

    if(snapshotF.exists)
    {
      String caste = snapshotF.get('caste');
      return caste;
    }

    return '';

  }

  // function to get subcaset of the user

  Future<String> getSubCasteOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("CommunityInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("CommunityInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String subcaste = snapshotM.get('subcaste');
      return subcaste;
    }

    if(snapshotF.exists)
    {
      String subcaste = snapshotF.get('subcaste');
      return subcaste;
    }

    return '';

  }

  // function to visible the dicision of the wheather he or she willin to marry with other community

  Future<String> getWheatherTheyMarrywithOtherCommunityOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("CommunityInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("CommunityInfo").doc(_uid).get();
    if(snapshotM.exists)
    {
      String othercommunitymarrydecision = snapshotM.get('othercommunitymarrydecision');
      return othercommunitymarrydecision;
    }

    if(snapshotF.exists)
    {
      String othercommunitymarrydecision = snapshotF.get('othercommunitymarrydecision');
      return othercommunitymarrydecision;
    }

    return '';

  }

  // function to Update COmmunity information of the user
  Future<void> updateCommunityInfo(String documentId, String Gender,String religion,String caste,String subcaste,String othercommunitymarrydecision) async {
    try {
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("CommunityInfo").doc(documentId).update({'religion': religion});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("CommunityInfo").doc(documentId).update({'caste':caste});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("CommunityInfo").doc(documentId).update({'subcaste': subcaste});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("CommunityInfo").doc(documentId).update({'othercommunitymarrydecision':othercommunitymarrydecision});
      if(Gender=="Male")
      {
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'religion': religion});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'caste':caste});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'subcaste': subcaste});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'othercommunitymarrydecision':othercommunitymarrydecision});
      }
      else
      {
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'religion': religion});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'caste':caste});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'subcaste': subcaste});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'othercommunitymarrydecision':othercommunitymarrydecision});
      }
      print('Status updated successfully');
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  void saveUserUpdatedCommunityDataToFirebase({
    required BuildContext context,
    required Function onSuccess,
    required religion,
    required caste,
    required subcaste,
    required othercommunitymarrydecision
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.


      // uploading to database
      if(_genderselected=="Male")
      {
        updateCommunityInfo(_uid!,"Male",religion,caste,subcaste,othercommunitymarrydecision)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        updateCommunityInfo(_uid!,"Female",religion,caste,subcaste,othercommunitymarrydecision)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }





  // function to save Marital status and Region Details

  void saveUserMartialandRegionDataToFirebase({
    required BuildContext context,
    required MaritalStatusRegionInfoModel maritalStatusRegionInfoModel,
    required Function onSuccess,
    required maritalstatus,
    required contrylivingin,
    required statelivingin,
    required citylivingin
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      MaritalStatusRegionInfoModel model =MaritalStatusRegionInfoModel(maritalstatus: maritalstatus, contrylivingin: contrylivingin, statelivingin: statelivingin, citylivingin: citylivingin, );
      if(_genderselected=="Male")
      {
        await _firebaseFirestore
            .collection("Male")
            .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayMale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayFemale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to get marital status
  Future<String> getMaritalStatusOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String maritalstatus = snapshotM.get('maritalstatus');
      return maritalstatus;
    }

    if (snapshotF.exists) {
      String maritalstatus = snapshotF.get('maritalstatus');
      return maritalstatus;
    }

    return '';
  }

  // function to get country of the user
  Future<String> getCOuntryOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String contrylivingin = snapshotM.get('contrylivingin');
      return contrylivingin;
    }

    if (snapshotF.exists) {
      String contrylivingin = snapshotF.get('contrylivingin');
      return contrylivingin;
    }

    return '';
  }

  // function to get state of the country

  Future<String> getStateOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String statelivingin = snapshotM.get('statelivingin');
      return statelivingin;
    }

    if (snapshotF.exists) {
      String statelivingin = snapshotF.get('statelivingin');
      return statelivingin;
    }

    return '';
  }

  // function to get city of the user

  Future<String> getCityOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String citylivingin = snapshotM.get('citylivingin');
      return citylivingin;
    }

    if (snapshotF.exists) {
      String citylivingin = snapshotF.get('citylivingin');
      return citylivingin;
    }

    return '';
  }

  // function to Update COmmunity information of the user
  Future<void> updateMaritalAndRegionInfo(String documentId, String Gender,String maritalstatus,String contrylivingin,String statelivingin,String citylivingin) async {
    try {
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("MaritalStatusRegionInfo").doc(documentId).update({'maritalstatus': maritalstatus});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("MaritalStatusRegionInfo").doc(documentId).update({'contrylivingin':contrylivingin});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("MaritalStatusRegionInfo").doc(documentId).update({'statelivingin': statelivingin});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("MaritalStatusRegionInfo").doc(documentId).update({'citylivingin':citylivingin});

      if(Gender=="Male")
      {
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'maritalstatus': maritalstatus});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'contrylivingin':contrylivingin});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'statelivingin': statelivingin});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'citylivingin':citylivingin});
      }
      else
      {
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'maritalstatus': maritalstatus});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'contrylivingin':contrylivingin});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'statelivingin': statelivingin});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'citylivingin':citylivingin});
      }
      print('Status updated successfully');
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  // function to save updated regiona dn martital info
  void saveUserUpdatedRegionAndRegionDataToFirebase({
    required BuildContext context,
    required Function onSuccess,
    required maritalstatus,
    required contrylivingin,
    required statelivingin,
    required citylivingin
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.


      // uploading to database
      if(_genderselected=="Male")
      {
        updateMaritalAndRegionInfo(_uid!,"Male",maritalstatus,contrylivingin,statelivingin,citylivingin)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        updateMaritalAndRegionInfo(_uid!,"Female",maritalstatus,contrylivingin,statelivingin,citylivingin)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkMaritalAndRegionDataExists(BuildContext context) async {

    bool check = false;
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF841D34),),
        );
      },
    );

    try {
      // Perform Firestore operation
      bool value = await getDataFromSP();
      if (value) {
        DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid).get();
        DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("MaritalStatusRegionInfo").doc(_uid).get();
        if (snapshotM.exists || snapshotF.exists) {
          print("----------------3 USER EXISTS");
          check= true;
        } else {
          print("--------------3 NEW USER");
          check=false;
        }
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    } finally {
      // Close the progress indicator dialog
      Navigator.pop(context);
    }

    return check;



  }


  // function to save physical status to firebase
  void savePhysicalStatusInfoToFirebase({
    required BuildContext context,
    required PhysicalStatusInfoModel physicalStatusInfoModel,
    required Function onSuccess,
    required physicalstatus,
    required heightincmn,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      PhysicalStatusInfoModel model =PhysicalStatusInfoModel(physicalstatus: physicalstatus, heightincm:heightincmn );
      if(_genderselected=="Male")
      {
        await _firebaseFirestore
            .collection("Male")
            .doc(_uid).collection("PhysicalStatusInfo").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayMale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("PhysicalStatusInfo").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayFemale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to get physical status
  Future<String> getPhysicalOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("PhysicalStatusInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("PhysicalStatusInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String physicalstatus = snapshotM.get('physicalstatus');
      return physicalstatus;
    }

    if (snapshotF.exists) {
      String physicalstatus = snapshotF.get('physicalstatus');
      return physicalstatus;
    }

    return '';
  }

  // function to get height of the person

  Future<String> getHeightOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("PhysicalStatusInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("PhysicalStatusInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('heightincm');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('heightincm');
      return heightincm;
    }

    return '';
  }

  Future<void> updatePhysicalInfoOfUser(String documentId, String Gender,String physicalstatus,String heightincm) async {
    try {
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("PhysicalStatusInfo").doc(documentId).update({'physicalstatus': physicalstatus});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("PhysicalStatusInfo").doc(documentId).update({'heightincm':heightincm});
      if(Gender=="Male")
      {
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'physicalstatus': physicalstatus});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'heightincm':heightincm});

      }
      else
      {
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'physicalstatus': physicalstatus});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'heightincm':heightincm});

      }
      print('Status updated successfully');
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  // function to save updated regiona dn martital info
  void saveUpdatedPhysicalDataToFirebase({
    required BuildContext context,
    required Function onSuccess,
    required physicalstatus,
    required heightincm,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.


      // uploading to database
      if(_genderselected=="Male")
      {
        updatePhysicalInfoOfUser(_uid!,"Male",physicalstatus,heightincm)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        updatePhysicalInfoOfUser(_uid!,"Female",physicalstatus,heightincm)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkPhysicalStatusDataExists(BuildContext context) async {

    bool check = false;
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF841D34),),
        );
      },
    );

    try {
      // Perform Firestore operation
      bool value = await getDataFromSP();
      if (value) {
        DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PhysicalStatusInfo").doc(_uid).get();
        DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PhysicalStatusInfo").doc(_uid).get();
        if (snapshotM.exists || snapshotF.exists) {
          print("---------------4 USER EXISTS");
          check= true;
        } else {
          print("--------------------4 NEW USER");
          check= false;
        }
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    } finally {
      // Close the progress indicator dialog
      Navigator.pop(context);
    }

    return check;


  }



  // function to save the education and occupation details

  void saveEducationandOccupationInfoToFirebase({
    required BuildContext context,
    required EducationandOccupationInfoModel educationandOccupationInfoModel,
    required Function onSuccess,
    required educationdone,
    required employedin,
    required occupation,
    required annualincome
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      EducationandOccupationInfoModel model =EducationandOccupationInfoModel(educationdone: educationdone, employedin: employedin, occupation:occupation, annualincome: annualincome,);
      if(_genderselected=="Male")
      {
        await _firebaseFirestore
            .collection("Male")
            .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayMale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayFemale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to get education

  Future<String> getEducationOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('educationdone');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('educationdone');
      return heightincm;
    }

    return '';
  }
  // function to get employed in
  Future<String> getEmployedinOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('employedin');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('employedin');
      return heightincm;
    }

    return '';
  }

  // function to get occupation

  Future<String> getOccupationOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('occupation');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('occupation');
      return heightincm;
    }

    return '';
  }

  // function to get annual income of the user
  Future<String> getAnnualIncomeOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("EducationandOccupationInfo").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('annualincome');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('annualincome');
      return heightincm;
    }

    return '';
  }

  // function to update the occupational details

  Future<void> updateEducationalAndOccupationOfUser(String documentId, String Gender,String educationdone,String employedin,String occupation,String annualincome ) async {
    try {
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("EducationandOccupationInfo").doc(documentId).update({'educationdone': educationdone});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("EducationandOccupationInfo").doc(documentId).update({'employedin':employedin});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("EducationandOccupationInfo").doc(documentId).update({'occupation': occupation});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("EducationandOccupationInfo").doc(documentId).update({'annualincome':annualincome});
      if(Gender=="Male")
      {
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'educationdone': educationdone});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'employedin':employedin});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'occupation': occupation});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'annualincome':annualincome});
      }
      else
      {
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'educationdone': educationdone});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'employedin':employedin});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'occupation': occupation});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'annualincome':annualincome});
      }

      print('Status updated successfully');
    } catch (e) {
      print('Error updating status: $e');
    }
  }
  // function to save updated the data t firestore

  void saveUpdatedEducationalAndOccupationDataToFirebase({
    required BuildContext context,
    required Function onSuccess,
    required educationdone,
    required employedin,
    required occupation,
    required annualincome,

  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.


      // uploading to database
      if(_genderselected=="Male")
      {
        updateEducationalAndOccupationOfUser(_uid!,"Male",educationdone,employedin,occupation,annualincome)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        updateEducationalAndOccupationOfUser(_uid!,"Female",educationdone,employedin,occupation,annualincome)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkEducationalAndOccupationDataExists(BuildContext context) async {

    bool check = false;
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF841D34),),
        );
      },
    );

    try {
      // Perform Firestore operation
      bool value = await getDataFromSP();
      if (value) {
        DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("EducationandOccupationInfo").doc(_uid).get();
        DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("EducationandOccupationInfo").doc(_uid).get();
        if (snapshotM.exists || snapshotF.exists) {
          print("--------------------5 USER EXISTS");
          check= true;
        } else {
          print("----------------5 NEW USER");
          check= false;
        }
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    } finally {
      // Close the progress indicator dialog
      Navigator.pop(context);
    }

    return check;



  }




  // function to save family details

  void saveFamilyDetailsInfoToFirebase({
    required BuildContext context,
    required FamilyDetailsInfoModel familyDetailsInfoModel,
    required Function onSuccess,
    required familytype,
    required fathersoccupation,
    required motheroccupation,
    required totalfamilymembers
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      FamilyDetailsInfoModel model =FamilyDetailsInfoModel(familytype: familytype, fathersoccupation: fathersoccupation, motheroccupation: motheroccupation, totalfamilymembers: totalfamilymembers);
      if(_genderselected=="Male")
      {
        await _firebaseFirestore
            .collection("Male")
            .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayMale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayFemale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to get family details
  Future<String> getFamilyTypeOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('familytype');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('familytype');
      return heightincm;
    }

    return '';
  }

  // function to get  fathers occupation

  Future<String> getFathersOccupationOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('fathersoccupation');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('fathersoccupation');
      return heightincm;
    }

    return '';
  }

  // function to get mothers occupation

  Future<String> getMothersOccupationOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('motheroccupation');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('motheroccupation');
      return heightincm;
    }

    return '';
  }

  // function to get totalfamily members

  Future<String> getTotalFamilyMembersOfUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male")
        .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
        .get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female")
        .doc(_uid).collection("FamilyInfoDetails").doc(_uid)
        .get();
    if (snapshotM.exists) {
      String heightincm = snapshotM.get('totalfamilymembers');
      return heightincm;
    }

    if (snapshotF.exists) {
      String heightincm = snapshotF.get('totalfamilymembers');
      return heightincm;
    }

    return '';
  }

  // function to update the details of family
  Future<void> updateFamilyDetailsOfUser(String documentId, String Gender,String familytype,String fathersoccupation,String motheroccupation,String totalfamilymembers ) async {
    try {
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("FamilyInfoDetails").doc(documentId).update({'familytype': familytype});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("FamilyInfoDetails").doc(documentId).update({'fathersoccupation':fathersoccupation});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("FamilyInfoDetails").doc(documentId).update({'motheroccupation': motheroccupation});
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("FamilyInfoDetails").doc(documentId).update({'totalfamilymembers':totalfamilymembers});
      if(Gender=="Male")
      {
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'familytype': familytype});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'fathersoccupation':fathersoccupation});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'motheroccupation': motheroccupation});
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'totalfamilymembers':totalfamilymembers});
      }
      else
      {
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'familytype': familytype});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'fathersoccupation':fathersoccupation});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'motheroccupation': motheroccupation});
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'totalfamilymembers':totalfamilymembers});
      }

      print('Status updated successfully');
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  void saveUpdatedFamilyDetailsDataToFirebase({
    required BuildContext context,
    required Function onSuccess,
    required familytype,
    required fathersoccupation,
    required motheroccupation,
    required totalfamilymembers,

  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.


      // uploading to database
      if(_genderselected=="Male")
      {
        updateFamilyDetailsOfUser(_uid!,"Male",familytype,fathersoccupation,motheroccupation,totalfamilymembers)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        updateFamilyDetailsOfUser(_uid!,"Female",familytype,fathersoccupation,motheroccupation,totalfamilymembers)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkFamilyDetailsDataExists(BuildContext context) async {

    bool check = false;
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF841D34),),
        );
      },
    );

    try {
      // Perform Firestore operation
      bool value = await getDataFromSP();
      if (value) {
        DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("FamilyInfoDetails").doc(_uid).get();
        DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("FamilyInfoDetails").doc(_uid).get();
        if (snapshotM.exists || snapshotF.exists) {
          print("------------------------6 USER EXISTS");
          check= true;
        } else {
          print("-------------------------6 NEW USER");
          check= false;
        }
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    } finally {
      // Close the progress indicator dialog
      Navigator.pop(context);
    }

    return check;



  }

  // to save personal info conatct details to firebase

  void savePersonalContactInfoToFirebase({
    required BuildContext context,
    required PersonalContactInfoModel personalContactInfoModel,
    required Function onSuccess,
    required personalgmaildetails,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      PersonalContactInfoModel model =PersonalContactInfoModel(mailaddressdetails: personalgmaildetails);
      if(_genderselected=="Male")
      {
        await _firebaseFirestore
            .collection("Male")
            .doc(_uid).collection("PersonalContactInfoDetails").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayMale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        await _firebaseFirestore
            .collection("Female")
            .doc(_uid).collection("PersonalContactInfoDetails").doc(_uid)
            .set(model.toMap())
            .then((value) {
          onSuccess();
          _firebaseFirestore.collection("DisplayFemale").doc(_uid).update(model.toMap());
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // to get gmail address

  Future<String> getGmailAddressUser() async
  {
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalContactInfoDetails").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalContactInfoDetails").doc(_uid).get();
    if (snapshotM.exists) {
      String gmail = snapshotM.get('mailaddressdetails');
      return gmail;
    }

    if (snapshotF.exists) {
      String gmail = snapshotF.get('mailaddressdetails');
      return gmail;
    }

    return '';
  }



  // function to update the details of conatct
  Future<void> updatePersonalContactDetailsOfUser(String documentId, String Gender,String gmailaddress) async {
    try {
      await _firebaseFirestore.collection(Gender).doc(documentId).collection("PersonalContactInfoDetails").doc(documentId).update({'mailaddressdetails': gmailaddress});
      if(Gender=="Male")
      {
        await _firebaseFirestore.collection("DisplayMale").doc(documentId).update({'mailaddressdetails': gmailaddress});

      }
      else
      {
        await _firebaseFirestore.collection("DisplayFemale").doc(documentId).update({'mailaddressdetails': gmailaddress});

      }

      print('Status updated successfully');
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  void saveUpdatedPersonalContactDetailsDataToFirebase({
    required BuildContext context,
    required Function onSuccess,
    required gmailaddress,


  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.


      // uploading to database
      if(_genderselected=="Male")
      {
        updatePersonalContactDetailsOfUser(_uid!,"Male",gmailaddress)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
      else
      {
        updatePersonalContactDetailsOfUser(_uid!,"Female",gmailaddress)
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkPersonalContactDetailsDataExists(BuildContext context) async {

    bool check = false;
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF841D34),),
        );
      },
    );

    try {
      // Perform Firestore operation
      bool value = await getDataFromSP();
      if (value) {
        DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalContactInfoDetails").doc(_uid).get();
        DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalContactInfoDetails").doc(_uid).get();
        if (snapshotM.exists || snapshotF.exists) {
          print("-----------------------7 USER EXISTS");
          check= true;
        } else {
          print("-----------------------7 NEW USER");
          check= false;
        }
      }
    } catch (error) {
      // Handle error
      print("Error: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    } finally {
      // Close the progress indicator dialog
      Navigator.pop(context);
    }

    return check;


  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getPersonalInfoDataFromFirestore() async {
    print("-------------------------------------------");
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalInfo").doc(_uid).get();

    if(snapshotM.exists)
    {
      await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalInfo").doc(_uid).get()
          .then((DocumentSnapshot snapshot) {
        _personalInfoModel = PersonalInfoModel(
          name: snapshot.get('name'),
          profileisfor: snapshot['profileisfor'],
          gender: snapshot['gender'],
          dateofbirth: snapshot['dateofbirth'],

        );
      }
      );
    }
    if(snapshotF.exists)
    {
      await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalInfo").doc(_uid).get()
          .then((DocumentSnapshot snapshot) {
        _personalInfoModel = PersonalInfoModel(
          name: snapshot.get('name'),
          profileisfor: snapshot['profileisfor'],
          gender: snapshot['gender'],
          dateofbirth: snapshot['dateofbirth'],
        );
        //_uid = _uid;

      }
      );
    }
  }


  // STORING DATA LOCALLY
  Future saveUserDataToSP() async
  {
    SharedPreferences s = await SharedPreferences.getInstance();
    print("Shared preferences function called dvwiuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
    await s.setString("user_model", _uid!);
    DocumentSnapshot snapshotM = await _firebaseFirestore.collection("Male").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    DocumentSnapshot snapshotF = await _firebaseFirestore.collection("Female").doc(_uid).collection("PersonalInfo").doc(_uid).get();
    if(snapshotM.exists)
      {
        await s.setString('gender_Selected', "Male");
      }
    if(snapshotF.exists)
      {
        await s.setString('gender_Selected', "Female");
      }

    print("$_genderselected"+"Shared prefercence me set he gender ");

  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    String data1=s.getString("gender_Selected")??'';
    if(data!='')
    {
      _uid= data;
    }

    if(data1!='')
      {
        _genderselected=data1;
      }

    print("$_uid"+" le shared preference wali uid fenviiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiij");
    print("$_genderselected"+" le shared preference wali uid fenviiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiij");
    notifyListeners();
    return true;
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

  // think on it later
  Future resendOtp({
    required String phoneNumber,
    required String userOtp,
    required BuildContext context,
    required Function onSuccess,
    required Function(dynamic error) onFailed,
  }) async {
    try {
      final random=Random();
      int verficationId=100000+random.nextInt(900000);
      print("$verficationId"+"    siddhant finaaly you will get Resend newotp");
      String otpVerificationurl='https://www.fast2sms.com/dev/bulkV2?authorization=hKjJg9CpzO4W57fwTBml6PrRQias8vtyqGboxNceduDULkI0XS52BUsoPlV0iGxgTjwRhcz9WkpvNm6t&route=otp&variables_values=$verficationId&flash=0&numbers=$phoneNumber';
      Response response= await GetConnect().get(otpVerificationurl);
      if(response.body['message'][0]=="SMS sent successfully." || response.body['return']==false)
      {
        print("Sms Send Sucessfully vdsjkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

        // if(userOtp==verficationId)
        // {
        //   _verifiedPhoneno=phoneNumber;
        //   onSuccess();
        // }
        // else
        //   {
        //     showSnackBar(context,"Invalid OTP");
        //   }
      }


    } on FirebaseAuthException catch (e) {
      onFailed(e.message);
    }
  }
}