import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cursor/flutter_cursor.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rest_client/core/models/endpoint.dart';
import 'package:rest_client/core/models/environment.dart';
import 'package:rest_client/core/models/request.dart';
import 'package:rest_client/ui/shared/color_pallete.dart';
import 'package:rest_client/ui/views/home/home_view_model.dart';
import 'package:rest_client/ui/widgets/centered_view.dart';
import 'package:rest_client/ui/widgets/dropdown_menu_extended.dart';
import 'package:rest_client/ui/widgets/dropdown_menu_short.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:rest_client/ui/shared/ui_helpers.dart';

class HomeViewDesktop extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return CenteredView(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: _RequestField(),
        ),
        UIHelper.verticalSpaceMedium(),
        Flexible(
          child: _VariableForm(),
        ),
        UIHelper.verticalSpaceMedium(),
        Flexible(
          child: _Environments(),
        ),
        UIHelper.verticalSpaceMedium(),
        Flexible(
          child: _EndpointGroups(),
        )
      ],
    ));
  }
}

class _RequestField extends HookViewModelWidget<HomeViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          model.requestType,
          style: TextStyle(
              color: Colors.white, fontFamily: 'Avenir', fontSize: 22),
        ),
        UIHelper.horizontalSpaceMedium(),
        Expanded(
          child: Text(
            model.url,
            style: TextStyle(
                color: Colors.white, fontFamily: 'Avenir', fontSize: 22),
          ),
        ),
        FlatButton(onPressed: model.onSendPressed, child: Text('SEND'))
      ],
    );
  }
}

class _VariableForm extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return ListView.builder(
        itemCount: model.requestVariables.length,
        itemBuilder: (context, index){
          String key = model.requestVariables.keys.elementAt(index);
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: constraints.maxWidth * 0.3,
                child: Text(key),
              ),
              _VariableField(constraints: constraints, varKey: key,)
//              Container(
//                width: constraints.maxWidth * 0.7,
//                child: TextFormField(
//                  initialValue: model.requestVariables[key],
//                  onChanged: (String value) {
//                    model.updateVariable(value, key);
//                  },
//                  validator: (String value) {
//                    if (value.isEmpty) {
//                      return 'Please enter some text';
//                    }
//                    return null;
//                  },
//                ),
//              ),
            ],
          );
        }
      );
    });
  }
}

class _VariableField extends HookViewModelWidget<HomeViewModel>{
  final BoxConstraints constraints;
  final String varKey;

  _VariableField({Key key, this.constraints, this.varKey}) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel model) {
    var varController = useTextEditingController(text:
      model.requestVariables[varKey]);
    return Container(
      width: constraints.maxWidth * 0.7,
      child: TextFormField(
        controller: varController,
        onChanged: (String value) {
          varController.text = value;
          model.updateVariable(value, varKey);
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}

class _Environments extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return (model.environments?.isNotEmpty ?? false)
        ? HoverCursor(
            cursor: Cursor.pointer,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Environments",
                labelStyle: TextStyle(
                    color: ColorPalette.Grey.P700,
                    fontFamily: 'Avenir',
                    fontSize: 22),
              ),
              itemHeight: 50,
              value: model.selectedEnvironment,
              items:
                  model.environments.map((EnvironmentObject environmentObject) {
                return DropdownMenuItem<EnvironmentObject>(
                  value: environmentObject,
                  child: Text(environmentObject.name),
                );
              }).toList(),
              onChanged: model.onChangedEnvironment,
              isExpanded: true,
            ))
        : Container();
  }
}

class _EndpointGroups extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return (model.endpointGroups?.isNotEmpty ?? false)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: model.endpointGroups.length,
            itemBuilder: (context, index) {
              return HoverCursor(
                  cursor: Cursor.pointer,
                  child: ExpandableNotifier(
                      initialExpanded: false,
                      child: ScrollOnExpand(
                          child: Expandable(
                            collapsed: ExpandableButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      model.endpointGroups[index].name,
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right),
                              ],
                          ),
                        ),
                        expanded: Column(
                          children: [
                            _Endpoint(
                              endpoints:
                                  model?.endpointGroups[index]?.children ??
                                      null,
                            ),
                            ExpandableButton(
                              child: Text("Back"),
                            )
                          ],
                        ),
                      ))));
            },
          )
        : Container();
  }
}

class _Endpoint extends ViewModelWidget<HomeViewModel> {
  final List<Endpoint> endpoints;

  _Endpoint({Key key, this.endpoints}) : super(key: key);

  Widget build(BuildContext context, HomeViewModel model) {
    return (endpoints?.isNotEmpty ?? false)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: endpoints.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                child: HoverCursor(
                  cursor: Cursor.pointer,
                  child: GestureDetector(
                    onTap: () => model.onRequestTap(endpoints[index].request),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        text: endpoints[index]?.request?.type ?? "GET",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'Avenir',
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          height: 1.36,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: endpoints[index].name,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Avenir',
                                  color: Colors.white.withOpacity(0.6),
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  height: 1.4)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Container();
  }
}
