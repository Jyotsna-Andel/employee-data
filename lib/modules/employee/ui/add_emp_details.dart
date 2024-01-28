import 'package:MyEmployee/modules/employee/bloc/emp_bloc.dart';
import 'package:MyEmployee/modules/employee/models/emp_model.dart';
import 'package:MyEmployee/services/theme.dart';
import 'package:MyEmployee/widgets/appbar.dart';
import 'package:MyEmployee/widgets/button_widget.dart';
import 'package:MyEmployee/widgets/icon_widget.dart';
import 'package:MyEmployee/widgets/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

class AddEmployeeDetailPage extends StatefulWidget {
  final EmployeeModel? empData;
  final int? employeeIndex;

  const AddEmployeeDetailPage({super.key, this.empData, this.employeeIndex});

  @override
  State<AddEmployeeDetailPage> createState() => _AddEmployeeDetailPageState();
}

class _AddEmployeeDetailPageState extends State<AddEmployeeDetailPage> {
  EmployeeBloc empBloc = EmployeeBloc();
  TextEditingController nameController = TextEditingController(text: '');

  ValueNotifier<String> nameChangeController = ValueNotifier<String>('');
  ValueNotifier<String> roleChangeController = ValueNotifier<String>('');
  ValueNotifier<String> date1ChangeController = ValueNotifier<String>('');
  ValueNotifier<String> date2ChangeController = ValueNotifier<String>('');
  ValueNotifier<bool> loadingController = ValueNotifier<bool>(false);
  ValueNotifier<bool> errorController = ValueNotifier<bool>(false);

