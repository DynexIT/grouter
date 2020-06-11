import 'package:injectable/injectable.dart';
import 'package:rest_client/core/models/base_environment.dart';
import 'package:rest_client/core/models/request_type.dart';
import 'package:rest_client/core/utils/logger.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'key_storage_service.dart';
/// Service that is responsible for storing/retrieving data in/from
/// local storage using the [Hive] package.
@LazySingleton(as: KeyStorageService)
class KeyStorageServiceImpl implements KeyStorageService {
  static const notifications_key = 'notifications_key';
  static const localAuth_key = 'local_auth';
  static const wifiUpload_key = 'wifi_upload';
  static const env_variables_key = 'env_variables';
  static const requestTypes_key = 'requestTypes';
  static const String settings = 'settingsBox';
  static const String environments = 'environmentsBox';
  Box _settingsBox;
  Box _environmentsBox;

  List<String> _requestTypes = [
    "GET",
    "POST",
    "PUT",
    "PATCH",
    "DELETE"
  ];

  List<String> _environments = [
    "base",
    "local"
  ];

  static KeyStorageServiceImpl _instance;

  static Future<KeyStorageServiceImpl> getInstance() async {
    _instance ??= KeyStorageServiceImpl();
    return _instance;
  }

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RequestTypeAdapter());
    _settingsBox = await Hive.openBox(settings);
    _environmentsBox = await Hive.openBox(environments);
  }

  @override
  RequestType get requestType => _getFromDisk(requestTypes_key, environments) ??
  RequestType(currentRequestType: "GET", requestTypes: _requestTypes);

  @override
  set requestType(RequestType requestType) => _saveToDisk(requestTypes_key,
      requestType, environments);

  @override
  Box get settingsBox => _settingsBox;

  @override
  Box get environmentsBox => _environmentsBox;

  @override
  set settingsBox(Box _settingsBox) {
    this._settingsBox = _settingsBox;
  }

  @override
  set environmentsBox(Box _environmentsBox) {
    this._environmentsBox = _environmentsBox;
  }

  dynamic _getFromDisk(String key, String boxName) {
    var value;
    switch(boxName){
      case settings:
        value = settingsBox.get(key);
        break;
      case environments:
        value = environmentsBox.get(key);
        break;
    }

    Logger.d('LocalStorageService: (Fetching) key: $key value: $value');

    return value;
  }

  void _saveToDisk<T>(String key, T content, String boxName) {
    Logger.d('LocalStorageService: (Saving) key: $key value: $content');

    switch(boxName){
      case settings:
        settingsBox.put(key, content);
        break;
      case environments:
        environmentsBox.put(key, content);
        break;
    }
  }
}