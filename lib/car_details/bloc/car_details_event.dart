part of 'car_details_bloc.dart';

abstract class CarDetailsEvent extends Equatable {
  const CarDetailsEvent();

  @override
  List<Object> get props => [];
}

class ShowCarDetailsEvent extends CarDetailsEvent {
  final int carKey;
  const ShowCarDetailsEvent(this.carKey);

  @override
  List<Object> get props => [carKey];
}

class CarCheckOutEvent extends CarDetailsEvent {
  final int key;
  final Car car;
  const CarCheckOutEvent(this.key, this.car);

  @override
  List<Object> get props => [key];
}
