import 'package:clean_architecture/domain/usecases/get_current_weather.dart';
import 'package:clean_architecture/presentation/bloc/weather_event.dart';
import 'package:clean_architecture/presentation/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;

  WeatherBloc(this.getCurrentWeather) : super(WeatherEmpty()) {
    on<OnCityChanged>((event, emit) async {
      final cityName = event.cityName;
      emit(WeatherLoading());
      final result = await getCurrentWeather.execute(cityName);
      result.fold((failure) => emit(WeatherError(failure.message)),
          (success) => emit(WeatherHasData(success)));
    });
  }
}
