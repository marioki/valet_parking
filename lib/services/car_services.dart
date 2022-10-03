import 'package:hive/hive.dart';
import 'package:valet_parking/model/car.dart';

class CarService {
  late Box<Car> _cars;

  Future<void> init() async {
    print('.....INITIALIZING _CARS OBJECT');
    Hive.registerAdapter(CarAdapter());
    _cars = await Hive.openBox<Car>('cars');
    await _cars.clear();
    print('_CARS OBJECT INITIALIZATION SUCCESS');
  }

  List<Car> getAllCars() {
    final cars = _cars.values;
    return cars.toList();
  }

  void addCar(String carPlate, String carOwner, DateTime checkIn) {
    _cars.add(
      Car(
        plateNumber: carPlate,
        owner: carOwner,
        checkInDate: checkIn,
      ),
    );
  }

  Future<void> deleteCar(String carPlate) async {
    final Car carToDelete =
        _cars.values.firstWhere((element) => element.plateNumber == carPlate);
    await carToDelete.delete();
  }

  Future<void> updateCar(String updateCarPlate, String updateOwner,
      {final bool? checkedOut}) async {
    final carToUpdate = _cars.values
        .firstWhere((element) => element.plateNumber == updateCarPlate);
    final index = carToUpdate.key as int;
    await _cars.put(
      index,
      Car(
        plateNumber: updateCarPlate,
        owner: updateOwner,
        checkInDate: carToUpdate.checkInDate,
        isCheckedOut: checkedOut ?? true,
      ),
    );
  }

  Car getCarDetails(int key) {
    final carDetails = _cars.values.elementAt(key);
    return carDetails;
  }

  Future<void> checkOutCar(
    int key,
    DateTime checkOutTime,
    double rate,
    double totalCost,
    int minutesPassed,
  ) async {
    final Car currentDetails = _cars.values.elementAt(key);
    await _cars.put(
      key,
      Car(
          plateNumber: currentDetails.plateNumber,
          owner: currentDetails.owner,
          checkInDate: currentDetails.checkInDate,
          checkOut: checkOutTime,
          isCheckedOut: true,
          rate: rate,
          totalCost: totalCost,
          totalMinutesPassed: minutesPassed),
    );
  }
}
