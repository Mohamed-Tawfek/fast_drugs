import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key? key,
    required this.function,
    required this.text,
    this.isUpperCase = true,
    this.radius = 10.0,
  }) : super(key: key);

  // Color background = Colors.green,
  bool isUpperCase = true;
  double radius;
  VoidCallback function;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: MaterialButton(
        color: Colors.green,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style:   TextStyle(
            color: Colors.white,
            fontSize: 20.sp
          ),
        ),
      ),
    );
  }
}

class DefaultFormField extends StatelessWidget {
  DefaultFormField(
      {Key? key,
      required this.controller,
      this.type,
      this.onSubmit,
      this.onChange,
      this.isPassword = false,
      this.validate,
      this.label,
      this.prefix,
      this.suffix,
      this.suffixOnPressed,
      this.isEnable = true})
      : super(key: key);

  TextEditingController? controller;
  TextInputType? type;
  Function(String)? onSubmit;
  Function(String)? onChange;
  bool isPassword;
  String? Function(String?)? validate;
  String? label;
  IconData? prefix;
  IconData? suffix;
  void Function()? suffixOnPressed;
  bool isEnable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: isEnable,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefix != null
            ? Icon(
                prefix,
              )
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixOnPressed,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}


