import 'package:flutter/material.dart';

import 'color.dart';
Widget myDivider() => const Padding(
  padding: EdgeInsets.all(20.0),
  child: Divider(
    color: Colors.grey, // Set the color to gray
    thickness: 1.0, // You can adjust the thickness as needed
  ),
);

// Function to create a default button
Widget defaultButton({
  required void Function()? onPressed,  // Function to execute when button is clicked
  required String text,                 // Text to display on the button
  Color color = defaultActiveColor,             // Optional button color (default is blue)
  double width = double.infinity,        // Default width is full width of parent
  double height = 40.0,                  // Default height is 40
}) {
  return Container(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,                     // Set the background color
        shape: RoundedRectangleBorder(      // Rounded corners for the button
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,              // Set the text color to white
          fontSize: 16.0,                   // Set a default font size
        ),
      ),
    ),
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validate,
  required String label,
  IconData? prefix,
  IconData? suffix,                 // Optional suffix icon
  void Function()? suffixPressed,   // Optional suffix pressed callback
  void Function(String)? onChange,
  void Function(String)? onSubmit,  // Optional onSubmit callback for form submission
  Color inactiveColor = defaultInactiveColor,  // Optional inactive color (default is gray)
  Color activeColor = defaultActiveColor,      // Optional active color (default is red)
  bool isSecure = false,                       // Optional isSecure parameter for password fields
}) {
  bool isPasswordVisible = isSecure;

  return StatefulBuilder(
    builder: (context, setState) {
      return Focus(
        child: Builder(
          builder: (focusContext) {
            // Check if the TextField is focused
            bool hasFocus = Focus.of(focusContext).hasFocus;

            return TextFormField(
              controller: controller,
              keyboardType: type,
              validator: validate,
              onChanged: onChange,
              onFieldSubmitted: onSubmit, // Added onSubmit handling
              obscureText: isPasswordVisible,  // Toggle text visibility for password
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: hasFocus ? activeColor : inactiveColor),
                prefixIcon: Icon(prefix, color: hasFocus ? activeColor : inactiveColor),
                suffixIcon: isSecure // Show password visibility toggle icon if isSecure is true
                    ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: hasFocus ? activeColor : inactiveColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
                    : (suffix != null
                    ? IconButton(
                  icon: Icon(suffix, color: hasFocus ? activeColor : inactiveColor),
                  onPressed: suffixPressed,
                )
                    : null),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: inactiveColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: activeColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: inactiveColor),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget defaultTextButton( {
  required void Function()? onPressed,
  required String text,
  Color activeColor = defaultActiveColor,
}) =>  TextButton(onPressed: onPressed,
    child: Text(text.toUpperCase()
      ,style: TextStyle(
          color: activeColor,
        fontFamily: 'Pacifico',
      ),
    ));
// to navigate and can back to prev screen
void navigateTo(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}
// this method to navigate without back to prev screen
void navigateAndFinish(BuildContext context, String routeName) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    routeName,
        (Route<dynamic> route) => false,
  );
}

