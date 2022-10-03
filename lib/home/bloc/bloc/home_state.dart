part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeShowCarsState extends HomeState {
  final List<Car> cars;
  const HomeShowCarsState(this.cars);

  @override
  List<Object> get props => [cars];
}
