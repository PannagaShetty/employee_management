class Employee {
  final String id;
  final String name;
  final String position;
  final String teamId;
  final String email;
  final String startDate;
  final String? endDate;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.teamId,
    required this.email,
    required this.startDate,
    this.endDate,
  });
}
