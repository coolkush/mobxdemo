import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modxdemo/modx/group_store.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final GroupStore groupStore = GroupStore();

  @override
  void initState() {
    super.initState();
    // Fetch group types when the widget is initialized
    groupStore.fetchGroupTypes();
  }

  // Update a group type
  void _updateGroupType(int id) {
    final group = groupStore.groupTypes.firstWhere((group) => group.id == id);
    // Example: Update with new name and description
    groupStore.updateGroupType(id, 'Updated Name', 'Updated Description');
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
              final group = groupStore.groupTypes[index];

              return ListTile(
                title: Text(group.name),
                subtitle: Text(group.description),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updateGroupType(group.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
