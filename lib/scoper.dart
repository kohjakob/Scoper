/// Minimal state management for Flutter.
///
/// Extend [Scope] for your state, register it with a [ScopeRegistrant],
/// then rebuild widgets with [ScopeBuilder] or run side effects with
/// [ScopeExecutor].
library scoper;

export 'src/extensions.dart';
export 'src/scope.dart';
export 'src/scope_executor.dart';
export 'src/scope_builder.dart';
export 'src/scope_registrant.dart';
