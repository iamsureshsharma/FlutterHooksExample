import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Here we are creating the state
class State {
  final int counter;
  State({this.counter = 0});
}

/// Here we declare the actions
class IncrementAction {
  final int count;
  IncrementAction({this.count = 1});
}

class MyHomePage2 extends HookWidget {
  final State initialState = State();

  /// According to actions and state we do computation here
  State reducer(State state, action) {
    if (action is IncrementAction) {
      return State(counter: state.counter + action.count);
    }
    return state;
  }

  @override
  Widget build(BuildContext context) {
    /// providing the inital state, inital action and reducer to [useReducer)()]
    final store = useReducer(reducer, initialState: initialState, initialAction: IncrementAction(count: 0));
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              /// to get the value from store
              '${store.state.counter}',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /// to update the value, we dispatch the action

        onPressed: () => store.dispatch(IncrementAction(count: 1)),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
