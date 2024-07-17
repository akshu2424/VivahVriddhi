import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF9A1F3C)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}




// class CustomButton1 extends StatelessWidget {
//   //final String text;
//   final VoidCallback onPressed;
//
//   const CustomButton1({super.key, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ButtonStyle(
//         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//         backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF9A1F3C)),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25.0),
//           ),
//         ),
//       ),
//       child: Image.asset("assets/subscriptionimages/paynow.png"),
//     );
//   }
// }



class CustomButton1 extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton1({Key? key, required this.text, required this.onPressed});

  @override
  _CustomButton1State createState() => _CustomButton1State();
}

class _CustomButton1State extends State<CustomButton1> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => _handleTap(),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF9A1F3C)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
      child: _isLoading
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : Text(widget.text, style: const TextStyle(fontSize: 16)),
    );
  }

  void _handleTap() {
    setState(() {
      _isLoading = true;
    });
    widget.onPressed();
    // Reset the loading state after a delay (e.g., when navigating back)
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        _isLoading = false;
      });
    });

  }
}