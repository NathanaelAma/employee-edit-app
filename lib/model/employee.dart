
class Employee {
  final int id;
  final String name;
  final String position;
  final int employeeOrManager;

  const Employee({
    this.id = 0,
    required this.name,
    required this.position,
    required this.employeeOrManager,
  });

  Employee.fromMap(Map<String, dynamic> item)
      : id = item['id'],
        name = item['name'],
        position = item['position'],
        employeeOrManager = item['employeeOrManager'];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'employeeOrManager': employeeOrManager
    };
  }


}
