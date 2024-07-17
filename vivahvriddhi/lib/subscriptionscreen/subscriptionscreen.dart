import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/custom_button_in_mobile_auth.dart';
import '../paymentgatway/paymentmainpage.dart';
import 'componenets/optionavailable.dart';
import 'componenets/util.dart';
class SubscriptionsTab extends StatefulWidget {
  static const routeName = '/susbscriptionplan';
  @override
  _SubscriptionsTabState createState() => _SubscriptionsTabState();
}

class _SubscriptionsTabState extends State<SubscriptionsTab> {
  int sharedValue = 0;
  final List<Color> tabColors = [
    Color(0xFF9A1F3C),
    Color(0xFF9A1F3C),
    Color(0xFF9A1F3C),
  ];
 final Map<int, Widget> options = const <int, Widget>{
    0: Text(
      'Silver Harmony',
      style: TextStyle(
        fontSize: 10,
        color: Colors.black,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold
      ),
    ),
    1: Text(
      'Harmony Plus',
      style: TextStyle(
        fontSize: 10,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
    ),
    2: Text(
      'Gold Match',
      style: TextStyle(
        fontSize: 10,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      //backgroundColor: CustomColors.BackgroundColor,
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        //actionsForegroundColor: CustomColors.Purple,
        backgroundColor: Colors.white,
        middle: Text('Subscriptions'),
        //trailing: Icon(CustomIcons.searchIcon),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: CustomColors.GreyTextLight,
                  //blurRadius: 10.0,
                  //spreadRadius: 5.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            child: CupertinoSegmentedControl(
              children: {
                for (var i = 0; i < tabColors.length; i++)
                  i: Container(
                    color: sharedValue == i ? tabColors[i] : Colors.white,
                    child: Row(
                      
                      
                      //padding: const EdgeInsets.all(10.0),
                      children: [
                        SizedBox(height: 50,width: 20,),
                        Text(
                        _getTabText(i),
                        style: TextStyle(
                          color: sharedValue == i ? Colors.white : Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 10,
                        ),
                      ),]
                    ),
                  ),
              },
              onValueChanged: (int newValue) {
                setState(() {
                  sharedValue = newValue;
                });
              },
              selectedColor: Colors.yellow,
              //selectedColor: Colors.yellow, // Set selected tab color
              unselectedColor: Colors.white, // Set unselected tab color
              //pressedColor: Colors.deepOrangeAccent, // Remove pressed color
              //borderColor: Colors.black, // Remove border color
              padding: EdgeInsets.zero, // Remove padding
              
            ),
          ),
          SizedBox(height: 20,),
          Visibility(
            visible: sharedValue == 0 ? true : false,
            child: Expanded(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverGrid.count(
                    crossAxisCount: 1,
                    children: [
                              
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
                                  // Container(
                                  //   width: 100,
                                  //   height: 100,
                                  //   padding: const EdgeInsets.all(20.0),
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     color: Color(0xFFE8CCD2),
                                  //   ),
                                  //   child: Image.asset("assets/authimages/mobileauth.png"),
                                  // ),
                                  OptionsAvailableSubs(text: 'abc', icon: 'assets/subscriptionimages/checklist.png',),
                                  Column(
                                    children: <Widget>[
                                      //Text("Not registerd yet?"),
                                      SizedBox(height: 6),
                                      CustomButton( onPressed: () {
                                        print("button pressed by user");
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PaymentMainPage(),
                                          ),
                                        );
                                      }, text: 'Pay Now',)
                                    ],
                                  ),

                          
                          

                        ],
                      ),
                    ),
                  ),
              //_paidContainter(context, '3 Months', 'Silver Harmony', 500),
              // _paidContainter(context, '3 Months', 'Silver Harmony', 500),
              // _paidContainter(context, 'logo-netflix', 'Netflix', 2),
                    
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: sharedValue == 1 ? true : false,
            child: Expanded(
              child: Center(
                child: Text(
                  'Not implemented yet.',
                  style: CustomTextStyles.LargePurpleLight,
                ),
              ),
            ),
          ),
          Visibility(
            visible: sharedValue == 2 ? true : false,
            child: Expanded(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverGrid.count(
                    crossAxisCount: 2,
                    children: [
                      _purpleContainter(context, 'Suitcase', 'Business', ''),
                      _purpleContainter(context, 'Books', 'Books', ''),
                      _purpleContainter(context, 'Beauty', 'Beauty', ''),
                      _purpleContainter(context, 'Education', 'Education', ''),
                      _purpleContainter(
                          context, 'Design', 'Design', 'designlist'),
                      _purpleContainter(
                          context, 'Entertainment', 'Entertainment', ''),
                      _purpleContainter(context, 'Fitness', 'Fitness', ''),
                      _purpleContainter(context, 'Finance', 'Finance', ''),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _purpleContainter(
    context, String image, String text, String routerName) {
  return GestureDetector(onTap: () {}
     
      );
}

Widget _paidContainter(context, String months, String text, int cost) {
  return GestureDetector(
    onTap: () { },
    child: Container(
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
            text,
            style: TextStyle(
        fontSize: 10,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
          ),
          ),
          Container(height: 1, color: CustomColors.BlueLightBorder),
          SizedBox(height: 10),
          Text(
            months,
            style: TextStyle(
        fontSize: 10,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
          ),
          Text(
            'Rs $cost',
            style: TextStyle(
                color: cost <= 5 ? CustomColors.Purple : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                decoration: TextDecoration.none,
                ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.BlueLightBorder,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
    ),
  );
  
}
String _getTabText(int index) {
    switch (index) {
      case 0:
        return 'Silver Harmony';
      case 1:
        return 'Harmony Plus';
      case 2:
        return 'Gold Match';
      default:
        return '';
    }
  }