import 'package:dio/dio.dart';
import 'package:observable_ish/list/list.dart';
import 'package:rest_client/core/models/base_environment.dart';
import 'package:rest_client/core/models/endpoint_group.dart';
import 'package:rest_client/core/models/environment.dart';
import 'package:rest_client/core/models/request.dart';
import 'package:rest_client/core/models/request_type.dart';
import 'package:rest_client/core/services/http/http_service.dart';
import 'package:rest_client/core/services/json/json_service.dart';
import 'package:rest_client/core/services/key_storage/key_storage_service.dart';
import 'package:rest_client/locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  final _keyStorageService = locator<KeyStorageService>();
  final _httpService = locator<HttpService>();
  final _jsonService = locator<JSONService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_jsonService];

  CurrentEnvironment environment;

  RequestType requestType;

  String request = "http://localhost:8080";

  RxList<EndpointGroup> get endpointGroups => _jsonService.endpointGroups;

  RxList<EnvironmentObject> get environments => _jsonService.environments;

  EnvironmentObject selectedEnvironment;

  void init() {
    setBusy(true);
    //TODO: ERROR CHECKING
    selectedEnvironment = environments.first;
    request = endpointGroups.first.children.first.request.url;
//    environment = _keyStorageService.environment;
//    requestType = _keyStorageService.requestType;
    setBusy(false);
  }

  onChangedEnvironment(EnvironmentObject value){
    selectedEnvironment = value;
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

  void onRequestTap(RequestObject requestObject) {
    updateRequest(requestObject.url);
  }

  void onSendPressed(){
    print("Request $request");
    switch(environment.currentEnvironment){

    }
  }
}