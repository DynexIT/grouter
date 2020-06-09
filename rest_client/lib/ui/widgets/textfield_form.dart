import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rest_client/ui/shared/color_pallete.dart';

class CustomTextFieldForm extends StatelessWidget {
  final Key textFieldKey;
  final TextStyle textStyle;
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final bool hideText;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final TextEditingController textController;
  final TextInputFormatter textFormatter;
  final TextInputAction keyboardAction;
  final FocusNode focusNode;
  final String value;
  final FormFieldSetter<String> onSaved;
  final Color cursorColor;
  final GestureTapCallback onTap;
  final VoidCallback onEditingComplete;
  final String suffixText;
  final String prefixText;
  final IconData prefixIcon;
  final TextCapitalization textCapitalization;
  IconData suffixIcon;
  final GestureTapCallback clearText;
  bool enabled;
  Widget suffixWidget;
  TextStyle labelStyle;
  bool hasError;

  //passing props in react style
  CustomTextFieldForm(
      {this.textFieldKey,
      @required this.hintText,
      this.textStyle,
      this.hideText = false,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.textController,
      this.textFormatter,
      this.onChanged,
      this.keyboardAction = TextInputAction.done,
      this.focusNode,
      this.value,
      this.onSaved,
      this.cursorColor,
      this.onTap,
      this.onEditingComplete,
      this.onSubmitted,
      this.suffixText,
      this.prefixText,
      this.prefixIcon,
      this.textCapitalization,
      this.suffixIcon,
      this.clearText,
      this.hasError,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];
    if(this.textFormatter != null)
      inputFormatters.add(this.textFormatter);
    if (focusNode.hasFocus) {
      if (this.hasError) {
        suffixWidget = SizedBox(
            width: 25,
            height: 25,
            child: Material(
              child: InkWell(
                child: Icon(
                  Icons.error,
                  size: 25,
                  color: ColorPalette.primaryError,
                ),
                onTap: () {},
              ),
              shape: CircleBorder(),
              color: Colors.transparent,
            ));
        labelStyle = TextStyle(
            color: ColorPalette.primaryError,
            fontFamily: 'Avenir',
            fontSize: 18);
      } else {
        suffixWidget = SizedBox(
            width: 25,
            height: 25,
            child: Material(
              child: InkWell(
                child: Icon(
                  Icons.cancel,
                  size: 25,
                  color: ColorPalette.secondaryGrey,
                ),
                onTap: () {
                  textController.clear();
                },
              ),
              shape: CircleBorder(),
              color: Colors.transparent,
            ));
        labelStyle = TextStyle(
            color: ColorPalette.primaryBlue,
            fontFamily: 'Avenir',
            fontSize: 18);
      }
    } else {
      suffixText != null
          ? suffixWidget = Text(suffixText)
          : suffixWidget = Opacity(
              opacity: 0,
            );
      labelStyle = TextStyle(
          color: ColorPalette.Grey.P400, fontFamily: 'Avenir', fontSize: 22);
    }
    return Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 0.0,
        child: TextFormField(
          // The validator receives the text the user has typed in
          style: TextStyle(color: Colors.black),
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                const BorderSide(color: Colors.transparent, width: 1)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.primaryBlue, width: 8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelText: hintText,
            labelStyle: labelStyle,
            fillColor: ColorPalette.primaryGrey,
            filled: true,
            suffix: suffixWidget,
          ),
          onTap: onTap,
          cursorColor: ColorPalette.primaryBlue,
          validator: validator,
          obscureText: hideText ?? false,
          controller: textController,
          inputFormatters: inputFormatters,
          textInputAction: keyboardAction,
          onChanged: onChanged,
          focusNode: focusNode,
          initialValue: value,
          onSaved: onSaved,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onSubmitted,
          maxLines: null,
          enabled: enabled,
        ));
  }
}

class SearchField extends CustomTextFieldForm {
  SearchField(
      {@required this.searchController,
        this.textInputAction,
        this.onFieldSubmitted,
        @required this.onChanged,
        this.validator,
        this.focusNode});

