import 'package:flutter/material.dart';
import 'package:serveyourself/helpers/design.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final Icon icon;
  bool isVisible;

  MyTextField({
    super.key,
    required this.isVisible,
    required this.controller,
    this.validator,
    required this.label,
    required this.icon,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
   bool visibility = true;
   
    
  @override
  Widget build(BuildContext context) {
   
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(
          color: Color.fromARGB(255, 31, 30, 30)), // White-grey color
      obscureText: !visibility,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: Design.textColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.icon,
        suffixIcon: widget.isVisible
            ? null : IconButton(
                icon: Icon(
                  visibility ? Icons.visibility : Icons.visibility_off,
                  color: Design.primary,
                ),
                onPressed: () {
                  setState(() {
                    visibility = !visibility;
                  });
                },
              )
          ,
      ),
      validator: widget.validator,
    );
  }
}
