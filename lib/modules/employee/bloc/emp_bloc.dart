import 'dart:async';
import 'package:MyEmployee/modules/employee/models/emp_model.dart';
import 'package:MyEmployee/services/globals.dart';
import 'package:MyEmployee/services/local_db/local_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'emp_event.dart';
part 'emp_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial());

  EmployeeInitial get initialState => EmployeeInitial();
  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    LocalDatabase<EmployeeModel> currentEmpList =
        LocalDatabase(Globals.currentEmployeeList!);
    List<EmployeeModel>? currentEmpListData = await currentEmpList.getData();

    LocalDatabase<EmployeeModel> previousEmpList =
        LocalDatabase(Globals.previousEmployeeList!);
    List<EmployeeModel>? previousEmpListData = await previousEmpList.getData();

    if (event is EmployeeListEvent) {
      try {
        yield EmployeeLoading();
        currentEmpListData.sort((a, b) => a.date2!.compareTo(b.date2!));
        previousEmpListData.sort((a, b) => a.date2!.compareTo(b.date2!));

        yield GetEmployeeSuccess(
            currentEmployees: currentEmpListData,
            previousEmployees: previousEmpListData);
      } catch (e) {
        rethrow;
      }
    }

    if (event is AddEmployeeEvent) {
      try {
        yield EmployeeLoading();

        if (event.listType == 'current_emp') {
          await currentEmpList.addData(EmployeeModel(
              id: event.id,
              name: event.name,
              role: event.role,
              date1: event.date1,
              date2: event.date2));
        } else {
          await previousEmpList.addData(EmployeeModel(
              id: event.id,
              name: event.name,
              role: event.role,
              date1: event.date1,
              date2: event.date2));
        }

        yield EmployeeAddSuccess();
      } catch (e) {
        rethrow;
      }
    }

    if (event is EditEmployeeEvent) {
      try {
        yield EmployeeLoading();

        if (event.listType == 'current_emp') {
          await currentEmpList.putAt(
              event.index!,
              EmployeeModel(
                  name: event.name,
                  role: event.role,
                  date1: event.date1,
                  date2: event.date2));
        } else {
          await previousEmpList.putAt(
              event.index!,
              EmployeeModel(
                  name: event.name,
                  role: event.role,
                  date1: event.date1,
                  date2: event.date2));
        }

        yield EmployeeUpdateSuccess();
      } catch (e) {
        rethrow;
      }
    }

    if (event is DeleteEmployeeEvent) {
      try {
        yield EmployeeLoading();

        if (event.listType == 'current_emp') {
          currentEmpListData.removeAt(event.index!);
          await currentEmpList.deleteAt(event.index!);
        } else {
          previousEmpListData.removeAt(event.index!);
          await previousEmpList.deleteAt(event.index!);
        }

        yield EmployeeDeleteSuccess();
      } catch (e) {
        rethrow;
      }
    }
  }
}
