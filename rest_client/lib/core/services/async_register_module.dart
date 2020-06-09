import 'package:injectable/injectable.dart';
import 'key_storage/key_storage_service_impl.dart';

/// All services that has to be pre resolved into an async instance should be added here
@module
abstract class AsyncRegisterModule {
  @preResolve
  Future<KeyStorageServiceImpl> get preferencesService =>
      KeyStorageServiceImpl.getInstance();
}