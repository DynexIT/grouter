import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:rest_client/core/models/base_environment.dart';
import 'package:rest_client/core/models/endpoint.dart';
import 'package:rest_client/core/models/endpoint_group.dart';
import 'package:rest_client/core/models/environment.dart';
import 'package:rest_client/core/models/global_request_headers.dart';
import 'package:rest_client/core/utils/file_helper.dart';
import 'package:rest_client/locator.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class JSONService with ReactiveServiceMixin{
  final _fileHelper = locator<FileHelper>();

  RxList<EndpointGroup> _endpointGroups = RxList<EndpointGroup>();

  RxList<EnvironmentObject> _environments = RxList<EnvironmentObject>();

  RxValue<BaseEnvironment> _baseEnv = RxValue<BaseEnvironment>(initial:
  BaseEnvironment(variables: {}));

  RxValue<GlobalRequestHeaders> _globalHeaders = RxValue<GlobalRequestHeaders>(initial:
  GlobalRequestHeaders(headers: {}));

  RxList<EndpointGroup> get endpointGroups => _endpointGroups;

  RxList<EnvironmentObject> get environments => _environments;

  BaseEnvironment get baseEnv => _baseEnv.value;

  GlobalRequestHeaders get globalHeaders => _globalHeaders.value;

  JSONService() {
    listenToReactiveValues([_endpointGroups, _environments, _baseEnv, _globalHeaders]);
  }

  Future<void> init() async {
    final json = await _fileHelper.decodedJSON("assets/json/rest_idea.json");
    Map<String, dynamic> baseVariables = {};
    Map<String, dynamic> globalHeaders = {};
    if(json['base_environment_data'] != null){
      baseVariables = json['base_environment_data'];
    }
    if(json['global_request_headers'] != null){
      globalHeaders = json['global_request_headers'];
    }
    for(dynamic json in json['environments']){
      _environments.add(EnvironmentObject.fromJson(json));
    }
    for(dynamic json in json['endpoints']){
      _endpointGroups.add(EndpointGroup.fromJson(json));
    }
    _baseEnv.value = BaseEnvironment(variables: baseVariables);
    _globalHeaders.value = GlobalRequestHeaders(headers: globalHeaders);
  }
}