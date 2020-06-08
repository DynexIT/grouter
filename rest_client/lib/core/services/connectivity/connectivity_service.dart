import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:rest_client/core/enums/connectivity_status.dart';
import 'package:rest_client/core/utils/logger.dart';

import '../stoppable_service.dart';

@lazySingleton
class ConnectivityService implements StoppableService {
  final _connectivityResultController = StreamController<ConnectivityStatus>();
  final _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityResult _lastResult;
  bool _serviceStopped = false;

  Stream<ConnectivityStatus> get connectivity$ =>
      _connectivityResultController.stream;

  bool get serviceStopped => _serviceStopped;

  ConnectivityService() {
    _subscription =
        _connectivity.onConnectivityChanged.listen(_emitConnectivity);
  }

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();

    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
      default:
        return false;
    }
  }

  @override
  void start() async {
    Logger.d('ConnectivityService resumed');
    _serviceStopped = false;

    await _resumeSignal();
    _subscription.resume();
  }

  @override
  void stop() {
    Logger.d('ConnectivityService paused');
    _serviceStopped = true;

    _subscription.pause(_resumeSignal());
  }

  void _emitConnectivity(ConnectivityResult event) {
    if (event == _lastResult) return;

    Logger.d('Connectivity status changed to $event');
    _connectivityResultController.add(_convertResult(event));
    _lastResult = event;
  }

  ConnectivityStatus _convertResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  Future<void> _resumeSignal() async => true;
}