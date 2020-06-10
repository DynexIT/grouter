import 'package:flutter/material.dart';
import 'package:rest_client/ui/views/start_up_view/start_up_view_model.dart';
import 'package:rest_client/ui/widgets/centered_view.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => CenteredView(
        child: Center(
          child: CircularProgressIndicator()
        ),
      ),
    );
  }
}