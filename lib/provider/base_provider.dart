import 'package:flutter/material.dart';

class BaseChangeNotifierProvider extends ChangeNotifier {
  bool _disposed = false;
  bool get isDisposed => _disposed;
  final Map<int, bool> _busyStates = {};
  final Map<int, dynamic> _errorStates = {};

  BaseChangeNotifierProvider() {
    init();
  }

  void init() {}

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  bool busy() => _busyStates[hashCode] ?? false;
  bool busyForObject(Object? object) => _busyStates[object.hashCode] ?? false;

  dynamic error() => _errorStates[hashCode];
  dynamic errorForObject(Object? object) => _errorStates[object.hashCode];

  void setBusy(bool value) {
    _busyStates[hashCode] = value;
    notifyListeners();
  }

  void setError(dynamic value) {
    _errorStates[hashCode] = value;
    notifyListeners();
  }

  void setBusyForObject(Object? object, bool value) {
    _busyStates[object.hashCode] = value;
    notifyListeners();
  }

  void setErrorForObject(Object? object, dynamic value, [bool listen = true]) {
    _errorStates[object.hashCode] = value;
    if (listen) {
      notifyListeners();
    }
  }
}
