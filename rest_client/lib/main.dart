import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rest_client/ui/provider_setup.dart';
import 'package:rest_client/ui/router.dart';
import 'package:rest_client/ui/shared/themes.dart' as themes;
import 'package:rest_client/ui/views/home/home_view.dart';
import 'core/constants/view_routes.dart';
import 'core/services/navigation/navigation_service.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themes.primaryMaterialTheme,
      darkTheme: themes.darkMaterialTheme,
      navigatorKey: navigationService.navigatorKey,
      onGenerateRoute: Router.generateRoute,
//          builder: _setupFlushBarManager,
//      initialRoute: ViewRoutes.StartUp,
      home: HomeView(),
    );
  }
}
