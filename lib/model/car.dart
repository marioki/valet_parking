import 'package:hive/hive.dart';

part 'car.g.dart';

@HiveType(typeId: 1)
class Car extends HiveObject {
  @HiveField(0)
  final String plateNumber;
  @HiveField(1)
  final String owner;
  @HiveField(2)
  final DateTime checkInDate;
  @HiveField(3)
  final DateTime? checkOut;
  @HiveField(4)
  final bool isCheckedOut;
  @HiveField(5)
  final double rate;

  Car({
    required this.plateNumber,
    required this.owner,
    required this.checkInDate,
    this.checkOut,
    this.isCheckedOut = false,
    this.rate = 1,
  });
}
