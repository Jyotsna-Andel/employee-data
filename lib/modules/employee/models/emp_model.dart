import 'package:hive/hive.dart';
part 'emp_model.g.dart';

@HiveType(typeId: 1)
class EmployeeModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final name;
  @HiveField(2)
  final role;
  @HiveField(3)
  final date1;
  @HiveField(4)
  String? date2 = '';

  EmployeeModel({this.id, this.name, this.role, this.date1, this.date2});
}
