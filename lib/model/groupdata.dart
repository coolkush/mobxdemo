class GroupType {
  final int id;
  final String name;
  final String description;
  final bool isActive;
  final bool showDivisionReport;

  GroupType({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.showDivisionReport,
  });

  factory GroupType.fromJson(Map<String, dynamic> json) {
    return GroupType(
      id: json['Id'],
      name: json['Name'],
      description: json['Description'],
      isActive: json['IsActive'],
      showDivisionReport: json['ShowDivisionReport'],
    );
  }
}
