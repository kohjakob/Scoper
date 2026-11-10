import 'package:flutter/widgets.dart';
import '../scoper.dart';

/// Builds a widget from the current state of [scope].
typedef ScopeBuilderFunction<S> = Widget Function(
  BuildContext context,
  S scope,
);

/// Calls [builder] again whenever the scope of type [S] calls
/// [Scope.notifyBuilders].
class ScopeBuilder<S extends Scope> extends StatefulWidget {
  @override
  _ScopeBuilderState<S> createState() => _ScopeBuilderState<S>(builder);

  /// Called on every rebuild with the current scope.
  final ScopeBuilderFunction<S> builder;

  /// Creates a widget that rebuilds with the registered scope of type [S].
  ScopeBuilder({
    required this.builder,
  });
}

class _ScopeBuilderState<S extends Scope> extends State<ScopeBuilder<S>> {
  late S scope;
  ScopeBuilderFunction<S> builder;
  bool listening = false;

  _ScopeBuilderState(this.builder);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!listening) {
      final scope = this.context.get<S>();
      scope.builderNotifier.addListener(() {
        setState(() {});
      });
      setState(() {
        this.listening = true;
        this.scope = scope;
      });
    }
  }

  @override
  void didUpdateWidget(covariant ScopeBuilder<S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.builder != widget.builder) {
      setState(() {
        this.builder = this.widget.builder;
        this.listening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.builder(context, scope);
  }
}
