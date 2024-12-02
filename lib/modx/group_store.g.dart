// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$GroupStore on _GroupStore, Store {
  late final _$groupTypesAtom =
      Atom(name: '_GroupStore.groupTypes', context: context);

  @override
  List<GroupType> get groupTypes {
    _$groupTypesAtom.reportRead();
    return super.groupTypes;
  }

  @override
  set groupTypes(List<GroupType> value) {
    _$groupTypesAtom.reportWrite(value, super.groupTypes, () {
      super.groupTypes = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_GroupStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_GroupStore.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchGroupTypesAsyncAction =
      AsyncAction('_GroupStore.fetchGroupTypes', context: context);

  @override
  Future<void> fetchGroupTypes() {
    return _$fetchGroupTypesAsyncAction.run(() => super.fetchGroupTypes());
  }

  late final _$updateGroupTypeAsyncAction =
      AsyncAction('_GroupStore.updateGroupType', context: context);

  @override
  Future<void> updateGroupType(int id, String name, String description,
      bool showDivisionReport, bool isActive) {
    return _$updateGroupTypeAsyncAction.run(() => super
        .updateGroupType(id, name, description, showDivisionReport, isActive));
  }

  @override
  String toString() {
    return '''
      groupTypes: ${groupTypes},
      isLoading: ${isLoading},
      errorMessage: ${errorMessage}
    ''';
  }
}
