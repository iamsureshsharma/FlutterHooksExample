import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseRefHook extends HookWidget {
  const UseRefHook({super.key});

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final count = useState(0);
    final textController = useTextEditingController();

    /// useState() this render the every character enter red by user on screen
    // final name = useState('');

    final name = useRef('');

    /// In useEffect(), initalise the variable and dispose
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
