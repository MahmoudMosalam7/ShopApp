import 'package:flutter/material.dart';
Widget myDivider() => const Padding(
  padding: EdgeInsets.all(20.0),
  child: Divider(
    color: Colors.grey, // Set the color to gray
    thickness: 1.0, // You can adjust the thickness as needed
  ),
);
Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
   void Function(String)? onChange,
  Color borderColor = Colors.deepOrange,
  Color labelColor = Colors.deepOrange,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,

    validator: validate,
    onChanged: onChange,
    decoration:  InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: labelColor),
      prefixIcon: Icon(prefix, color: labelColor),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
    ),
  );
}
// to navigate and can back to prev screen
void navigateTo(BuildContext context,Widget screen) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => screen ));
// this method to navigate without back to prev screen
void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false,
  );
}