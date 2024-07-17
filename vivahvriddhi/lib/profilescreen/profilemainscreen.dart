import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivahvriddhi/profilescreen/communityinfodisplaycard.dart';
import 'package:vivahvriddhi/profilescreen/educationinfodisplaycard.dart';
import 'package:vivahvriddhi/profilescreen/familydetailsinfocard.dart';
import 'package:vivahvriddhi/profilescreen/maritalandregiondetails.dart';
import 'package:vivahvriddhi/profilescreen/personalcontactinfodetailsdisplaycard.dart';
import 'package:vivahvriddhi/profilescreen/photouploadedbyuserinprofilesection.dart';
import 'package:vivahvriddhi/profilescreen/personalinfodisplaycard.dart';
import 'package:vivahvriddhi/profilescreen/physicalstatusdisplaycard.dart';
import 'package:vivahvriddhi/updatedetails/registrationscreen1update.dart';
import 'package:vivahvriddhi/updatedetails/registrationscreen2update.dart';
import 'package:vivahvriddhi/updatedetails/registrationscreen3update.dart';
import 'package:vivahvriddhi/updatedetails/registrationscreen5update.dart';
import 'package:vivahvriddhi/updatedetails/registrationscreen6update.dart';
import 'package:vivahvriddhi/homescreen/components/uploadphotos/uploadphotoscreen.dart';

import '../authprovider/authprovider.dart';
import '../components/custom_button_in_mobile_auth.dart';
import '../components/title_view.dart';
import '../components/vivahvriddhi_app_theme.dart';
import '../splashscreen/splashscreen.dart';
import '../updatedetails/registrationscreen4update.dart';
import '../updatedetails/registrationscreen7update.dart';
class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _ProfileMainScreenState createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: widget.animationController!, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 5;
    // for displaying the personal details of the user
    listViews.add(
      TitleView(
        titleTxt: 'Personal Details',
        subTxt: 'Edit',
        onTapCallback: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen1Update()));},
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      PersonalInforDisplayCard(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // for displaying the Community Information

    listViews.add(
      TitleView(
        titleTxt: 'Community Details',
        subTxt: 'Edit',
        onTapCallback: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen2Update()));},
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      CommunityInforDisplayCard(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // for diplaying and updating the Marital Status and Region Details

    listViews.add(
      TitleView(
        titleTxt: 'Marital Status and Region Details',
        subTxt: 'Edit',
        onTapCallback: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen3Update()));},
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      MaritalAndRegionDisplayCard(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // for displayig physical status

    listViews.add(
      TitleView(
        titleTxt: 'Physical Status Details',
        subTxt: 'Edit',
        onTapCallback: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen4Update()));},
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      PhysicalStatusDisplayCard(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // function to display

    listViews.add(
      TitleView(
        titleTxt: 'Education and Occupation Details',
        subTxt: 'Edit',
        onTapCallback: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen5Update()));},
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      EducationOccupationInfoDisplayCard(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // card to display the family details

    listViews.add(
      TitleView(
        titleTxt: 'Family Details ',
        subTxt: 'Edit',
        onTapCallback: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen6Update()));},
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      FamilyInfoDisplayCard(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // to display the personal conact details

    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Personal Contact Details  ',
    //     subTxt: 'Edit',
    //     onTapCallback: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen7Update()));},
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //         Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );
    // listViews.add(
    //   PersonalContactInfoDisplayCard(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //         Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );


    // for displaying photo uploaded by users section
    listViews.add(
      TitleView(
        titleTxt: 'Photo Uploaded by you',
        subTxt: 'Update',
        onTapCallback: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPhotosScreen()));},
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      PhotoUploadedByUserInProfileSection(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 5, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController!,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VivahVriddhiAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(height: MediaQuery.of(context).padding.bottom,)
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {

    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        VivahVriddhiAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: VivahVriddhiAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Profile',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: VivahVriddhiAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: VivahVriddhiAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                showAlertDialog(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Logout',

                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: VivahVriddhiAppTheme.fontName,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,

                                        letterSpacing: -0.2,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.logout_outlined,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  // Function to show status update dialog
  Future<void> showAlertDialog(BuildContext context) async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Logout')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPressed: () {
                      ap.userSignOut().then(
                            (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    text: 'Logout',
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: 'Cancel',
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

}
