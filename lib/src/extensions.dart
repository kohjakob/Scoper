import 'package:flutter/widgets.dart';

import '../scoper.dart';

/// Shortcut for reading a registered scope from a [BuildContext].
extension ExtendedContext on BuildContext {
  /// Returns the scope of type [T] from the nearest [ScopeRegistrant].
  ///
  /// Throws if there is no [ScopeRegistrant] above this context, or if [T]
  /// isn't registered with it.
  T get<T>() {
    return ScopeRegistrant.get<T>(this);
  }
}
