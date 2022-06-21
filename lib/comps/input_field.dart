import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';

class InputField extends StatefulWidget {
  final String text;
  final TextInputType inputType;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final String fontfamily;
  final bool isObscured;
  final Color hoverColor;
  final int errorMaxLines;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final double enabledBorderWidth;
  final double focusedBorderWidth;
  final Color bgColor;
  final bool validate;
  final String initialVal;
  final double radius;
  final EdgeInsetsGeometry contentPadding;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;
  final TextEditingController controller;
  final double width;
  final String emptyErrorText;
  final String patternErrorText;
  final Color hintColor;
  final bool isShadow;
  final Widget prefixIcon;
  final bool autoFocus;
  final int sValidate;
  final int minLength;
  final bool expands;
  final int minLine;
  final int maxLine;
  final TextAlignVertical textAlignVertical;
  final int maxLength;
  final RegExp regExp;
  final String lengthErrorText;
  final bool isEnabled;
  final FocusNode focusNode;
  final bool isBothEffect;
  final double height;

  InputField(
      {@required this.text,
      this.inputType,
      this.color,
        this.prefixIcon,
      this.fontSize,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.enabledBorderWidth,
      this.focusedBorderWidth,
      this.hintColor,
      this.sValidate,
        this.autoFocus,
      this.fontWeight,
      this.padding,
      this.minLine,
      this.maxLine,
      this.expands,
      this.textAlignVertical,
      this.lengthErrorText,
      this.errorMaxLines,
      this.fontfamily,
      this.regExp,
        this.focusNode,
      this.validate,
      this.emptyErrorText,
      this.patternErrorText,
      this.isEnabled,
      this.hoverColor,
      this.bgColor,
      this.minLength,
      this.maxLength,
      this.isObscured,
      this.alignment,
      this.initialVal,
      this.radius,
      this.margin,
      this.contentPadding,
      @required this.controller,
      @required this.width,
      this.isShadow,
      this.isBothEffect,
      this.height});
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onHover: (e) {},
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          padding: widget.padding != null ? widget.padding : EdgeInsets.all(0),
          margin: widget.margin != null ? widget.margin : EdgeInsets.all(0),
          child: TextFormField(
            autofocus: widget.autoFocus,
            focusNode: widget.focusNode,
            enabled: widget.isEnabled ?? true,
            maxLines: widget.maxLine == 100 ? null : 1,
            minLines: widget.minLine == 100 ? null : 1,
            expands: widget.expands ?? false,
            textAlignVertical:
                widget.textAlignVertical ?? TextAlignVertical.center,
            validator: (String val) {
              if (val.isEmpty) {
                return widget.emptyErrorText ?? 'The field Should not be empty';
              } else {
                if (widget.regExp != null) {
                  if (!widget.regExp.hasMatch(val))
                    return widget.patternErrorText ??
                        'The Email Id is not valid';
                }
                if (widget.minLength != null) {
                  if (widget.minLength > val.length)
                    return widget.lengthErrorText ??
                        'The field Should not be empty';
                }
                if (widget.maxLength != null) {
                  if (widget.maxLength < val.length)
                    return widget.lengthErrorText ??
                        'The field Should not be empty';
                }

                return null;
              }
            },
            obscureText: widget.isObscured != null ? widget.isObscured : false,
            controller: widget.controller,
            style: TextStyle(
                fontFamily: widget.fontfamily,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
                color: widget.color),
            keyboardType: widget.inputType,
            decoration: widget.isShadow != null && widget.isShadow
                ? InputDecoration(
                    isDense: true,
                prefixIcon: widget.prefixIcon??null,
                    errorMaxLines: widget.errorMaxLines,
                    hintText:
                            widget.text,
                    contentPadding: widget.contentPadding ??
                        EdgeInsets.only(left: 10, right: 10),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorStyle: TextStyle(
                        fontFamily: widget.fontfamily,
                        fontSize: AppDimen.TEXT_MICRO,
                        fontWeight: FontWeight.w300,
                        color: AppColors.WARNING_COLOR),
                    hintStyle: TextStyle(
                        fontFamily: widget.fontfamily,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                        color: widget.hintColor),
                    border: InputBorder.none)
                : InputDecoration(
                    isDense: true,
                    prefixIcon: widget.prefixIcon??null,
                    errorMaxLines: widget.errorMaxLines,
                    errorStyle: TextStyle(
                        fontFamily: widget.fontfamily,
                        fontSize: AppDimen.TEXT_MINI,
                        fontWeight: FontWeight.w400,
                        color: AppColors.WARNING_COLOR),
                    hintText:
                            widget.text,
                    contentPadding: widget.contentPadding ??
                        EdgeInsets.only(left: 10, right: 10),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.WARNING_COLOR_LIGHT,
                          width: widget.focusedBorderWidth),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.WARNING_COLOR,
                          width: widget.focusedBorderWidth),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.focusedBorderColor,
                          width: widget.focusedBorderWidth),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.enabledBorderColor,
                          width: widget.enabledBorderWidth),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    hintStyle: TextStyle(
                        fontFamily: widget.fontfamily,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                        color: widget.hintColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.radius ?? 0),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 5.0)),
                  ),
          ),
          decoration: widget.isShadow == null || widget.isShadow == false
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0),
                  color: widget.bgColor ?? Colors.white,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0),
                  color: widget.bgColor ?? Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      color: Color(0x19000000),
                    ),
                  ],
                ),
        ));
  }
}
