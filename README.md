# Scoper

A small state management package for Flutter. Scopes hold your state, and widgets rebuild when a scope tells them to. The package is in `lib/`, and `example/` has a small counter app that uses it.

On [pub.dev](https://pub.dev/packages/scoper).

## Requirements

- Flutter 3.47.7 (Dart 3.13.5)
- Google Chrome, for the example app

## Setup

```bash
make setup
```

## Run

```bash
make run
```

Opens the example app in Chrome.

## Deploy

**Where it runs:** pub.dev, package `scoper`.

**Needs:** The pub.dev account that owns the package.

Raise `version` in `pubspec.yaml`, add a line to `CHANGELOG.md`, then:

```bash
dart pub publish
```

## Usage

Create custom `ExampleScope` by extending `Scope`.
Use `notifiyBuilders()` to trigger rebuild of `ScopeBuilder<ExampleScope>`.
Use `notifiyExecutors()` to trigger execution of `ScopeExecutor<ExampleScope>`.

```
class CounterScope extends Scope {
  int _counter = 0;
  int _divider = 7;

  increment() {
    _counter++;
    notifiyBuilders();

    if(_counter % _divider == 0) {
      notifiyExecutors();
    }
  }

  get counter => _counter;
  get divider => _divider;
}
```

Register your scopes by passing them to a `ScopeRegistrant` at the root of the widget-tree.

```
ScopeRegistrant(
    scopes: [
        CounterScope(),
        ExampleScope(),
    ],
    child: Container(
      child: (...)
    ),
)
```

Use a `ScopeBuilder<ExampleScope>` to build widgets depending on the given scope.

```
ScopeBuilder<CounterScope>(
    builder: (context, scope) {
        return Text(scope.counter.toString());
    },
),
```

Use a `ScopeExecutor<ExampleScope>` to execute certain logic depending on the given scope.

```
ScopeExecutor<CounterScope>(
    executor: (context, scope) {
      final message = "This number is divisible by " + scope.divider.toString();
      final snackbar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    },
    child: Container(
      child: (...)
    ),
)
```

Use `get<ExampleScope>` to get a scope from `context` and call its methods (for example in onPressed).

```
context.get<CounterScope>().increment(),
```
