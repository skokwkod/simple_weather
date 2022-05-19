import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState().init());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<WeatherState> init() async {
    return state.clone();
  }
}


//