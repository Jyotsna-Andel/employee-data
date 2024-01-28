// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:MyEmployee/modules/employee/bloc/emp_bloc.dart';
import 'package:MyEmployee/modules/employee/models/emp_model.dart';
import 'package:MyEmployee/modules/employee/ui/add_emp_details.dart';
import 'package:MyEmployee/services/globals.dart';
import 'package:MyEmployee/services/theme.dart';
import 'package:MyEmployee/widgets/utility.dart';
import 'package:MyEmployee/widgets/appbar.dart';
import 'package:MyEmployee/widgets/loading_widget.dart';
import 'package:MyEmployee/widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyEmployeeListPage extends StatefulWidget {
  const MyEmployeeListPage({super.key});

  @override
  State<MyEmployeeListPage> createState() => _MyEmployeeListPageState();
}

class _MyEmployeeListPageState extends State<MyEmployeeListPage> {
  EmployeeBloc empBloc = EmployeeBloc();
  // EmployeeBloc updateEmpBloc = EmployeeBloc();

  // EmployeeBloc deleteEmpBloc = EmployeeBloc();

  ValueNotifier<bool> updateController = ValueNotifier<bool>(false);
  DateTime? date = DateTime.now();

  @override
  void initState() {
    empBloc.add(EmployeeListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: 'Employee List'),
        body: ValueListenableBuilder(
            builder: (BuildContext context, dynamic value, Widget? child) {
              return blocBuilder();
            },
            valueListenable: updateController,
            child: Container()),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              bool res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEmployeeDetailPage()));

              if (res == true) {
                Utility.showSnackBar(
                    'Employee added successfully', context, 40, 0);

                empBloc.add(EmployeeListEvent());
              }
            },
            child: const Icon(Icons.add),
            tooltip: 'Add Employee',
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))));
  }

  Widget blocBuilder() {
    return BlocConsumer(
        bloc: empBloc,
        builder: (context, state) {
          if (state is GetEmployeeSuccess) {
            // if clips are not available show this widget
            if (state.currentEmployees!.isEmpty &&
                state.previousEmployees!.isEmpty) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const NoDataFoundWidget());
            }

            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      generateEmployeeList(
                          'Current employees', state.currentEmployees!),
                      generateEmployeeList(
                          'Previous employees', state.previousEmployees!)
                    ]));
          } else if (state is EmployeeLoading || state is EmployeeInitial) {
            return const LoadingWidget();
          } else if (state is EmployeeError) {
            Utility.showSnackBar('Something Went Wrong', context, 40, 0);
          }

          return Container();
        },
        listener: (context, state) {
          if (state is GetEmployeeSuccess) {
            setState(() {});
          }
          if (state is EmployeeDeleteSuccess) {
            Utility.showSnackBar(
                'Employee deleted successfully', context, 40, 0);

            empBloc.add(EmployeeListEvent());
          }
          if (state is EmployeeUpdateSuccess) {
            empBloc.add(EmployeeListEvent());
          }
        });
  }

  // Widget blocListener() {
  //   return BlocListener<EmployeeBloc, EmployeeState>(
  //     bloc: empBloc,
  //     child: Container(),
  //     listener: (BuildContext contxt, EmployeeState state) {
  //       if (state is GetEmployeeSuccess) {
  //         setState(() {});
  //       }
  //       if (state is EmployeeDeleteSuccess) {
  //         Utility.showSnackBar('Employee deleted successfully', context, 40);

  //         empBloc.add(EmployeeListEvent());
  //       }
  //       if (state is EmployeeUpdateSuccess) {
  //         empBloc.add(EmployeeListEvent());
  //       }
  //     },
  //   );
  // }

  Widget generateEmployeeList(String? pinnedTitle, List<EmployeeModel> items) {
    return SizedBox(
        height: items.isEmpty
            ? 0
            : items.length == 1
                ? MediaQuery.of(context).size.height * 0.15
                : items.length == 2
                    ? MediaQuery.of(context).size.height * 0.25
                    : items.length == 3
                        ? MediaQuery.of(context).size.height * 0.33
                        : MediaQuery.of(context).size.height * 0.4,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  height: 55,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.withOpacity(0.1),
                  child: Text(pinnedTitle!,
                      style: AppTheme.appTheme.textTheme.titleMedium!
                          .copyWith(color: AppTheme.kButtonColorDark))),
              listViewBuilder(items)
            ]));
  }

  Widget listViewBuilder(items) {
    return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Slidable(
                        // Specify a key if the Slidable is dismissible.
                        key: ValueKey(index),

                        // The end action pane is the one at the right or the bottom side.
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                              onPressed: (context) async {
                                DateTime date2DateTime =
                                    Utility.parseDate(items[index].date2);

                                bool result =
                                    await Utility.showAlertDialog(context);
                                if (result) {
                                  empBloc.add(DeleteEmployeeEvent(
                                      listType: date2DateTime.isAfter(date!)
                                          ? 'current_emp'
                                          : 'previous_emp',
                                      index: index));
                                }
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: const IconData(0xe801,
                                  fontFamily: 'MyEmployeeApp',
                                  fontPackage: Globals.kFontPkg),
                              label: 'Delete')
                        ]),
                        child: listTile(items, index)),
                    items.length - 1 == index ? Container() : const Divider()
                  ]);
            }));
  }

  Widget listTile(items, index) {
    return ListTile(
        onTap: () async {
          bool res = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEmployeeDetailPage(
                      employeeIndex: index, empData: items[index])));

          if (res == true) {
            Utility.showSnackBar(
                'Employee updated successfully', context, 40, 0);

            empBloc.add(EmployeeListEvent());
          }
        },
        title: Text(items[index].name,
            style: AppTheme.appTheme.textTheme.titleMedium!),
        subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(items[index].role,
                  style: AppTheme.appTheme.textTheme.bodySmall),
              Text('From ${items[index].date1}',
                  style: AppTheme.appTheme.textTheme.bodySmall)
            ]));
  }
}
