import 'package:flutter/material.dart';

class ToggleFieldPage extends StatefulWidget {
  @override
  State<ToggleFieldPage> createState() => _ToggleFieldPageState();
}

class _ToggleFieldPageState extends State<ToggleFieldPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool isMiddleNameVisible = false; // Toggle visibility of Middle Name

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name with Dropdown Arrow
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: "First Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isMiddleNameVisible
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                    onPressed: () {
                      setState(() {
                        isMiddleNameVisible = !isMiddleNameVisible;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Middle Name (Visible/Hidden based on state)
              if (isMiddleNameVisible)
                TextFormField(
                  controller: middleNameController,
                  decoration: InputDecoration(
                    labelText: "Middle Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(height: 10),
              // Last Name
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
