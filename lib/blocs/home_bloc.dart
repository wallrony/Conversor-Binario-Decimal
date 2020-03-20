import 'dart:async';

class HomeBloc {
  final _streamResult = StreamController<String>();
  final _streamSwitch = StreamController<bool>();

  get resultStream => _streamResult.stream;
  get switchStream => _streamSwitch.stream;
  set setResultStream(value) => _streamResult.add(value);
  set setSwitchStream(value) => _streamSwitch.add(value);

  dispose() {
    _streamResult.close();
    _streamSwitch.close();
  }
}