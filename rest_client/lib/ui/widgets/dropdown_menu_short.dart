import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DropDownMenuShort extends StatelessWidget {
  DropDownMenuShort({
    Key key,
    @required this.title,
    @required this.value,
    @required this.onChanged,
    @required this.items,
  }) : super(key: key);

  final String title;
  final dynamic value;
  final List<dynamic> items;
  final ValueChanged<dynamic> onChanged;

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

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<dynamic>> dropdownItems = new List();
    for (dynamic item in items) {
      dropdownItems.add(DropdownMenuItem(
        value: item,
        child: Text(_isNumeric(item)),
      ));
    }
    return DropdownButton(
      value: value,
      items: dropdownItems,
      onChanged: handleChange,
      isExpanded: true,
      hint: Text("Select an option..."),
    );
  }
}
