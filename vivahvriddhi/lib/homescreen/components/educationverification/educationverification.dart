import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/models/educationverificationmodel.dart';
import '../../../authprovider/authprovider.dart';
import '../../../components/custom_button_in_mobile_auth.dart';
import '../../../components/pickimage.dart';
import '../../../components/snackbar.dart';
import '../../../models/idverificationmodel.dart';
import '../../vivahvriddhi_home_screen.dart';



class EducationVerificationPhotoScreen extends StatefulWidget {
  const EducationVerificationPhotoScreen({super.key});

  @override
  State<EducationVerificationPhotoScreen> createState() => _EducationVerificationPhotoScreenState();
}

class _EducationVerificationPhotoScreenState extends State<EducationVerificationPhotoScreen> {
  File?image1;

  @override
  void dispose() {
    super.dispose();
  }

  // for selecting image1
  void selectImage1() async {
    image1 = await pickImage(context);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text("Education Verification"),
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF841D34),
          ),
        )
            : SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => selectImage1(),
                          child: image1 == null
                              ? DottedBorder(
                            color: Colors.black,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              // padding: EdgeInsets.only(left: 20),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Select Image 1",
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                                  )
                                ],
                              ),
                            ),
                          )
                              : DottedBorder(
                            color: Colors.black,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              // padding: EdgeInsets.only(left: 20),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(image1!), // Assuming image1 is your File object
                                  fit: BoxFit.cover, // You can adjust the fit as per your requirement
                                ),
                              ),
                            ),
                          )
                      ),


                    ],
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(child: Text("Add Highest Education Transcript for Education Verification. \nThis information will not share with anyone and only use for verification purpose."))
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () {
                      storeData();
                    },
                    text: "Upload",
                  ),
                )



              ],
            ),
          ),
        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    EducationVerificationInfoModel educationVerificationInfoModel=  EducationVerificationInfoModel(uploadeducationcertificate: "");
    if (image1 != null)
    {
      ap.saveUserUploadedEducationDetailsPhotoToFirebase(
        context: context,
        educationVerificationInfoModel: educationVerificationInfoModel,
        uploadeducationcertificate: image1!,

        onSuccess: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  VivahVriddhiHomeScreen(),), (route) => false);
          showSnackBar(context, "Photo Uploaded Sucessfully");
        },
      );

    } else {
      showSnackBar(context, "Please upload your 4 photos atleast");
    }
  }
}