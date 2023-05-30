
import 'package:flutter/material.dart';

import '../../../../Utils/text_view.dart';

class SelectionBTN extends StatefulWidget {
  final title;
  final splashColor;
  final double? fontSize;
  final color;
  final fontWeight;
  final textColor;
  final fontFamily;
  final onPressed;
  final double margin;
  final double width;

  const SelectionBTN({
    Key? key,
    required this.title,
    required this.onPressed,
    this.splashColor,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textColor,
    this.fontFamily,
    this.margin=0,
    required this.width,
  }) : super(key: key);

  @override
  State<SelectionBTN> createState() => _SelectionBTNState();
}

class _SelectionBTNState extends State<SelectionBTN> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: EdgeInsets.all(widget.margin),
      child: MaterialButton(
        onPressed: widget.onPressed,
        color: widget.color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          // padding: const EdgeInsets.all(20.0),
          child: TextView(
            text: widget.title,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.textColor,
            fontFamily: widget.fontFamily,

          ),
        ),
        splashColor: widget.splashColor,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
  }
}