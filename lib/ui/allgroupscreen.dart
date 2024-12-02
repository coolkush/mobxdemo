import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modxdemo/modx/group_store.dart';
import 'package:modxdemo/ui/editroomscreen.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final GroupStore groupStore = GroupStore();

  @override
  void initState() {
    super.initState();
    groupStore.fetchGroupTypes();
  }

  // Update a group type
  void _updateGroupType(int index) {
    log("message ${groupStore.groupTypes}");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AllGroup(
                  id: groupStore.groupTypes[index].id,
                  showDiv: groupStore.groupTypes[index].showDivisionReport,
                  name: groupStore.groupTypes[index].name,
                  description: groupStore.groupTypes[index].description,
                  isActive: groupStore.groupTypes[index].isActive,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Group Types')),
      body: Observer(
        builder: (_) {
          if (groupStore.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (groupStore.errorMessage.isNotEmpty) {
            return Center(child: Text(groupStore.errorMessage));
          }

          return ListView.builder(
            itemCount: groupStore.groupTypes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(groupStore.groupTypes[index].name),
                subtitle: Text(groupStore.groupTypes[index].description),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updateGroupType(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
