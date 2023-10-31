import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool upperCase;
  final VoidCallback? onPressed;
  final double radius;
  final Color textColor;
  final Color backgroundColor;
  final Color? disabledColor;
  final Color? borderColor;
  final bool? isFlat;
  final int? maxLines;
  final EdgeInsets? padding;
  final double fontSize;

  CustomButton(
      this.text,
      {Key? key,
        this.onPressed,
        this.upperCase = true,
        this.borderColor,
        this.isFlat,
        this.radius = 10.0,
        this.textColor = Colors.white,
        this.backgroundColor = Colors.white,
        this.disabledColor,
        this.maxLines,
        this.padding,
        this.fontSize = 16.0
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFlat == true ? TextButton(
      style: TextButton.styleFrom(
        padding: padding ?? EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: onPressed,
      child: Text(upperCase ? text.toUpperCase() : text,
        style: Theme.of(context).textTheme.headline3?.copyWith(
            color: textColor,
            fontSize: fontSize
        ),
        overflow: maxLines == null ? null : TextOverflow.ellipsis,
        maxLines: maxLines,
      ),
    ) : ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!)
        ),
        elevation: 3.0,
        primary: backgroundColor,
        onSurface: disabledColor,
      ),
      onPressed: onPressed,
      child: Text(upperCase ? text.toUpperCase() : text,
        style: Theme.of(context).textTheme.headline3?.copyWith(
            color: textColor,
            fontSize: fontSize
        ),
        overflow: maxLines == null ? null : TextOverflow.ellipsis,
        maxLines: maxLines,
      ),
    );
  }
}
