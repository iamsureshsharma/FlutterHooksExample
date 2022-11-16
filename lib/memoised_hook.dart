import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MemoisedHook extends HookWidget {
  const MemoisedHook({super.key});

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
    final ref = useRef(2);
    final snapshot = useFuture(futureData);
    return Center(
      child: snapshot.hasData ? Text('${snapshot.data} ${count.value}') : const CircularProgressIndicator(),
    );
  }
}
