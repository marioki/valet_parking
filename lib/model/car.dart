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
  @HiveField(6)
  final int? totalMinutesPassed;
  @HiveField(7)
  final double? totalCost;

  Car({
    required this.plateNumber,
    required this.owner,
    required this.checkInDate,
    this.checkOut,
    this.isCheckedOut = false,
    this.rate = 1,
    this.totalMinutesPassed,
    this.totalCost,
  });
}
