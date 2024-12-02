import 'package:flutter/material.dart';

class AllGroup extends StatefulWidget {
  const AllGroup({super.key});

  @override
  State<AllGroup> createState() => _AllGroupState();
}

class _AllGroupState extends State<AllGroup> {
  final List<Map<String, dynamic>> dropdownData = [
    {
      "title": "Group A",
      "items": ["Group A1"],
      "selectedItem": null,
      "textField1": "",
      "textField2": "",
      "switch1": false,
      "switch2": false,
      "isExpanded": false,
    },
    {
      "title": "Group B",
      "items": ["Group B1"],
      "selectedItem": null,
      "textField1": "",
      "textField2": "",
      "switch1": false,
      "switch2": false,
      "isExpanded": false,
    },
    {
      "title": "Group C",
      "items": ["Group C1"],
      "selectedItem": null,
      "textField1": "",
      "textField2": "",
      "switch1": false,
      "switch2": false,
      "isExpanded": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ALL GROUPS"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dropdownData.map((dropdown) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dropdown['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: dropdown['selectedItem'],
                    hint: const Text("Select an option"),
                    items: (dropdown['items'] as List<String>).map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdown['selectedItem'] = value;
                        dropdown['isExpanded'] = true; // Show the layout
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: dropdown['isExpanded'],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Enter text 1",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              dropdown['textField1'] = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Enter text 2",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              dropdown['textField2'] = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text("Switch 1"),
                                Switch(
                                  value: dropdown['switch1'],
                                  onChanged: (value) {
                                    setState(() {
                                      dropdown['switch1'] = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Switch 2"),
                                Switch(
                                  value: dropdown['switch2'],
                                  onChanged: (value) {
                                    setState(() {
                                      dropdown['switch2'] = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
