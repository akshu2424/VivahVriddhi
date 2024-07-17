import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/bottom_bar_view.dart';
import '../components/vivahvriddhi_app_theme.dart';
import '../discovermatchesoptions/discovermatchesbyname.dart';
import '../models/tabIcon_data.dart';
import 'components/homescreen_contents_view.dart';
import '../profilescreen/profilemainscreen.dart';
import 'components/new_matches_list_data.dart';

class VivahVriddhiHomeScreen extends StatefulWidget {
  @override
  _VivahVriddhiHomeScreenState createState() => _VivahVriddhiHomeScreenState();
}

class _VivahVriddhiHomeScreenState extends State<VivahVriddhiHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  static bool dataFetched = false; // Flag to track if data has been fetched


  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: VivahVriddhiAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });

    tabIconsList[0].isSelected = true;


    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HomeScreenContents(animationController: animationController);

    // Fetch data only if it hasn't been fetched already
    if (!dataFetched) {
      initializeData();
    }
    super.initState();
  }
  Future<void> initializeData() async {
    await NewMatchesListData.fetchDataFromFirestore();

    setState(()  {
      dataFetched = true;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VivahVriddhiHomeScreen(),), (route) => false);
      print("-----------------------------data fetch suceesfully one time-------- ");

    });
  }


  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VivahVriddhiAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DiscoverMatchesByName(),), (route) => true);
          },
          changeIndex: (int index) {
            if (index == 0 ) {

              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {

                  tabBody = HomeScreenContents(animationController: animationController);
                });
              });
            }

            else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      ProfileMainScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
