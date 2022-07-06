import 'package:clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:clean_architecture/presentation/bloc/weather_event.dart';
import 'package:clean_architecture/presentation/bloc/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Weather',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Enter City Name',
              ),
              onSubmitted: (query) {
                context.read<WeatherBloc>().add(OnCityChanged(query));
              },
            ),
            const SizedBox(height: 24.0),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is WeatherHasData) {
                  return Center(
                      child: Text(
                          'city: ${state.result.cityName} , temperature: ${state.result.temperature}'),);
                } else if (state is WeatherError) {
                  return const Center(child: Text('Something went Wrong!'),);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
