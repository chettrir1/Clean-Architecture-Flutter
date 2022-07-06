import 'dart:io';

import 'package:clean_architecture/data/datasources/remote_data_source.dart';
import 'package:clean_architecture/data/exception.dart';
import 'package:clean_architecture/data/failure.dart';
import 'package:clean_architecture/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Failed to connect to server'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
