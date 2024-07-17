
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../authprovider/authprovider.dart' as apx;
import '../components/vivahvriddhi_app_theme.dart';

class CommunityInforDisplayCard extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const CommunityInforDisplayCard({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<CommunityInforDisplayCard> createState() => _CommunityInforDisplayCardState();
}

class _CommunityInforDisplayCardState extends State<CommunityInforDisplayCard> {
  String? Religion='';
  String? Caste='';
  String? Subcaste='';
  String? DecisionwithOtherComm='';
  @override
  void initState() {
    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    final ap = Provider.of<apx.AuthProvider>(context, listen: false);
    String religion=await ap.getReligionOfUser();
    String caste=await ap.getCasteOfUser();
    String subcaste=await ap.getSubCasteOfUser();
    String othercommunitymarrydecision=await ap.getWheatherTheyMarrywithOtherCommunityOfUser();
    if(mounted)
      {
        setState(() {
          Religion=religion;
          Caste=caste;
          Subcaste=subcaste;
          DecisionwithOtherComm=othercommunitymarrydecision;
        });
      }
      }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: VivahVriddhiAppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: VivahVriddhiAppTheme.grey
                                      .withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 100,
                                          right: 16,
                                          top: 16,
                                        ),
                                        child: Text(
                                          "Religion: $Religion",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                            VivahVriddhiAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: Color(0xFF841D34),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      bottom: 1,
                                      top: 4,
                                      right: 16,
                                    ),
                                    child: Text(
                                      "Caste : $Caste",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                        VivahVriddhiAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        color: Color(0xFF841D34),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      bottom: 4,
                                      top: 1,
                                      right: 16,
                                    ),
                                    child: Text(
                                      "Subcaste : $Subcaste",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                        VivahVriddhiAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        color: Color(0xFF841D34),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      bottom: 4,
                                      top: 1,
                                      right: 16,
                                    ),
                                    child: Text(
                                      "Decision to marry with another Community : $DecisionwithOtherComm",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                        VivahVriddhiAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        color: Color(0xFF841D34),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 15,
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset("assets/authimages/community.png"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
