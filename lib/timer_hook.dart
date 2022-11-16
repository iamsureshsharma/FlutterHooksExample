import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HookExample extends HookWidget {
  const HookExample({super.key});

  @override
  Widget build(BuildContext context) {
    /// this is how we can create the variable and initialise it (for simple data type)
    final counter = useState(0);

    /// in this method we can intialise the variable, and dispose it
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        counter.value = timer.tick;
      });

      /// we can dispose the stream here, we are subscibed to
      return timer.cancel;
    }, []);
    return Center(
      child: Text(
        '${counter.value}',
        style: const TextStyle(fontSize: 40),
      ),
    );
  }
}
