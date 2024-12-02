import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:modxdemo/apiservice/apiservices.dart';
import 'package:modxdemo/model/groupdata.dart';

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
  Future<void> updateGroupType(int id, String name, String description,
      bool showDivisionReport, bool isActive) async {
    isLoading = true;
    try {
      final response = await repo.update(
          id, name, description, showDivisionReport, isActive);

      groupTypes[groupTypes.indexWhere((e) {
        return e.id == id;
      })] = GroupType(
          description: description,
          name: name,
          id: id,
          isActive: isActive,
          showDivisionReport: showDivisionReport);
      isLoading = false;
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
    }
  }
}
