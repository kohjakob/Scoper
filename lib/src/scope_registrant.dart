import 'package:flutter/widgets.dart';
import '../scoper.dart';

/// Makes scopes available to every widget below it.
///
/// Place it near the root of the widget tree. Scopes are stored by their
/// runtime type, so register one instance per type.
class ScopeRegistrant extends InheritedWidget {
  /// The registered scopes, keyed by runtime type.
  final Map<Type, Scope> map = {};

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  /// Registers [scopes] for [child] and every widget below it.
  ScopeRegistrant({
    required Widget child,
    List<Scope>? scopes,
    Key? key,
  }) : super(child: child, key: key) {
    scopes?.forEach((Scope scope) {
      map[scope.runtimeType] = scope;
    });
  }

  /// Returns the nearest [ScopeRegistrant] above [context], or null.
  static ScopeRegistrant? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScopeRegistrant>();

  /// Returns the scope of type [T] from the nearest [ScopeRegistrant] above
  /// [context].
  ///
  /// Throws if there is no registrant, or if [T] isn't registered with it.
  static T get<T>(BuildContext context) {
    ScopeRegistrant? registrant = of(context);
    if (registrant != null) {
      dynamic instance = registrant.map[T];
      if (instance != null && instance != Null) {
        return instance as T;
      } else {
        throw Exception(
            "The Scope S you are trying to build with ScopeBuilder<S>() isn't registered with the ScopeRegistrant.");
      }
    } else {
      throw Exception(
          "There is no ScopeRegistrant above your ScopeBuilder<S> in the widget tree");
    }
  }
}
