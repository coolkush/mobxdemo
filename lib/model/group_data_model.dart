class GroupDataModel {
  final int? id;
  final String? name;
  final String? description;
  final bool? isActive;
  final bool? showDivisionReport;
  GroupDataModel(
      {required this.id,
      required this.isActive,
      required this.description,
      required this.showDivisionReport,
      required this.name});
  GroupDataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['Name'] as String?,
        isActive = json['IsActive'] as bool?,
        description = json['Description'] as String?,
        showDivisionReport = json['ShowDivisionReport'] as bool?;
  Map<String, dynamic> toJson() => {
        'Name': name,
        'IsActive': isActive,
        'Description': description,
        'ShowDivisionReport': showDivisionReport
      };

  //  {
  //               "Id": 111,
  //               "Name": "fdhdhdhx",
  //               "Description": "gggxgd",
  //               "ShowDivisionReport": true,
  //               "IsActive": true
  //           },
}
