# Overview of Flutter Hooks

Whenever anyone pronounce `Flutter`, widgets starts poping in our mind.

## *What are the widgets and types*?

In flutter we've two types of widget
 
1. Stateless Widgets
2. Stateful Widgets

Widget is basically building block of UI flutter.

Almost all types of widgets are precooked and ready to use in the framework.

> Thats all, for the introduction part 😄
>

# Flutter Hooks

## What is Flutter Hooks and Why we need Hooks?

- Flutter Hooks are majorly inspired by **react** Library

-  Hooks are a new kind of *object* that manage the *life-cycle* of a **Widget**. They exist for one reason: increase the *code-sharing* between widgets by removing duplicates.

> This is self explanatory line written in [flutter_hooks](https://pub.dev/packages/flutter_hooks) package



Let's Understand this with Example 

Taking the common example of using the `Animation Controller`

To use the animation controller in UI
we've to first create the variable and then initialise  `Animation Controller` in
`initState()`.


 then listen for update in `didUpdateWidget()`

 and then dispose the controller in the dispose in the `dispose()`

``` dart
   AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void didUpdateWidget(Example oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller!.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
```

All these line of code is to implment the one animation controller

## What if i have to add two more Animation controller ?

We've to repeat the same code with different name 😢

If i replace all these line of code with one line of code 🤩

Yes, this is the beauty of `Flutter Hooks`

``` dart
final controller = useAnimationController(duration: duration)
```

Only this line, inside the build() will work same

In previous code all the **life-cycle** of widget, we've to manage 

In flutter hooks all these implementation logic is managed by flutter hook itself
So, we can add only single line to add the new ```Animation Controller```

```dart
final controller1 = useAnimationController();
final controller2 = useAnimationController();
```

## Properties of Flutter Hooks

- Hooks are used inside the `build()` method 
- Hooks are totally independent of each other & independent of widgets
- Similar to State, Hooks are store in the element of widget 
- Widget store ```List<Hooks>```, unlike the single state
- ```Hook.use()``` return the Hooks sequentialy
- We can create our own hook by extending the ```HookWidget``` and add the implementation
- On creating the new hook, one should use the ```use``` prefix
- Hooks shouldn't be called inside the conditional statement 

  ```dart
  hook1();
  hook2();
  hook3();
  ```

- In the above hooks if i remove the the ```hook2``` then ```hook3``` state will be disposed
- Because Hooks are store in the list, becacuse it has to do the reindexing to all the hooks


 ### List of PreCooked Hooks 

 1. useState()
 2. useEffect()
 3. useMemoized()
 4. useRef()
 5. useCallback()
 6. useContext()
 7. useValueChanged()
    
   These are some basic hooks, we will look inside each, one by one

   ## 1. useState()

   - This ```useState()``` is a value notifier Provider
   - This method creates, subscribe & listen to the changes
   - We can use this for simple data types
  
  ``` dart
  class HookExample extends HookWidget {
    const HookExample({super.key});

  @override
  Widget build(BuildContext context) {
    /// Creating the useState() for simple data type
    final count = useState(0);
    
    // Statements
    .
    .
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       Center(
        /// will get re-rendered whenever value changes
      child: Text('${count.value}'),
    ),
        /// on click value get incremented
       FloatingActionButton(
            onPressed: () {
              count.value ++;
            },
            child: const Icon(Icons.add)),
      ],
    )
    Center(
      child: Text('${count.value}'),
    );
    }
}
```

## 2. useEffect()

-  In this method we can do the initialisation and dispose
-  This method is called synchronously on every ```build```, unless ```[keys]``` is specified. In which case [useEffect] is called again only if any value inside [keys] as changed.
  
  ```dart
   useEffect(() {
    /// side effects code here.
    ///  Unsubscribing from a stream.
    ///  Cancelling polling
    ///  Clearing timeouts
    ///  Cancelling active HTTP connections.
    ///  Cancelling WebSockets conncetions.
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        counter.value = timer.tick;
      });

      /// we can dispose the stream here, we are subscibed to
      return timer.cancel;
    }, []);
  ```

This is a simple implemntation of useEffect(), using ```Timer``` 

## 3. useMemoized()

- This method basically caches the complex instances 
- Calculates the function for first time and store it, whenever this method recalled, it return the previous saved value
- This may change the value, when the dependencies change

``` dart
class MemoizedHook extends HookWidget {
  const MemoizedHook({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    count.value++;
    Future<String> getData() async {
      await Future.delayed(const Duration(seconds: 1));
      return "i'm the output";
    }

    /// this will keep rebuilding the widget by calling the [getData]
    /// if we make the key list empty, it will not use the
    
    final futureData = useMemoized(getData, [count.value]);

    /// Here useFuture() subscribe to the future and return its current state


    final snapshot = useFuture(futureData);
    return Center(
      child: snapshot.hasData ? Text('${snapshot.data} ${count.value}') : const CircularProgressIndicator(),
    );
  }
}
```

> Here ```useFuture``` is used to subscribe to the future and return its current state 
> 
> And implementation of ```useStream``` hook also is same as ```useFuture```

## 4. useRef()

- An object that contain single mutable properties
- Will not re-render the changes with every value change
- useRef() will remember the data
  
```dart
Widget build(BuildContext context) {
    /// using the focus node hook
    final focusNode = useFocusNode();
    /// using the TextEditingController hook
    final textController = useTextEditingController();

    /// useState() this render the every character entered by user on screen

    // final name = useState('');

    final name = useRef('');

    useEffect(() {
      textController.addListener(() {
        name.value = textController.text;
      });
    }, []);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          focusNode: focusNode,
          controller: textController,
          decoration: const InputDecoration(hintText:'name'),
        ),
        sizedBox(),
        Text(name.value),
      ],
    );
  }
```

 ```useState()```  can store the value, and rerenders whenever any changes happens

```useRef()```, only store the value, it don't make available to render to screen

> In the above code, we've seen the ```useFocusNode``` and ```useTextEditingController``` hooks,
> which pretty simple to use
> we just have to use the single line code to initialise and dispose


## 5. useCallback()

- This hook mainly used, when we've to do the caching of object
- This hook cache the entire function, if same method is called again
- It maintains the state, rather than recreating it
- It caches the whole function and process it 
- It will change the value, when the dependecies mentioned in ```[keys]``` changes, and return the new output

```dart
final cachedFun = useCallback((){
    Statements
}
[keys]);
```

## 6. useContext()

- This hook is very simple to use, whenever we need the ```context```, we can use this hook
- Using this hook we can avoid passing the context
  
``` dart
class UseContextHook extends HookWidget {
  const UseContextHook({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          decoration: const InputDecoration(hintText: 'your name'),
        ),
        sizedBox(),
        Text(name.value),
      ],
    );
  }

  /// This is outside the build method, this method don't have the access of context
  /// Here we can use the useContext() directly in place of context
  SizedBox sizedBox() => SizedBox(height: MediaQuery.of(useContext()).size.height * 0.2);
}

```

## 7. useValueChanged()

- This is a value notifier hook
- If there is change in any other value Notifier, based on that, if we want to perform some other action then this hok

``` dart
final count = useState(0);
final newCount = useState(5);
useValueChange(count.value,(oldValue, oldResult){
    print('$oldValue ---- $oldResult');
}
return newCount.value = newCount.value + 5;
);
```

if we run the above code with this code snippet, the output will look like this
```
0 --- null 
1 --- 5
2 --- 10
```

## 8. useReducer()

- This hook is almost similar to ```useState()```
- This hook is used for the complex data type
- Complex data means, if we have to update the Value according to the state

``` dart
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

class UseReducer extends HookWidget {
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
    /// providing the inital state, inital action and reducer to [useReducer()]
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

```

In above code we've implemented the counter app, using the ```useReducer``` hook 
here we have the ```State``` and ```Action```, based on that state and action, ```reducer()``` function returns the new state

We can trigger the update using ```dispatch()``` 

And to listen the new value we'll look for variable in ```State```

### Yeah ! this is quit long article, i've tried to cover most of the hooks which is very important

So, that's all for this article. I hope this helped you to understand the Flutter Hooks. If I'm left with something crucial, please let me know in the comment section.


Feel free to connect with me on [twitter](https://mobile.twitter.com/iamsureshsharma) and [github](https://github.com/iamsureshsharma)