  final List<String> _roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];

  @override
  void initState() {
    editDataUpdate();
    super.initState();
  }

  editDataUpdate() {
    if (widget.empData != null) {
      nameChangeController.value = widget.empData!.name!;
      nameController.text = widget.empData!.name!;

      roleChangeController.value = widget.empData!.role!;
      date1ChangeController.value = widget.empData!.date1!;
      date2ChangeController.value = widget.empData!.date2!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: 'Add Employee Details'),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    return Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(children: <Widget>[
                          addEmployeeName(),
                          const SizedBox(height: 16),
                          selectEmpRole(),
                          const SizedBox(height: 16),
                          selectDate()
                        ]));
                  },
                  valueListenable: errorController,
                  child: Container()),
              blocListener(),
              Column(children: [
                const Divider(),
                Container(
                    padding:
                        const EdgeInsets.only(bottom: 20, right: 20, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonWidget(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              label: 'Cancel',
                              color: AppTheme.kButtonColorLight,
                              labelColor: AppTheme.kButtonColorDark),
                          const SizedBox(width: 16),
                          ButtonWidget(
                              onPressed: () {
                                if (nameController.text.isEmpty ||
                                    roleChangeController.value.isEmpty ||
                                    date1ChangeController.value.isEmpty ||
                                    date2ChangeController.value.isEmpty) {
                                  errorController.value = true;

                                  Utility.showSnackBar(
                                      'Please fill all details to continue',
                                      context,
                                      40,
                                      50);
                                } else {
                                  DateTime? date = DateTime.now();
                                  DateTime date1DateTime = Utility.parseDate(
                                      date1ChangeController.value);
                                  DateTime date2DateTime = Utility.parseDate(
                                      date2ChangeController.value);

                                  if (widget.empData != null) {
                                    empBloc.add(EditEmployeeEvent(
                                        index: widget.employeeIndex,
                                        name: nameController.text,
                                        role: roleChangeController.value,
                                        date1: date1ChangeController.value,
                                        date2: date2ChangeController.value,
                                        listType: date2DateTime.isAfter(date)
                                            ? 'current_emp'
                                            : 'previous_emp'));
                                  } else if (date1DateTime
                                          .isAfter(date2DateTime) ||
                                      date1DateTime
                                          .isAtSameMomentAs(date2DateTime)) {
                                    Utility.showSnackBar(
                                        'End date should be greater than Start date',
                                        context,
                                        40,
                                        50);
                                  } else {
                                    empBloc.add(AddEmployeeEvent(
                                        id: Utility.uuid(),
                                        name: nameController.text,
                                        role: roleChangeController.value,
                                        date1: date1ChangeController.value,
                                        date2: date2ChangeController.value,
                                        listType: date2DateTime.isAfter(date)
                                            ? 'current_emp'
                                            : 'previous_emp'));
                                  }
                                }
                              },
                              label: 'Save',
                              color: AppTheme.kButtonColorDark,
                              labelColor: Colors.white)
                        ]))
              ]),
            ]));
  }

  blocListener() {
    return BlocListener<EmployeeBloc, EmployeeState>(
        bloc: empBloc,
        listener: (context, state) async {
          if (state is EmployeeAddSuccess || state is EmployeeUpdateSuccess) {
            Navigator.of(context).pop(true);
          } else if (state is EmployeeLoading || state is EmployeeInitial) {
            loadingController.value = true;
          } else if (state is EmployeeError) {
            Utility.showSnackBar('Something Went Wrong', context, 40, 40);
          }
        },
        child: Container());
  }

  Widget addEmployeeName() {
    return ValueListenableBuilder(
        builder: (BuildContext context, dynamic value, Widget? child) {
          return SizedBox(
              height: 50,
              child: TextField(
                  controller: nameController,
                  style: AppTheme.appTheme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: nameChangeController.value.isEmpty &&
                                    errorController.value == true
                                ? Colors.red
                                : Colors.grey,
                            width: 1),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const IconWidget(iconCode: 0xe803),
                      border: const OutlineInputBorder(),
                      hintStyle:
                          AppTheme.appTheme.inputDecorationTheme.hintStyle,
                      hintText: 'Employee name')));
        },
        valueListenable: nameChangeController,
        child: Container());
  }

  Widget selectEmpRole() {
    return ValueListenableBuilder(
        builder: (BuildContext context, dynamic value, Widget? child) {
          return GestureDetector(
              onTap: () {
                selectEmpRoleShowModal(context);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: roleChangeController.value.isEmpty &&
                                  errorController.value == true
                              ? Colors.red
                              : Colors.grey)),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const IconWidget(iconCode: 0xe807),
                          Text(
                              roleChangeController.value.isEmpty
                                  ? 'Select role'
                                  : roleChangeController.value,
                              style: roleChangeController.value.isNotEmpty
                                  ? AppTheme.appTheme.textTheme.bodyLarge
                                  : AppTheme.appTheme.textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey))
                        ]),
                        const IconWidget(iconCode: 0xe808)
                      ])));
        },
        valueListenable: roleChangeController,
        child: Container());
  }

  void selectEmpRoleShowModal(context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.26,
              alignment: Alignment.center,
              child: ListView.separated(
                  itemCount: _roles.length,
                  separatorBuilder: (context, int) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_roles[index],
                                style: AppTheme.appTheme.textTheme.bodyLarge,
                                textAlign: TextAlign.center)),
                        onTap: () {
                          roleChangeController.value = _roles[index];
                          Navigator.of(context).pop();
                        });
                  }));
        });
  }

  Widget selectDate() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      ValueListenableBuilder(
          builder: (BuildContext context, dynamic value, Widget? child) {
            return GestureDetector(
                onTap: () async {
                  DateTime? date1 = await Utility.showDatePicker(context);
                  if (date1 != null) {
                    String formattedDate =
                        DateFormat('dd MMM yyyy').format(date1);
                    date1ChangeController.value = formattedDate;
                  }
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: date1ChangeController.value.isEmpty &&
                                    errorController.value == true
                                ? Colors.red
                                : Colors.grey)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const IconWidget(iconCode: 0xe802),
                      Text(
                          date1ChangeController.value.isEmpty
                              ? 'No date'
                              : date1ChangeController.value,
                          style: date1ChangeController.value.isNotEmpty
                              ? AppTheme.appTheme.textTheme.bodyLarge
                              : AppTheme.appTheme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.grey))
                    ])));
          },
          valueListenable: date1ChangeController,
          child: Container()),
      const IconWidget(iconCode: 0xe800),
      ValueListenableBuilder(
          builder: (BuildContext context, dynamic value, Widget? child) {
            return GestureDetector(
                onTap: () async {
                  DateTime? date2 = await Utility.showDatePicker(context);
                  if (date2 != null) {
                    String formattedDate =
                        DateFormat('dd MMM yyyy').format(date2);
                    date2ChangeController.value = formattedDate;
                  }
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: date2ChangeController.value.isEmpty &&
                                    errorController.value == true
                                ? Colors.red
                                : Colors.grey)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const IconWidget(iconCode: 0xe802),
                      Text(
                          date2ChangeController.value.isEmpty
                              ? 'No date'
                              : date2ChangeController.value,
                          style: date2ChangeController.value.isNotEmpty
                              ? AppTheme.appTheme.textTheme.bodyLarge
                              : AppTheme.appTheme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.grey))
                    ])));
          },
          valueListenable: date2ChangeController,
          child: Container())
    ]);
  }
}
