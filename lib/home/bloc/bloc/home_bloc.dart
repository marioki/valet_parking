import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valet_parking/model/car.dart';
import 'package:valet_parking/services/car_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CarService _carService;

  HomeBloc(this._carService) : super(HomeInitial()) {
    on<StartServicesEvent>((event, emit) async {
      await _carService.init();
      final cars = _carService.getAllCars();
      emit(HomeShowCarsState(cars));
    });

    on<HomeAddCar>((event, emit) {
      print(event);
      _carService.addCar(event.carPlate, event.carOwner, event.checkInTime);
      print('Car List Length: ${_carService.getAllCars()}');
    });

    on<UpdateCarsListEvent>((event, emit) {
      final cars = _carService.getAllCars();
      emit(HomeShowCarsState(cars));
    });
  }
}
