import 'package:hive/hive.dart';
import 'package:rest_client/core/models/base_environment.dart';
import 'package:rest_client/core/models/request_type.dart';

abstract class KeyStorageService {
  Future<void> initHive();

  Box settingsBox;

  Box environmentsBox;
  CurrentEnvironment environment;

  RequestType requestType;
}
