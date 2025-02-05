import 'package:hive_flutter/hive_flutter.dart';
import 'package:employee_management/models/employee.dart';

class HiveService {
  static const String employeeBox = 'employees';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(RoleAdapter());
    Hive.registerAdapter(EmployeeAdapter());

    await Hive.openBox<Employee>(employeeBox);
  }

  static Box<Employee> getEmployeeBox() {
    return Hive.box<Employee>(employeeBox);
  }

  Future<List<Employee>> getAllEmployees() async {
    final box = getEmployeeBox();
    return box.values.toList();
  }

  Future<void> addEmployee(Employee employee) async {
    final box = getEmployeeBox();
    await box.put(employee.id, employee);
  }

  Future<void> deleteEmployee(String id) async {
    final box = await Hive.openBox<Employee>('employees');
    await box.delete(id);
  }

  Future<void> clearAll() async {
    final box = getEmployeeBox();
    await box.clear();
  }
}
