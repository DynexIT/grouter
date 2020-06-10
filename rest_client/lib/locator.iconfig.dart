// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:rest_client/core/services/connectivity/connectivity_service.dart';
import 'package:rest_client/core/utils/file_helper.dart';
import 'package:rest_client/core/services/http/http_service_impl.dart';
import 'package:rest_client/core/services/http/http_service.dart';
import 'package:rest_client/core/services/json/json_service.dart';
import 'package:rest_client/core/services/key_storage/key_storage_service_impl.dart';
import 'package:rest_client/core/services/key_storage/key_storage_service.dart';
import 'package:rest_client/core/services/async_register_module.dart';
import 'package:rest_client/core/services/navigation/navigation_service_impl.dart';
import 'package:rest_client/core/services/navigation/navigation_service.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final asyncRegisterModule = _$AsyncRegisterModule();
  g.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  g.registerLazySingleton<FileHelper>(() => FileHelperImpl());
  g.registerLazySingleton<HttpService>(() => HttpServiceImpl());
  g.registerLazySingleton<JSONService>(() => JSONService());
  g.registerLazySingleton<KeyStorageService>(() => KeyStorageServiceImpl());
  final keyStorageServiceImpl = await asyncRegisterModule.preferencesService;
  g.registerFactory<KeyStorageServiceImpl>(() => keyStorageServiceImpl);
  g.registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
}

class _$AsyncRegisterModule extends AsyncRegisterModule {}
