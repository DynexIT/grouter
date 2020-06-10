import 'package:dio/dio.dart';
import 'package:rest_client/core/models/base_environment.dart';
import 'package:rest_client/core/models/request_type.dart';
import 'package:rest_client/core/services/http/http_service.dart';
import 'package:rest_client/core/services/key_storage/key_storage_service.dart';
import 'package:rest_client/locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _keyStorageService = locator<KeyStorageService>();
  final _httpService = locator<HttpService>();

  CurrentEnvironment environment;

  RequestType requestType;

  String request = "http://localhost:8080";

  Future<void> init() async {
    setBusy(true);
    await Future.wait([
      _keyStorageService.initHive(),
    ]);
    environment = _keyStorageService.environment;
    requestType = _keyStorageService.requestType;
    setBusy(false);
  }

  onChangedEnvironment(dynamic value){
    environment.currentEnvironment = value;
    _keyStorageService.environment = environment;
    notifyListeners();
  }

  onChangedRequestType(dynamic value){
    requestType.currentRequestType = value;
    _keyStorageService.requestType = requestType;
    notifyListeners();
  }

  void updateRequest(String value) {
    request = value;
    notifyListeners();
  }

  void onSendPressed(){
    print("Request $request");
    switch(environment.currentEnvironment){

    }
  }
}