part of 'emp_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class EmployeeListEvent extends EmployeeEvent {
  @override
  List<Object> get props => [];
}

class AddEmployeeEvent extends EmployeeEvent {
  final String? id;
  final String? name;
  final String? role;
  final String? date1;
  final String? date2;
  final String? listType;

  const AddEmployeeEvent(
      {required this.id,
      required this.name,
      required this.role, //required this.filePath
      required this.date1,
      required this.date2,
      required this.listType});

  @override
  List<Object> get props => [id!, name!, role!, date1!, date2!];
}

class EditEmployeeEvent extends EmployeeEvent {
  final int? index;
  final String? name;
  final String? role;
  final String? date1;
  final String? date2;
  final String? listType;

  const EditEmployeeEvent(
      {required this.index,
      required this.name,
      required this.role, //required this.filePath
      required this.date1,
      required this.date2,
      required this.listType});

  @override
  List<Object> get props => [index!, name!, role!, date1!, date2!];
}

class DeleteEmployeeEvent extends EmployeeEvent {
  final int? index;
  final String? listType;

  const DeleteEmployeeEvent({required this.index, required this.listType});

  @override
  List<Object> get props => [index!, listType!];
}
