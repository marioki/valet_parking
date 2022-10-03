part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class StartServicesEvent extends HomeEvent {
  const StartServicesEvent();

  @override
  List<Object> get props => [];
}

class HomeAddCar extends HomeEvent {
  final String carPlate;
  final String carOwner;
  final DateTime checkInTime;
  final double rate;

  const HomeAddCar({
    required this.carPlate,
    required this.carOwner,
    required this.checkInTime,
    required this.rate,
  });

  @override
  List<Object> get props => [carPlate, carOwner, checkInTime, rate];
}

class HomeShowCarsEvent extends HomeEvent {
  const HomeShowCarsEvent();

  @override
  List<Object> get props => [];
}

class UpdateCarsListEvent extends HomeEvent {
  const UpdateCarsListEvent();

  @override
  List<Object> get props => [];
}
