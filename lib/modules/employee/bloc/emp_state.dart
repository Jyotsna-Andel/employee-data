part of 'emp_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeLoading extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeError extends EmployeeState {
  final err;
  const EmployeeError({this.err});
  EmployeeError copyWith({final err}) {
    return EmployeeError(err: err ?? this.err);
  }

  @override
  List<Object> get props => [err];
}

class GetEmployeeSuccess extends EmployeeState {
  final List<EmployeeModel>? currentEmployees;
  final List<EmployeeModel>? previousEmployees;

  const GetEmployeeSuccess({this.currentEmployees, this.previousEmployees});
  GetEmployeeSuccess copyWith({
    final currentEmployees,
    final previousEmployees,
  }) {
    return GetEmployeeSuccess(
        currentEmployees: currentEmployees ?? this.currentEmployees,
        previousEmployees: previousEmployees ?? this.previousEmployees);
  }

  @override
  List<Object> get props => [];
}

class EmployeeAddSuccess extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeUpdateSuccess extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeDeleteSuccess extends EmployeeState {
  @override
  List<Object> get props => [];
}
