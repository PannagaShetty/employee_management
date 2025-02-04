import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
enum Role {
  @HiveField(0)
  flutterDev('Flutter Developer'),
  @HiveField(1)
  productDesigner('Product Designer'),
  @HiveField(2)
  qaTester('QA Tester'),
  @HiveField(3)
  productOwner('Product Owner');

  final String label;
  const Role(this.label);

  @override
  String toString() => label;
}

@HiveType(typeId: 1)
class Employee {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final Role role;

  @HiveField(3)
  final String fromDate;

  @HiveField(4)
  final String endDate;

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    required this.endDate,
  });
}
