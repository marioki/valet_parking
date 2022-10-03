import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:valet_parking/model/car.dart';
import 'package:valet_parking/services/car_services.dart';

part 'car_details_event.dart';
part 'car_details_state.dart';

class CarDetailsBloc extends Bloc<CarDetailsEvent, CarDetailsState> {
  final CarService _carService;

  CarDetailsBloc(this._carService) : super(CarDetailsInitial()) {
    on<ShowCarDetailsEvent>((event, emit) {
      final carDetails = _carService.getCarDetails(event.carKey);
      emit(LoadCarDetailsState(carDetails));
    });

    on<CarCheckOutEvent>((event, emit) async {
      DateTime checkOutTime = DateTime.now();
      final double costPerSecond = getCostPerSecond(event.car.rate);
      final int secondsPassed =
          getSecondsPassed(event.car.checkInDate, checkOutTime);
      final double totalCost = getTotalCost(secondsPassed, costPerSecond);

      await _carService.checkOutCar(event.key, checkOutTime, event.car.rate,
          totalCost, (secondsPassed / 60).toInt());
      final carDetails = _carService.getCarDetails(event.key);
      emit(LoadCarDetailsState(carDetails));
      print(event);
    });
  }

  double getCostPerSecond(double rate) {
    final costPerSecond = rate / 3600;
    return costPerSecond;
  }

  double getTotalCost(int secondsPassed, double costPerSecond) {
    final totalCost = secondsPassed * costPerSecond;
    return totalCost;
  }

  int getSecondsPassed(DateTime checkInTime, DateTime checkOutTime) {
    final secondsPassed = checkOutTime.difference(checkInTime).inSeconds;
    return secondsPassed;
  }
}
