
// ignore_for_file: avoid_print
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/my_data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());

      try {
        WeatherFactory wf = WeatherFactory(
          API_KEY,
          language: Language.ENGLISH,
        );
        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
              // Determine colors based on the weather code
        Color color1 = setFirstColor(weather.weatherConditionCode!);
        Color color2 = setSecondColor(weather.weatherConditionCode!);
            print(weather);
        emit(WeatherBlocSuccess(weather,color1,color2));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}

  Color setFirstColor(int weatherCode) {
    switch (weatherCode) {
      case >= 200 && < 300:
        return Colors.amber;
      case >= 300 && < 400:
        return const Color.fromARGB(255, 104, 145, 216);
      case >= 500 && < 600:
        return const Color.fromARGB(255, 104, 145, 216);
      case >= 600 && < 700:
        return const Color.fromARGB(255, 3, 49, 148);
      case >= 700 && < 800:
        return const Color.fromARGB(255, 124, 143, 175);
      case == 800:
        return Colors.deepOrange;
      case > 800 && <= 804:
        return Color.fromARGB(255, 8, 129, 123);
      default:
        return Colors.deepOrange;
    }
  }

  Color setSecondColor(int weatherCode) {
    switch (weatherCode) {
      case >= 200 && < 300:
        return const Color.fromARGB(255, 104, 145, 216);
      case >= 300 && < 400:
        return const Color.fromARGB(255, 104, 145, 216);
      case >= 500 && < 600:
        return const Color.fromARGB(255, 104, 145, 216);
      case >= 600 && < 700:
        return const Color.fromARGB(255, 30, 154, 211);
      case >= 700 && < 800:
        return const Color.fromARGB(255, 71, 83, 104);
      case == 800:
        return Colors.deepOrange;
      case > 800 && <= 804:
        return Colors.amber;
      default:
        return Colors.deepOrange;
    }
  }