  final TextEditingController searchController;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 4.0,
        child: SizedBox(
            height: 60.0,
            width: double.infinity,
            child: TextFormField(
              // The validator receives the text the user has typed in
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: ColorPalette.primaryBlue,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
//                errorBorder: UnderlineInputBorder(
//                  borderSide:
//                  BorderSide(color: ColorPalette.primaryError, width: 8),
//                  borderRadius: BorderRadius.circular(8.0),
//                ),
//                errorStyle: TextStyle(
//                    color: ColorPalette.primaryError,
//                    fontFamily: 'Roboto',
//                    fontSize: 14),
//                focusedErrorBorder: UnderlineInputBorder(
//                  borderSide:
//                  BorderSide(color: ColorPalette.primaryError, width: 8),
//                  borderRadius: BorderRadius.circular(8.0),
//                ),
                  hintText: "Search",
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorPalette.primaryBlue,
                  )),
              validator: validator,
              obscureText: false,
              controller: searchController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: onFieldSubmitted,
              focusNode: focusNode,
              onChanged: onChanged,
            )));
  }
}

class PasswordField extends StatelessWidget {
  PasswordField(
      {@required this.passwordController,
      this.confirmPassword = "",
      @required this.confirmPass,
      this.textInputAction,
      @required this.focusNode,
      this.onFieldSubmitted,
      this.onChanged,
      this.validator,
      @required this.hasError,
      this.hideText,
      this.suffixWidget});

  final TextEditingController passwordController;
  final String confirmPassword;
  final bool confirmPass;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  Widget suffixWidget;
  TextStyle labelStyle;
  bool hasError;
  bool hideText;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    if (this.hasError) {
      suffixWidget = SizedBox(
          width: 25,
          height: 25,
          child: Material(
            child: InkWell(
              child: Icon(
                Icons.error,
                size: 25,
                color: ColorPalette.primaryError,
              ),
              onTap: () {},
            ),
            shape: CircleBorder(),
            color: Colors.transparent,
          ));
      iconColor = ColorPalette.primaryError;
      labelStyle = TextStyle(
          color: ColorPalette.primaryError,
          fontFamily: 'Avenir',
          fontSize: 18,
          height: 1);
    } else {
      if (focusNode.hasFocus) {
        suffixWidget = SizedBox(
            width: 25,
            height: 25,
            child: Material(
              child: InkWell(
                child: Icon(
                  Icons.cancel,
                  size: 25,
                  color: ColorPalette.secondaryGrey,
                ),
                onTap: () {
                  passwordController.clear();
                },
              ),
              shape: CircleBorder(),
              color: Colors.transparent,
            ));
        labelStyle = TextStyle(
            color: ColorPalette.primaryBlue,
            fontFamily: 'Avenir',
            fontSize: 18,
            height: 1);
        iconColor = ColorPalette.primaryBlue;
      } else {
        suffixWidget = Opacity(
          opacity: 0,
        );
        labelStyle = TextStyle(
            color: ColorPalette.Grey.P400,
            fontFamily: 'Avenir',
            fontSize: 18,
            height: 1);
        iconColor = ColorPalette.primaryBlue;
      }
    }
    String hintText = "Password";
    if (confirmPass) hintText = "Confirm Password";
    return Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 0.0,
        child: SizedBox(
            height: 80.0,
            child: TextFormField(
              // The validator receives the text the user has typed in
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: ColorPalette.primaryBlue,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: ColorPalette.primaryBlue, width: 8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: ColorPalette.primaryError, width: 8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorStyle: TextStyle(
                      color: ColorPalette.primaryError,
                      fontFamily: 'Avenir',
                      fontSize: 14),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: ColorPalette.primaryError, width: 8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: hintText,
                  labelStyle: labelStyle,
                  filled: true,
                  fillColor: ColorPalette.primaryGrey,
                  suffix: suffixWidget,
                  prefix: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(
                        Icons.lock_outline,
                        color: iconColor,
                        size: 18,
                      ))),
              validator: validator,
              obscureText: hideText,
              controller: passwordController,
              textInputAction: confirmPass
                  ? TextInputAction.done
                  : textInputAction ?? TextInputAction.next,
              onFieldSubmitted: onFieldSubmitted,
              focusNode: focusNode,
              onChanged: onChanged,
            )));
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  Widget suffixWidget;
  TextStyle labelStyle;
  bool hasError;
  Color iconColor;

  EmailField(
      {@required this.emailController,
      this.onFieldSubmitted,
        this.onChanged,
      this.focusNode,
      this.suffixWidget,
      this.labelStyle,
      @required this.validator,
      @required this.hasError});

  @override
  Widget build(BuildContext context) {
    if (this.hasError) {
      suffixWidget = SizedBox(
          width: 25,
          height: 25,
          child: Material(
            child: InkWell(
              child: Icon(
                Icons.error,
                size: 25,
                color: ColorPalette.primaryError,
              ),
              onTap: () {},
            ),
            shape: CircleBorder(),
            color: Colors.transparent,
          ));
      iconColor = ColorPalette.primaryError;
      labelStyle = TextStyle(
          color: ColorPalette.primaryError,
          fontFamily: 'Avenir',
          fontSize: 18,
          height: 1);
    } else {
      if (focusNode.hasFocus) {
        suffixWidget = SizedBox(
            width: 25,
            height: 25,
            child: Material(
              child: InkWell(
                child: Icon(
                  Icons.cancel,
                  size: 25,
                  color: ColorPalette.secondaryGrey,
                ),
                onTap: () {
                  emailController.clear();
                },
              ),
              shape: CircleBorder(),
              color: Colors.transparent,
            ));
        labelStyle = TextStyle(
            color: ColorPalette.primaryBlue,
            fontFamily: 'Avenir',
            fontSize: 18,
            height: 1);
        iconColor = ColorPalette.primaryBlue;
      } else {
        suffixWidget = Opacity(
          opacity: 0,
        );
        labelStyle = TextStyle(
            color: ColorPalette.Grey.P400,
            fontFamily: 'Avenir',
            fontSize: 18,
            height: 1);
        iconColor = ColorPalette.primaryBlue;
      }
    }
    return Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 0,
        child: SizedBox(
          height: 80.0,
          child: TextFormField(
            // The validator receives the text the user has typed in
            style: TextStyle(
                color: Colors.black,
                height: 1.5,
                fontSize: 16,
                textBaseline: TextBaseline.alphabetic),
            textAlign: TextAlign.start,
            keyboardType: TextInputType.emailAddress,
            cursorColor: ColorPalette.primaryBlue,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                    const BorderSide(color: Colors.transparent, width: 1)),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: ColorPalette.primaryBlue, width: 8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: ColorPalette.primaryError, width: 8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorStyle: TextStyle(
                    color: ColorPalette.primaryError,
                    fontFamily: 'Avenir',
                    fontSize: 14),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: ColorPalette.primaryError, width: 8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: "Email",
                labelStyle: labelStyle,
//              hintStyle: labelStyle,
//              hintText: "Email",
                filled: true,
                fillColor: ColorPalette.primaryGrey,
                suffix: suffixWidget,
                prefix: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Icon(
                      Icons.alternate_email,
                      color: iconColor,
                      size: 18,
                    ))),
            validator: validator,
            obscureText: false,
            controller: emailController,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            focusNode: focusNode,
          ),
        ));
  }
}

