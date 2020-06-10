import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rest_client/core/constants/view_routes.dart';
import 'package:rest_client/core/models/endpoint_group.dart';
import 'package:rest_client/core/services/json/json_service.dart';
import 'package:rest_client/core/services/key_storage/key_storage_service.dart';
import 'package:rest_client/locator.dart';
import 'package:stacked/stacked.dart';

class StartUpViewModel extends BaseViewModel {
  final _keyStorageService = locator<KeyStorageService>();
  final _jsonService = locator<JSONService>();

  Future<void> handleStartUpLogic() async {
    await Future.wait([
      _keyStorageService.initHive(),
      _jsonService.init()
    ]);

    Get.offAllNamed(ViewRoutes.Home);
  }
}
