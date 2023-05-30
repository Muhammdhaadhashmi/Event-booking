import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextEditField extends StatefulWidget {
  final String hintText;
  final errorText;
  final String labelText;
  final double hintSize;
  final double radius;
  final Color hintcolor;
  final Color textColor;
  final Color cursorColor;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  final prefixIcon;
  final suffixIcon;
  final double width;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final onChanged;
  final onEditingComplete;
  final onTap;
  final bool isPassword;

  const TextEditField({
    Key? key,
    required this.hintText,
    this.errorText,
    required this.textEditingController,
    this.labelText = "",
    this.hintSize = 18,
    this.radius = 0,
    this.hintcolor = Colors.grey,
    this.textColor = Colors.black,
    this.cursorColor = Colors.black,
    this.inputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    required this.width,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<TextEditField> createState() => _TextInputFieldViewState();
}

class _TextInputFieldViewState extends State<TextEditField> {
  bool isObscure = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscure = widget.isPassword == true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.grey, blurRadius: 0.5)]),
      child: TextFormField(
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        obscureText: isObscure,
        textCapitalization: widget.textCapitalization,
        controller: widget.textEditingController,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        style: TextStyle(color: widget.textColor),
        cursorColor: widget.cursorColor,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.hintcolor,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : widget.suffixIcon,
          prefixIcon: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              widget.prefixIcon,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
