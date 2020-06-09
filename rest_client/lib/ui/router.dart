import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rest_client/core/constants/view_routes.dart';
import 'package:rest_client/ui/views/home/home_view.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return GetRouteBase(
      settings: RouteSettings(name: settings.name),
      page: _generateView(settings),
      fullscreenDialog: false,
    );
  }

  static Widget _generateView(RouteSettings settings) {
    switch (settings.name) {
      case ViewRoutes.StartUp:
        return HomeView();
    }
  }
}

