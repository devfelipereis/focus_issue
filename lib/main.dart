import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<int> _selectedItem = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: FocusScope(
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: ValueListenableBuilder(
                valueListenable: _selectedItem,
                builder: (context, _, __) {
                  return ListView.separated(
                    itemCount: 20,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return FocusTraversalOrder(
                        order: NumericFocusOrder(index.toDouble()),
                        child: ListTile(
                          title: Text('Item $index'),
                          subtitle: Text('Subtitle $index'),
                          focusColor: Colors.red,
                          selected: _selectedItem.value == index,
                          selectedTileColor: Colors.yellowAccent,
                          autofocus: _selectedItem.value == index,
                          onTap: () {
                            Focus.of(context)
                                .descendants
                                .forEach((element) => element.unfocus());

                            _selectedItem.value = index;
                          },
                        ),
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
}
