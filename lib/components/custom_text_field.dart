import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key, 
    required this.label,
    required this.controller,
    this.isPassword = false, 
    this.keyboardType = TextInputType.text,
    this.placeholder,
  }) : super(key: key);
  String label;
  bool isPassword;
  TextInputType? keyboardType;
  TextEditingController  controller; 
  String ? placeholder;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
} 

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  bool _isObscured = true;
  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  toggleObscured() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.bodyLarge,),
        SizedBox(height: 8,), 
        TextField(
        obscureText: _isObscured,
        controller: _controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.placeholder,
          labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
          suffixIcon: widget.isPassword ? IconButton(
              icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off,),
              onPressed: toggleObscured,
            ) : null,
          ),
        )
      ],
    );
  }
}