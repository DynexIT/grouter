import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rest_client/ui/views/home/home_view_desktop.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
          body: Form(
            key: model.formKey,
            autovalidate: model.autoValidate,
            child: _Home(),
          )
      ),
    );
  }
}


class _Home extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    if(model.isBusy){
      return Center(child: CircularProgressIndicator(),);
    }

    return ScreenTypeLayout.builder(
      desktop: (BuildContext context) => HomeViewDesktop(),
    );
  }
}