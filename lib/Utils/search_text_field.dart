import 'package:flutter/material.dart';

import 'app_colors.dart';

class SearchTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final double hintSize;
  final double radius;
  final Color hintcolor;
  final Color textColor;
  final Color cursorColor;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  final prefixIcon;
  final double width;
  final  onChanged;

  const SearchTextField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.labelText = "",
    this.hintSize = 18,
    this.radius = 0,
    this.hintcolor = Colors.grey,
    this.textColor = Colors.black,
    this.cursorColor = Colors.blue,
    this.inputType = TextInputType.text,
    this.prefixIcon,
    this.onChanged,
    required this.width,
  }) : super(key: key);

  @override
  State<SearchTextField> createState() => _TextInputFieldViewState();
}

class _TextInputFieldViewState extends State<SearchTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: AppColors.searchBack,
        borderRadius: BorderRadius.circular(48)
      ),
      child: TextFormField(
        onChanged: widget.onChanged,
        style: TextStyle(color: widget.textColor, fontSize: widget.hintSize),
        controller: widget.textEditingController,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:
          TextStyle(fontSize: widget.hintSize, color: widget.hintcolor),
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon,
        ),
        cursorColor: widget.cursorColor,
        cursorWidth: 1.5,
      ),
    );
  }
}
