import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base_null_safe/model/select_option.dart';
import 'package:flutter_base_null_safe/res/label.dart';
import 'package:flutter_base_null_safe/widget/image_picker_dialog.dart';

typedef DateToVoidFunc = void Function(DateTime);

class DialogUtils {
  static void showDatePickerDialog(
      BuildContext context, DateToVoidFunc onPick,
      {DateTime? initDate, DateTime? dateFrom, DateTime? dateTo, bool dob = false}) {
    showDatePicker(
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).primaryColor,
              accentColor: Theme.of(context).primaryColor,
              colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child ?? Container(),
          );
        },
        context: context,
        initialDate: initDate ?? DateTime.now(),
        firstDate: dob ? DateTime(1919) : DateTime.now(),
        lastDate: dob ? DateTime.now() : DateTime(2121),
        selectableDayPredicate: (date) {
          if (dateFrom == null && dateTo == null) {
            return true;
          }
          if (dateTo != null && date.isBefore(dateTo) || date == dateTo) {
            return true;
          } else if (dateFrom != null && date.isAfter(dateFrom) ||
              date == dateFrom) {
            return true;
          }
          return false;
        }).then((DateTime? date) {
      if (date != null) {
        onPick(date);
      }
    });
  }

  static void showPicker(
      BuildContext context,
      {
        String? title,
        SelectOption? currentOption,
        List<SelectOption>? list,
        Function(SelectOption)? onSelect
      }) async {
    SelectOption? selectOption = currentOption;
    int initialItem = list?.indexWhere((element) => element.id == currentOption?.id) ?? 0;
    await Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Text(title ??'',
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 18.0
                  ),),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Text(
                      Label.cancel.tr,
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: Theme.of(context).primaryColorDark
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      Label.done.tr,
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: Theme.of(context).primaryColorDark
                      ),
                    ),
                    onPressed: () {
                      if (list?.isNotEmpty == true) {
                        onSelect?.call(selectOption ?? list!.first);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Divider(color: Theme.of(context).primaryColorDark,),
            Container(
              height: 200.0,
              child: CupertinoPicker(
                  itemExtent: 50,
                  scrollController: FixedExtentScrollController(initialItem: initialItem),
                  onSelectedItemChanged: (index) {
                    selectOption = list?.elementAt(index);
                  },
                  children: List<Widget>.generate(list?.length??0, (index) {
                    return Center(
                      child: Text(
                        list?[index].name ?? '',
                      ),
                    );
                  })
              ),
            ),
          ],
        ),
      )
    );
  }

  static void showPickerDialog({Function(File)? onPickImage}) async {
    await Get.bottomSheet(
        ImagePickerDialog(onPickImage: onPickImage,)
    );
  }
}