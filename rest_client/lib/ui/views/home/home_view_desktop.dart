
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
          children: [
            _RequestField(),
            UIHelper.verticalSpaceMedium(),
            DropDownMenuExtended(
              title: "Environment",
              items: model.environment.environments,
              value: model.environment.currentEnvironment,
              onChanged: (dynamic value) {
                model.onChangedEnvironment(value);
              },
            ),
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
              child: DropDownMenuShort(
                  title: "Request Type",
                  value: model.requestType.currentRequestType,
                  onChanged: model.onChangedRequestType,
                  items: model.requestType.requestTypes
              ),
            )
          ),
        ),
      ],
    );
  }

}