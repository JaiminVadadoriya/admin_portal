import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

TextField resuableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
      ),
      labelText: text,
      filled: true,
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(30.0),
      //   borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      // ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signinsignupButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN ' : 'SIGN UP',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

TextField resuablerouteTextField(
    String text, TextEditingController controller, BuildContext context) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      filled: true,
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(30.0),
      //   borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      // ),
    ),
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(3000));
      if (pickedDate == null) {
        String formattedDate = DateFormat("dd-MM-yyyy").toString();

        setState() {
          controller.text = formattedDate.toString();
        }
      }
    },
  );
}
