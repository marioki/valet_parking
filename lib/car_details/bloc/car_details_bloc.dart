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
  }
}