class NameField extends StatelessWidget {
  final TextEditingController nameController;
  final String hintText;
  final String initialValue;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  Widget suffixWidget;
  TextStyle labelStyle;
  bool hasError;
  Color iconColor;

  NameField(
      {@required this.nameController,
      this.hintText,
      this.initialValue,
      this.onFieldSubmitted,
      @required this.focusNode,
      @required this.hasError,
      @required this.onChanged,
      @required this.validator,});

  @override
  Widget build(BuildContext context) {
    if (this.hasError) {
      suffixWidget = SizedBox(
          width: 25,
          height: 25,
          child: Material(
            child: InkWell(
              child: Icon(
                Icons.error,
                size: 25,
                color: ColorPalette.primaryError,
              ),
              onTap: () {},
            ),
            shape: CircleBorder(),
            color: Colors.transparent,
          ));
      iconColor = ColorPalette.primaryError;
      labelStyle = TextStyle(
          color: ColorPalette.primaryError,
          fontFamily: 'Avenir',
          fontSize: 18,
          height: 1);
    } else {
      if (focusNode.hasFocus) {
        suffixWidget = SizedBox(
            width: 25,
            height: 25,
            child: Material(
              child: InkWell(
                child: Icon(
                  Icons.cancel,
                  size: 25,
                  color: ColorPalette.secondaryGrey,
                ),
                onTap: () {
                  nameController.clear();
                },
              ),
              shape: CircleBorder(),
              color: Colors.transparent,
            ));
        labelStyle = TextStyle(
            color: ColorPalette.primaryBlue,
            fontFamily: 'Avenir',
            fontSize: 18,
            height: 1);
        iconColor = ColorPalette.primaryBlue;
      } else {
        suffixWidget = Opacity(
          opacity: 0,
        );
        labelStyle = TextStyle(
            color: ColorPalette.Grey.P400,
            fontFamily: 'Avenir',
            fontSize: 18,
            height: 1);
        iconColor = ColorPalette.primaryBlue;
      }
    }
    return Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 0.0,
        child: SizedBox(
            height: 80.0,
            child: TextFormField(
              style: TextStyle(
                  color: Colors.black,
                  height: 1.5,
                  fontSize: 16,
                  textBaseline: TextBaseline.alphabetic),
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              cursorColor: ColorPalette.primaryBlue,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.primaryBlue, width: 8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.primaryError, width: 8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorStyle: TextStyle(
                      color: ColorPalette.primaryError,
                      fontFamily: 'Avenir',
                      fontSize: 14),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.primaryError, width: 8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: hintText,
                  labelStyle: labelStyle,
//                  hintStyle: labelStyle,
                  filled: true,
                  fillColor: ColorPalette.primaryGrey,
                  suffix: suffixWidget,
                  prefix: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(
                        Icons.person_pin,
                        color: iconColor,
                        size: 18,
                      ))),
              validator: validator,
              obscureText: false,
              controller: nameController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: onFieldSubmitted,
              focusNode: focusNode,
              onChanged: onChanged,
            )));
  }
}

