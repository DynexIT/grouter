import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:observable_ish/list/list.dart';
import 'package:rest_client/core/models/base_environment.dart';
import 'package:rest_client/core/models/endpoint_group.dart';
import 'package:rest_client/core/models/environment.dart';
import 'package:rest_client/core/models/global_request_headers.dart';
import 'package:rest_client/core/models/request.dart';
import 'package:rest_client/core/models/request_history.dart';
import 'package:rest_client/core/services/http/http_service.dart';
import 'package:rest_client/core/services/json/json_service.dart';
import 'package:rest_client/core/services/key_storage/key_storage_service.dart';
import 'package:rest_client/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeViewModel extends ReactiveViewModel {
  final _keyStorageService = locator<KeyStorageService>();
  final _httpService = locator<HttpService>();
  final _jsonService = locator<JSONService>();
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_jsonService];

  bool _autoValidate = false;

  bool get autoValidate => _autoValidate;

  String request = "http://localhost:8080";

  RxList<EndpointGroup> get endpointGroups => _jsonService.endpointGroups;

  RxList<EnvironmentObject> get environments => _jsonService.environments;

  BaseEnvironment get baseEnv => _jsonService.baseEnv;

  GlobalRequestHeaders get globalHeaders => _jsonService.globalHeaders;

  EnvironmentObject selectedEnvironment;

  RequestObject currentRequest;

  String get url => currentRequest.url;

  String get requestType => currentRequest.type;

  Map<String, String> requestVariables = {};

  Map<String, String> requestHeaders = {};

  Map<String, String> requestBody = {};

  Map<String, RequestHistory> allRequestHistory = {};

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  void init() {
    setBusy(true);
    //TODO: ERROR CHECKING
    selectedEnvironment = (environments?.isNotEmpty ?? false) ? environments.first : null;
    currentRequest = (endpointGroups?.first?.children?.isNotEmpty ?? false) ?
      endpointGroups.first?.children?.first?.request : null;
    setCurrentRequestVariables();
    setBusy(false);
  }

  void onHistorySelected(String choice){

  }

  onChangedEnvironment(EnvironmentObject value){
    selectedEnvironment = value;
    setCurrentRequestVariables();
    notifyListeners();
  }

  void updateRequest(String value) {
    request = getReplacedString(value);
    notifyListeners();
  }

  void updateVariable(String value, String key){
    requestVariables[key] = value;
    notifyListeners();
  }

  void onRequestTap(RequestObject requestObject) {
    if(requestObject?.url?.isNotEmpty ?? false){
      updateRequest(requestObject.url);
    }else{
      //TODO: Default url
    }
  }

  void setCurrentRequestVariables(){
    List<String> urlVars = [];
    List<String> bodyVars = [];
    List<String> headerVars = [];
    urlVars = getStringVariables(currentRequest.url);
    bodyVars = getStringVariables(currentRequest.body);
    headerVars = getMapVariables(currentRequest.headers);
    for(String variable in urlVars){
      requestVariables.putIfAbsent(variable, () => "");
    }
    for(String variable in bodyVars){
      requestVariables.putIfAbsent(variable, () => "");
    }
    for(String variable in headerVars){
      requestVariables.putIfAbsent(variable, () => "");
    }
    requestVariables.forEach((key, value) {
      if(!selectedEnvironment.data.containsKey(key)){
        if (baseEnv.variables.containsKey(key)) {
          requestVariables[key] = baseEnv.variables[key];
        }
      }else{
        requestVariables[key] = selectedEnvironment.data[key];
      }
    });
  }

  Future<void> onSendPressed() async {
    if (!_formKey.currentState.validate()) {
      _autoValidate = true;
      setBusy(false);
    } else {
      _formKey.currentState.save();

      setBusy(true);

      String replacedURL = getReplacedString(currentRequest.url);
      String replacedBody = getReplacedString(currentRequest.body);
      Map<String, String> replacedHeaders = getReplacedMap(currentRequest.headers);
      //Add global headers to request
      if(globalHeaders?.headers?.isNotEmpty ?? false){
        globalHeaders.headers.forEach((key, value) {
          replacedHeaders[key] = value;
        });
      }
      print("URL: ${replacedURL}");
      print("BODY: ${replacedBody}");
      print("Headers: ${replacedHeaders}");
      var result;
      switch(currentRequest.type){
        case "POST":
          result = await _httpService.postHttp(replacedURL, currentRequest.body,
              headers: replacedHeaders);
          break;
        case "GET":
          result = await _httpService.getHttp(replacedURL, headers: replacedHeaders);
          break;
        default:
          result = await _httpService.getHttp(replacedURL, headers: replacedHeaders);
          break;
      }
      print("RESULT: $result");
      //Add to request history
      RequestHistory requestHistory = RequestHistory(
        url: replacedURL,
        headers: replacedHeaders,
        type: currentRequest.type,
      );
      addToRequestHistory(requestHistory);
      setBusy(false);
    }
  }

  void addToRequestHistory(RequestHistory requestHistory){
    final now =  DateTime.now();
    String formattedTime = timeago.format(now);
    allRequestHistory[formattedTime] = requestHistory;
  }

  List<String> getMapVariables(Map value){
    List<String> variables = [];
    for(MapEntry entry in value.entries){
      if(entry.value.contains("{{")) {
        Iterable<Match> matches = getStringMatches(entry.value);
        matches.forEach((m) {
          variables.add(m.group(1));
        });
      }
    }
    return variables;
  }

  List<String> getStringVariables(String value){
    List<String> variables = [];
    if(value.contains("{{")) {
      Iterable<Match> matches = getStringMatches(value);
      matches.forEach((m) {
        variables.add(m.group(1));
      });
    }
    return variables;
  }

  String getReplacedString(String toBeReplaced){
    String replacedString = toBeReplaced;
    if(toBeReplaced.contains("{{")){
      Iterable<Match> matches = getStringMatches(toBeReplaced);
      List<String> variables = [];
      List<String> variablesBraces = [];
      matches.forEach((m) {
        variablesBraces.add(m.group(0));
        variables.add(m.group(1));
      });
      for (int i = 0; i < variables.length; i++) {
        if(requestVariables.containsKey(variables[i])){
          replacedString = toBeReplaced.replaceAll(variablesBraces[i],
              requestVariables[variables[i]]);
        }else {
          if (!selectedEnvironment.data.containsKey(variables[i])) {
            if (baseEnv.variables.containsKey(variables[i])) {
              replacedString = toBeReplaced.replaceAll(
                  variablesBraces[i], baseEnv.variables[variables[i]]);
            }
          } else {
            replacedString = toBeReplaced.replaceAll(
                variablesBraces[i], selectedEnvironment.data[variables[i]]);
          }
        }
      }
    }
    return replacedString;
  }
  
  Map<String, String> getReplacedMap(Map<String, String> toBeReplaced){
    Map<String, String> replacedMap = toBeReplaced;
    replacedMap.forEach((key, value) { 
      if(value.contains("{{")){
        Iterable<Match> matches = getStringMatches(value);
        List<String> variables = [];
        List<String> variablesBraces = [];
        matches.forEach((m) {
          variablesBraces.add(m.group(0));
          variables.add(m.group(1));
        });
        for (int i = 0; i < variables.length; i++) {
          if(requestVariables.containsKey(variables[i])){
            replacedMap[key] = value.replaceAll(variablesBraces[i],
                requestVariables[variables[i]]);
          }else{
            if(!selectedEnvironment.data.containsKey(variables[i])){
              if (globalHeaders.headers.containsKey(variables[i])) {
                replacedMap[key] = value.replaceAll(variablesBraces[i],
                    baseEnv.variables[variables[i]]);
              }
            }else {
              replacedMap[key] = value.replaceAll(variablesBraces[i],
                  selectedEnvironment.data[variables[i]]);
            }
          }
        }
      }
    });
    return replacedMap;
  }

  Iterable<Match> getStringMatches(String value){
    RegExp exp = new RegExp(r"{{(([^}][^}]?|[^}]}?)*)}}");
    Iterable<Match> matches = exp.allMatches(value);
    return matches;
  }
}