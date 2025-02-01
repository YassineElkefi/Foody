import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledTextButton extends StatelessWidget {
  const StyledTextButton({super.key, required this.text, required this.onPressed});
  
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
      style: GoogleFonts.varela(
        fontSize: 16,
        color: Colors.black,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.underline
      ),),
    );
  }
}