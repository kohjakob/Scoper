import 'package:flutter/foundation.dart';

import 'scope_builder.dart';
import 'scope_executor.dart';

/// Base class for a piece of app state.
///
/// Extend it, keep your fields private, and call [notifyBuilders] or
/// [notifyExecutors] after changing them.
abstract class Scope extends ChangeNotifier {
  /// Notifies every [ScopeBuilder] listening to this scope.
  final ChangeNotifier builderNotifier = ChangeNotifier();

  /// Notifies every [ScopeExecutor] listening to this scope.
  final ChangeNotifier executorNotifier = ChangeNotifier();

  /// Rebuilds every [ScopeBuilder] of this scope.
  void notifyBuilders() => this.builderNotifier.notifyListeners();

  /// Runs the executor of every [ScopeExecutor] of this scope.
  void notifyExecutors() => this.executorNotifier.notifyListeners();
}
