// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:rest_client/core/services/connectivity/connectivity_service.dart';
import 'package:rest_client/core/utils/file_helper.dart';
import 'package:rest_client/core/services/http/http_service_impl.dart';
import 'package:rest_client/core/services/http/http_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  g.registerLazySingleton<FileHelper>(() => FileHelperImpl());
  g.registerLazySingleton<HttpService>(() => HttpServiceImpl());
}
