import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show GlobalKey, NavigatorState;
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:rest_client/core/services/navigation/navigation_service.dart';
import 'package:rest_client/core/utils/extensions.dart';

@LazySingleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  @override
  GlobalKey<NavigatorState> get navigatorKey => Get.key;

  /// Pushes [routeName] onto the navigation stack
  @override
  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return Get.toNamed(routeName, arguments: arguments);
  }

  /// Replaces the current route with the [routeName]
  @override
  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments}) {
    return Get.offNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Pops the current scope and indicates if you can pop again
  @override
  bool pop({dynamic returnValue}) {
    if(returnValue != null){
      Get.back(result: returnValue);
    }else{
      Get.back();
    }
    return navigatorKey.currentState.canPop();
  }

  /// Pops the back stack the number of times you indicate with [popTimes]
  void popRepeated(int popTimes) {
    Get.close(popTimes);
  }

  /// Pops the back stack to a route name
  @override
  void popUntilNamed(String routeName) {
    Get.offNamedUntil(routeName, (_) => false);
  }

  /// Pops the back stack until the predicate is satisfied
  @override
  void popUntilPredicate(RoutePredicate predicate) {
    Get.until(predicate);
  }

  /// Clears the entire back stack and shows [routeName]
  @override
  Future<dynamic> popAllAndPushNamed(String routeName, {dynamic arguments}) {
    return Get.offAllNamed(routeName, arguments: arguments);
  }

  /// Pops the navigation stack until there's 1 view left then pushes [routeName] onto the stack
  @override
  Future<dynamic> popUntilFirstAndPushNamed(String routeName, {dynamic arguments}) {
    _clearBackstackTillFirst();

    return pushNamed(routeName, arguments: arguments);
  }

  /// Push route and clear stack until predicate is satisfied
  @override
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {@required RoutePredicate predicate, arguments, int id}) {
    return Get.offAllNamed(routeName,
        predicate: predicate, arguments: arguments, id: id);
  }

  void _clearBackstackTillFirst() {
    Get.until((Route route) => route.isFirst);
  }
}