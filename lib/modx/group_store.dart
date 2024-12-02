import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:modxdemo/apiservice/apiservices.dart';

part 'group_store.g.dart';

Repository repo = Repository();
// ignore: library_private_types_in_public_api
class GroupStore = _GroupStore with _$GroupStore;

abstract class _GroupStore with Store {
  // Observable variables
  @observable
  List<GroupType> groupTypes = [];

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  // Fetch group types with GET request
  @action
  Future<void> fetchGroupTypes() async {
    isLoading = true;
    try {
      final response = await repo.getGroupType();
      groupTypes = response.map((e) {
        return GroupType(
            id: e.id ?? -1,
            name: e.name ?? "",
            description: e.description ?? "",
            isActive: e.isActive ?? false,
            showDivisionReport: e.showDivisionReport ?? false);
      }).toList();
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
    }
  }

  // Update a single group type with PATCH request
  @action
  Future<void> updateGroupType(int id, String name, String description) async {
    isLoading = true;
    try {
      final response = await http.patch(
        Uri.parse(
            'http://dev.api.teaqip.nobrainsolutions.com/v1/group-types/$id'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Name': name,
          'Description': description,
          'ShowDivisionReport': true,
          'IsActive': true,
        }),
      );

      if (response.statusCode == 200) {
        final updatedGroup = GroupType.fromJson(jsonDecode(response.body));
        // Update the list by replacing the updated group
        groupTypes = groupTypes.map((group) {
          return group.id == id ? updatedGroup : group;
        }).toList();
      } else {
        errorMessage = 'Failed to update group';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
    }
  }
}

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
      id: json['id'],
      name: json['Name'],
      description: json['Description'],
      isActive: json['IsActive'],
      showDivisionReport: json['ShowDivisionReport'],
    );
  }
}
