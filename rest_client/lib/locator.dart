import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'locator.iconfig.dart';

final locator = GetIt.instance;

@injectableInit
Future<void> setupLocator() async {
  //External
  locator.registerLazySingleton<HiveInterface>(() => Hive);
  $initGetIt(locator);
}

//GetIt locator = GetIt.instance;
//
///// Setup function that is run before the App is run.
/////   - Sets up singletons that can be called from anywhere
///// in the app by using locator<Service>() call.
/////   - Also sets up factor methods for view models.
//Future<void> setupLocator({bool test = false}) async {
//  // Services
//  locator.registerLazySingleton<NavigationService>(
//        () => NavigationServiceImpl(),
//  );
//  locator.registerLazySingleton<HardwareInfoService>(
//        () => HardwareInfoServiceImpl(),
//  );
//  locator.registerLazySingleton<ConnectivityService>(
//        () => ConnectivityServiceImpl(),
//  );
//  // Utils
//  locator.registerLazySingleton<FileHelper>(() => FileHelperImpl());
//
//  locator.registerLazySingleton<CameraService>(
//        () => CameraServiceImpl(),
//  );
//
//  locator.registerLazySingleton<SnackBarService>(() => SnackBarServiceImpl());
//
//
//  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());
//  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl());
//  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
//  locator.registerLazySingleton<ProcessService>(() => ProcessServiceImpl());
//  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());
//
//  locator.registerLazySingleton<NotificationService>(() => NotificationServiceImpl());
//
//  locator.registerLazySingleton<UsersLocalDataSource>(
//        () => UsersLocalDataSourceImpl(),
//  );
//  locator.registerLazySingleton<UsersRemoteDataSource>(
//        () => UsersRemoteDataSourceImpl(),
//  );
//
//  locator.registerLazySingleton<ChatsLocalDataSource>(
//        () => ChatsLocalDataSourceImpl(),
//  );
//  locator.registerLazySingleton<ChatsRemoteDataSource>(
//        () => ChatsRemoteDataSourceImpl(),
//  );
//  locator.registerLazySingleton<ProcessLocalDataSource>(
//      () => ProcessLocalDataSourceImpl(),
//  );
//  locator.registerLazySingleton<ProcessRemoteDataSource>(
//          () => ProcessRemoteDataSourceImpl(),
//  );
//
//
//  // Repositories
//  locator.registerLazySingleton<ChatsRepository>(() => ChatsRepositoryImpl());
//  locator.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl());
//  locator.registerLazySingleton<ProcessRepository>(() => ProcessRepositoryImpl());
//
////  if (!test) {
//    await _setupLocalStorage();
////  }
//
//  // External
//  locator.registerLazySingleton<HiveInterface>(() => Hive);
//}
//
//Future<void> _setupLocalStorage() async {
//  final instance = await KeyStorageServiceImpl.getInstance();
//  await instance.initBoxes();
//  locator.registerLazySingleton<KeyStorageService>(() => instance);
//}