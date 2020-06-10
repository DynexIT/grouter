import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:rest_client/core/models/endpoint_group.dart';
import 'package:rest_client/core/models/environment.dart';
import 'package:rest_client/core/utils/file_helper.dart';
import 'package:rest_client/locator.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class JSONService with ReactiveServiceMixin{
  final _fileHelper = locator<FileHelper>();

  RxList<EndpointGroup> _endpointGroups = RxList<EndpointGroup>();

  RxList<EnvironmentObject> _environments = RxList<EnvironmentObject>();

  RxList<EndpointGroup> get endpointGroups => _endpointGroups;

  RxList<EnvironmentObject> get environments => _environments;

  JSONService() {
    listenToReactiveValues([_endpointGroups, _environments]);
  }

  Future<void> init() async {
    final json = await _fileHelper.decodedJSON("assets/json/rest_idea.json");
    for(dynamic json in json['environments']){
      _environments.add(EnvironmentObject.fromJson(json));
    }
    for(dynamic json in json['endpoints']){
      _endpointGroups.add(EndpointGroup.fromJson(json));
    }
    print("GROUPS: ${endpointGroups.length}");
  }
}