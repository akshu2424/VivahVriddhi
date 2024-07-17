import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vivahvriddhi/paymentgatway/razorpay.dart';

class PaymentMainPage extends StatefulWidget {
  const PaymentMainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentMainPage> createState() => _PaymentMainPageState();
}

class _PaymentMainPageState extends State<PaymentMainPage> {
  final RazorPayIntegration _integration = RazorPayIntegration();
  @override
  void initState() {
    super.initState();
    _integration.intiateRazorPay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _integration.openSession(amount: 10);
        },
        tooltip: 'Razorpay',
        child: const Icon(Icons.add),
      ),
    );
  }
}
