import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_client/ui/shared/color_pallete.dart';

class DropDownMenuExtended extends StatelessWidget {
  DropDownMenuExtended({Key key,
    this.title,
    @required this.value,
    @required this.onChanged,
    @required this.items,
    this.isRequired = false})
      : super(key: key);

  final String title;
  final dynamic value;
  final List<dynamic> items;
  final ValueChanged<dynamic> onChanged;
  final bool isRequired;

  void handleChange(dynamic val) {
    onChanged(val);
  }

  String _isNumeric(val) {
    switch (val.runtimeType) {
      case int:
        return val.toString();
        break;
      case double:
        return val.toString();
        break;
      default:
        return val;
        break;
    }
  }

  String validateExists(dynamic value) {
    if ((value?.isEmpty ?? true))
      return 'Please select an option';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    var labelStyle = TextStyle(
        color: ColorPalette.Grey.P700, fontFamily: 'Avenir', fontSize: 22);
    List<DropdownMenuItem<dynamic>> dropdownItems = new List();
    for (dynamic item in items) {
      dropdownItems.add(DropdownMenuItem(
        value: item,
        child: Text(_isNumeric(item)),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child:
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
//                          borderSide: BorderSide.none,
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: title,
                        labelStyle: labelStyle,
                      ),
                      itemHeight: 50,
                      validator: isRequired ? validateExists : null,
                      value: value,
                      items: dropdownItems,
                      onChanged: handleChange,
                      isExpanded: true,
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
