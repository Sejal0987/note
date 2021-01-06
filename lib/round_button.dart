import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  RoundButton({this.text, this.onPressed, this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0),
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        color: color,
        child: MaterialButton(
          onPressed: onPressed,
          height: 42.0,
          minWidth: 200.0,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