class GenericDropdownField extends StatelessWidget{
  final Key textFieldKey;
  final TextStyle textStyle;
  final String hintText;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final TextEditingController textController;
  final TextInputFormatter textFormatter;
  final TextInputAction keyboardAction;
  final String value;
  final Color cursorColor;
  final GestureTapCallback onTap;
  final String suffixText;
  final String prefixText;
  final Widget suffix;
  final Icon prefixIcon;
  final TextCapitalization textCapitalization;
  final bool disabled;
  final bool isRequired;
  final Icon suffixIcon;
  final GestureTapCallback clearText;
  TextStyle labelStyle;
  num elevation;
  bool hasError;

  //passing props in react style
  GenericDropdownField(
      {this.textFieldKey,
        @required this.hintText,
        this.textStyle,
        this.keyboardType = TextInputType.text,
        this.validator,
        this.textController,
        this.textFormatter,
        this.keyboardAction = TextInputAction.next,
        this.value,
        this.cursorColor,
        this.onTap,
        this.suffixText,
        this.suffix,
        this.prefixText,
        this.prefixIcon,
        this.textCapitalization,
        this.suffixIcon,
        this.clearText,
        this.hasError = false,
        this.disabled = false,
        this.isRequired = false,
      });

  String validateExists(String value) {
    if ((value?.isEmpty ?? true) || value == hintText)
      return 'Enter Valid ' + this.hintText;
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    List<TextInputFormatter> inputFormatters = [];
    if(this.textFormatter != null){
      inputFormatters.add(this.textFormatter);
    }
    labelStyle = TextStyle(
        color: ColorPalette.Grey.P400, fontFamily: 'Avenir', fontSize: 22);
    elevation = 0.0;
    return Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: elevation,
        child: TextFormField(
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Avenir',
            fontSize: deviceWidth > 600 ? 18 : 16,
          ),
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            labelText: hintText,
            labelStyle: labelStyle,
            fillColor: disabled ? ColorPalette.Grey.P300 : ColorPalette.primaryGrey,
            filled: true,
            suffix: suffix,
            suffixIcon: suffixIcon
          ),
          onTap: disabled ? null : onTap,
          validator: isRequired ? validateExists : null,
          controller: textController,
          inputFormatters: inputFormatters,
          textInputAction: keyboardAction,
          maxLines: 2,
          readOnly: true,
        ));
  }
}

class ThousandsSeparatorTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int group = 0;
    String out = "";
    for(int i = value.length;i > 0;i--) {
      if(value.substring(i-1, i) == " ") continue;
      if(group == 3){
        out = " " + out;
        group = 0;
      }
      out = value.substring(i-1, i) + out;
      group ++;
    }
    return TextEditingValue(text: out, selection: TextSelection.collapsed(offset: out.length));
  }

}