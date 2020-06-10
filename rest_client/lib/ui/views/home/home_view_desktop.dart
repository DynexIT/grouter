
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

class HomeViewDesktop extends ViewModelWidget<HomeViewModel>{
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return CenteredView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: _RequestField(),
            ),
            UIHelper.verticalSpaceMedium(),
            Flexible(child:  _Environments(),),
            UIHelper.verticalSpaceMedium(),
            Flexible(child: _EndpointGroups(),)
          ],
        )
    );
  }

}

class _RequestField extends HookViewModelWidget<HomeViewModel>{
  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel model) {
    var requestController = useTextEditingController(text: model.request);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        TextFormField(
          controller: requestController,
          onChanged: model.updateRequest,
          decoration: InputDecoration(
            suffix: FlatButton(
                onPressed: model.onSendPressed,
                child: Text('SEND')
            ),
            prefix: Container(
              width: 80,
              child: Text("GET")
            )
          ),
        ),
      ],
    );
  }
}

class _Environments extends ViewModelWidget<HomeViewModel>{
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return (model.environments?.isNotEmpty ?? false) ?
    HoverCursor(
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
              color: ColorPalette.Grey.P700, fontFamily: 'Avenir', fontSize: 22),
        ),
        itemHeight: 50,
        value: model.selectedEnvironment,
        items: model.environments.map((EnvironmentObject environmentObject) {
          return DropdownMenuItem<EnvironmentObject>(
            value: environmentObject,
            child: Text(environmentObject.name),
          );
        }).toList(),
        onChanged: model.onChangedEnvironment,
        isExpanded: true,
      )
    ) : Container();
  }
}



class _EndpointGroups extends ViewModelWidget<HomeViewModel>{
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return (model.endpointGroups?.isNotEmpty ?? false) ?
    ListView.builder(
      shrinkWrap: true,
      itemCount: model.endpointGroups.length,
      itemBuilder: (context, index){
        return HoverCursor(
          cursor: Cursor.pointer,
          child: ExpandablePanel(
            header: Text(model.endpointGroups[index].name),
            collapsed: Text(model.endpointGroups[index].name, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
            expanded: _Endpoint(endpoints: model.endpointGroups[index].children,),
          ),
        );
      },
    ) : Container();
  }
}

class _Endpoint extends ViewModelWidget<HomeViewModel>{
  final List<Endpoint> endpoints;

  _Endpoint({Key key, this.endpoints}) : super(key: key);

  Widget build(BuildContext context, HomeViewModel model) {
    return (endpoints?.isNotEmpty ?? false) ?
    ListView.builder(
      shrinkWrap: true,
      itemCount: endpoints.length,
      itemBuilder: (context, index){
        return Container(
          height: 50,
          child: HoverCursor(
            cursor: Cursor.pointer,
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                  text:
                  endpoints[index].request.type,
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
                            color: Colors.white
                                .withOpacity(0.6),
                            fontStyle:
                            FontStyle.normal,
                            fontWeight:
                            FontWeight.normal,
                            height: 1.4)),
                  ],
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      model.onRequestTap(endpoints[index].request);
                    }
              ),
            ),
          ),
        );
      },
    ) : Container();
  }
}