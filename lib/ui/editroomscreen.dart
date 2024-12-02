import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modxdemo/modx/group_store.dart';
import 'package:modxdemo/ui/allgroupscreen.dart';

// ignore: must_be_immutable
class AllGroup extends StatefulWidget {
  String name;
  String description;
  bool isActive;
  bool showDiv;
  int id;

  AllGroup({
    super.key,
    required this.id,
    required this.showDiv,
    required this.name,
    required this.description,
    required this.isActive,
  });

  @override
  State<AllGroup> createState() => _AllGroupState();
}

class _AllGroupState extends State<AllGroup> {
  final GroupStore groupStore = GroupStore();
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  bool isActive = false;
  bool showDivisionReport = false;
  update() {
    controller.text = widget.name;
    controller1.text = widget.description;

    isActive = widget.isActive;
    showDivisionReport = widget.showDiv;
    setState(() {});
  }

  @override
  void initState() {
    update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit GROUPS"),
      ),
      body: Observer(
        builder: (c) {
          if (groupStore.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (groupStore.errorMessage.isNotEmpty) {
            return Center(child: Text(groupStore.errorMessage));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Visibility(
                visible: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: "name",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller1,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text("isActive"),
                            Switch(
                              value: isActive,
                              onChanged: (value) {
                                setState(() {
                                  isActive = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("showDivisionReport"),
                            Switch(
                              value: showDivisionReport,
                              onChanged: (value) {
                                setState(() {
                                  showDivisionReport = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                        child: TextButton(
                            onPressed: () async {
                              if (controller.text.isNotEmpty &&
                                  controller1.text.isNotEmpty) {
                                try {
                                  await groupStore.updateGroupType(
                                      widget.id,
                                      controller.text,
                                      controller1.text,
                                      showDivisionReport,
                                      isActive);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => GroupPage()),
                                      (route) => false);
                                } catch (e) {}
                              }
                            },
                            child: const Text("Update")))
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
