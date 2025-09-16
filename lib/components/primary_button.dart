import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  PrimaryButton({Key ? key, this.onPressed, required this.title, this .verticalPadding = 16}) : super(key: key);
  final VoidCallback? onPressed;
  final  String title;
  final double verticalPadding;

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}  

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed, 
      child: Text(widget.title),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
  }
}