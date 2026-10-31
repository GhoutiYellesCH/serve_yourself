import 'package:flutter/material.dart';
import 'package:serveyourself/helpers/design.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Text text;
  final Color color;



  const MyButton({
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
   
  
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Use the color passed to the button
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
        ),
        
      ),
      child: text,
    );
  }
}
