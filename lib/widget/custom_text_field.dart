import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_null_safe/model/select_option.dart';
import 'package:flutter_base_null_safe/res/label.dart';
import 'package:flutter_base_null_safe/utils/date_manager.dart';
import 'package:flutter_base_null_safe/utils/dialog_utils.dart';
import 'package:flutter_base_null_safe/widget/load_image.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final int maxLines;
  final bool obscureText;
  final String? prefixImage;
  final IconData? suffixIcon;
  final Color hintTextColor;
  final bool centerText;
  final double? contentPadding;
  final Color fillColor;
  final bool withShadow;
  final bool isItalic;
  final FormFieldValidator<String>? validator;
  final bool checkEmpty;
  final AutovalidateMode autoValidateMode;
  final String? labelText;
  final bool canInteract;
  final Function? onTap;
  final Function(String)? onChanged;
  final bool autoFocus;
  final SelectOption? selectOption;
  final List<SelectOption>? selectionList;
  final Function(SelectOption)? onSelection;
  final Function? onRefreshList;
  final Function(DateTime)? onSelectDate;
  final bool outlineBorder;
  final bool dob;
  final List<TextInputFormatter> inputFormatters;

  CustomTextField(
      {this.controller,
      this.hintText,
      this.textInputType: TextInputType.text,
      this.textInputAction: TextInputAction.next,
      this.maxLines: 1,
      this.obscureText: false,
      this.prefixImage,
      this.suffixIcon,
      this.hintTextColor: Colors.grey,
      this.centerText: false,
      this.contentPadding,
      this.fillColor: Colors.white,
      this.withShadow: false,
      this.isItalic: false,
      this.validator,
      this.checkEmpty: false,
      this.autoValidateMode: AutovalidateMode.onUserInteraction,
      this.labelText,
      this.canInteract: true,
      this.onTap,
      this.onChanged,
      this.autoFocus: false,
      this.selectOption,
      this.selectionList,
      this.onSelection,
      this.onRefreshList,
      this.onSelectDate,
      this.outlineBorder: true,
      this.dob: false,
      this.inputFormatters = const []});

  @override
  Widget build(BuildContext context) {
    Widget body = TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: outlineBorder
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.grey),
          )
              : OutlineInputBorder(borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide.none),
          focusedBorder: outlineBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.grey),
                )
              : OutlineInputBorder(borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide.none),
          enabledBorder: outlineBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.grey),
                )
              : OutlineInputBorder(borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide.none),
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: hintTextColor, fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
          prefixIcon: prefixImage == null
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: LoadAssetImage(
                    prefixImage,
                    width: 20.0,
                    fit: BoxFit.fitWidth,
                  ),
                ),
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: !canInteract && selectionList != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                )
              : suffixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                        suffixIcon,
                        color: hintTextColor,
                      ),
                    ),
          suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          isDense: true,
          contentPadding: contentPadding == null ? null : EdgeInsets.all(contentPadding!)),
      textAlign: centerText ? TextAlign.center : TextAlign.left,
      style: Theme.of(context).textTheme.headline1?.copyWith(fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
      maxLines: maxLines,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enableInteractiveSelection: canInteract,
      focusNode: canInteract ? null : AlwaysDisabledFocusNode(),
      autofocus: autoFocus,
      autovalidateMode: autoValidateMode,
      //disable emoji by default
      inputFormatters: [
        FilteringTextInputFormatter.deny(
            RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')
        )
      ]..addAll(inputFormatters),
      validator: (text) {
        if (text?.isEmpty == true && checkEmpty) {
          return labelText?.isNotEmpty == true ? '$labelText ${Label.is_required.tr}' : Label.this_field_is_required.tr;
        }

        if (validator != null) {
          return validator!.call(text);
        }

        return null;
      },
      onChanged: onChanged,
      onEditingComplete: () =>
          textInputAction == TextInputAction.next ? FocusScope.of(context).nextFocus() : FocusScope.of(context).unfocus(),
      onTap: canInteract
          ? null
          : () {
              if (textInputType == TextInputType.datetime) {
                DialogUtils.showDatePickerDialog(context, (date) {
                  controller?.text = DateManager.formatDateToString(date, dateFormat: 'yyyy-MM-dd');
                  onSelectDate?.call(date);
                }, dob: dob);
              } else if (selectionList != null) {
                _onTap(context);
              } else {
                onTap?.call();
              }
            },
    );

    if (withShadow) {
      return Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: body,
      );
    } else {
      return body;
    }
  }

  _onTap(BuildContext context) {
    if (selectionList?.isNotEmpty == true) {
      DialogUtils.showPicker(context,
          title: labelText,
          currentOption: selectOption,
          list: selectionList,
          onSelect: (value) {
        controller?.text = value.name ?? '';
        onSelection?.call(value);
      });
    } else {
      onRefreshList?.call();
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
