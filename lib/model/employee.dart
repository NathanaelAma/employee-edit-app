class Employee {
  final String id;
  final String employeeName;
  final String employeePosition;
  final int employeeOrManager;

  const Employee({
    required this.id,
    required this.employeeName,
    required this.employeePosition,
    required this.employeeOrManager,
  });

  Employee.fromMap(Map<String, dynamic> item)
      : id = item['id'],
        employeeName = item['employeeName'],
        employeePosition = item['employeePosition'],
        employeeOrManager = item['employeeOrManager'];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'employeeName': employeeName,
      'employeePosition': employeePosition,
      'employeeOrManager': employeeOrManager
    };
  }
}
