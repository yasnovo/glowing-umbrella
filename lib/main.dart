import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

void main() {
  final CountBloc countBloc = new CountBloc();
  runApp(new MyApp(countBloc));
}

class MyApp extends StatelessWidget {
  final CountBloc countBloc;

  MyApp(this.countBloc);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CountProvider(
      countBloc: countBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countBloc = CountProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Count Bloc'),
      ),
      body: CountText(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          countBloc.countAddition.add(1);
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}

class CountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countBloc = CountProvider.of(context);
    return StreamBuilder<int>(
      stream: countBloc.onPressCountNum,
      builder: ((context, snapshot) {
        return new Column(children: <Widget>[
          new Text(snapshot.data.toString()),
        ]);
      }),
    );
  }
}

class CountBloc {
  int count;

  //
  final _onPressCountNum = BehaviorSubject<int>(seedValue: 10);

  Stream<int> get onPressCountNum => _onPressCountNum.stream;

  final _countController = StreamController<int>();

  CountBloc() {
    _countController.stream.listen(_handleAddition);
  }

  Sink<int> get countAddition => _countController.sink;

  void _handleAddition(int event) {
    print('_handleAddition event is:$event');

    _onPressCountNum.add(event);
  }
}

class CountProvider extends InheritedWidget {
  final CountBloc countBloc;

  CountProvider({
    Key key,
    CountBloc countBloc,
    Widget child,
  })  : countBloc = countBloc ?? CountBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static CountBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CountProvider)
            as CountProvider)
        .countBloc;
  }
}
