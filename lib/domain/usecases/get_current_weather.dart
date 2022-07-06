import 'package:clean_architecture/data/failure.dart';
import 'package:clean_architecture/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/weather.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
