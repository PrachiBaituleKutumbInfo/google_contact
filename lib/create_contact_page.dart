import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_contacts/user_profile_page.dart';
import 'package:image_picker/image_picker.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({super.key});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  // final _formKey = GlobalKey<FormState>();

  // Controllers for the main fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  bool isStarred = false;
  bool showMiddleName = false;
  bool showDepartment = false;

  void toggleStar() {
    setState(() {
      isStarred = !isStarred; // Toggle the star state
    });
  }

  void toggleMiddleNameField() {
    setState(() {
      showMiddleName = !showMiddleName;
    });
  }

  void toggleDepartmentField() {
    setState(() {
      showDepartment = !showDepartment;
    });
  }

  // Email and Phone lists
  List<TextEditingController> emailControllers = [TextEditingController()];
  List<TextEditingController> phoneControllers = [TextEditingController()];
  List<TextEditingController> addressControllers = [TextEditingController()];

  // Dropdowns for Month and Day
  String? selectedMonth;
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  // final List<String> days = List.generate(31, (index) => '${index + 1}');

  Widget buildDynamicFieldSection(
    String label,
    List<TextEditingController> controllers,
    TextInputType inputType,
    String validationMessage,
    String? validationPattern,
  ) {
    return Column(
      children: [
        ...controllers.asMap().entries.map((entry) {
          int index = entry.key;
          TextEditingController controller = entry.value;

          return Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: "$label ${index + 1}",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: inputType,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return validationMessage;
                    }
                    if (validationPattern != null &&
                        !RegExp(validationPattern).hasMatch(value)) {
                      return validationMessage;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.close),
                color: Colors.grey,
                onPressed: () {
                  // Remove the field safely
                  removeDynamicField(controllers, index);
                },
              ),
            ],
          );
        }).toList(),
        SizedBox(height: 10.0),
        Align(
          alignment: Alignment.center,
          child: TextButton.icon(
            onPressed: () {
              // Safely add a dynamic field
              addDynamicField(controllers);
            },
            icon: Icon(Icons.add),
            label: Text("Add $label"),
          ),
        ),
      ],
    );
  }

  bool get isSaveEnabled {
    // Enable the "Save" button if at least one required field is filled
    return firstNameController.text.isNotEmpty ||
        lastNameController.text.isNotEmpty ||
        emailControllers.any((controller) => controller.text.isNotEmpty) ||
        phoneControllers.any((controller) => controller.text.isNotEmpty);
  }

  void saveContact() {
    Map<String, dynamic> contactData = {
      'firstName': firstNameController.text,
      'middleName': middleNameController.text,
      'lastName': lastNameController.text,
      'company': companyController.text,
      'jobTitle': jobTitleController.text,
      'department': departmentController.text,
      'emails': emailControllers.map((controller) => controller.text).toList(),
      'phones': phoneControllers.map((controller) => controller.text).toList(),
      'addresses':
          addressControllers.map((controller) => controller.text).toList(),
      'month': selectedMonth,
      'day': dayController.text,
      'year': yearController.text,
      'note': noteController.text,
    };

    // Create a Contact object
    Contact contact = Contact(
      firstName: firstNameController.text,
      middleName: middleNameController.text,
      lastName: lastNameController.text,
      company: companyController.text,
      jobTitle: jobTitleController.text,
      department: departmentController.text,
      emails: emailControllers.map((controller) => controller.text).toList(),
      phones: phoneControllers.map((controller) => controller.text).toList(),
      addresses:
          addressControllers.map((controller) => controller.text).toList(),
      month: selectedMonth,
      day: dayController.text,
      year: yearController.text,
      note: noteController.text,
    );

    // Navigate to the ViewContactPage and pass the contact object
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewContactPage(contact: contact),
      ),
    );
  }

  void addDynamicField(List<TextEditingController> controllers) {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void removeDynamicField(List<TextEditingController> controllers, int index) {
    setState(() {
      if (controllers.isNotEmpty && index < controllers.length) {
        controllers[index]
            .dispose(); // Dispose the controller to avoid memory leaks
        controllers.removeAt(index); // Remove the field
      }
    });
  }

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     List<String> emails =
  //         emailControllers.map((controller) => controller.text).toList();
  //     List<String> phones =
  //         phoneControllers.map((controller) => controller.text).toList();
  //     List<String> addresses =
  //         addressControllers.map((controller) => controller.text).toList();
  //
  //     // Display collected information
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text("Contact Saved"),
  //           content: SingleChildScrollView(
  //             child: Text("Emails: ${emails.join(', ')}\n"
  //                 "Phones: ${phones.join(', ')}\n"
  //                 "Addresses: ${addresses.join(', ')}\n"),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: Text("OK"),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    companyController.dispose();
    jobTitleController.dispose();
    departmentController.dispose();
    noteController.dispose();
    for (var controller in emailControllers) {
      controller.dispose();
    }
    for (var controller in phoneControllers) {
      controller.dispose();
    }
    for (var controller in addressControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File? _image;

    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Contact",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              isStarred
                  ? Icons.star
                  : Icons
                      .star_border_purple500_outlined, // Change icon based on state
              color: isStarred
                  ? Colors.blue
                  : Colors.white, // Highlight if enabled
            ),
            onPressed: toggleStar, // Toggle the star on click
          ),
          TextButton(
            onPressed: isSaveEnabled ? saveContact : null,
            style: TextButton.styleFrom(
              backgroundColor: isSaveEnabled ? Colors.blue : Colors.grey,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 12,
              ),
            ),
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.0),
              // Profile Photo Placeholder with + Icon
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue[100],
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.person,
                                size: 50, color: Colors.blue[300])
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              // Add Label Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      _showCreateLabelDialog(context);
                    },
                    icon: Icon(Icons.add, color: Colors.blue),
                    label: Text(
                      "Label",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // First Name with Dropdown Arrow
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: firstNameController,
                          label: "First Name",
                          prefixIcon: Icons.person,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          showMiddleName
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                        onPressed: toggleMiddleNameField,
                      ),
                    ],
                  ),

                  // Middle Name Field (conditionally displayed)
                  if (showMiddleName)
                    _buildTextField(
                      controller: middleNameController,
                      label: "Middle Name",
                      prefixIcon: Icons.person_outline,
                    ),

                  // Last Name Field
                  _buildTextField(
                    controller: lastNameController,
                    label: "Last Name",
                    prefixIcon: Icons.person_outline,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: companyController,
                          label: "Company",
                          prefixIcon: Icons.work,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          showDepartment
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                        onPressed: toggleDepartmentField,
                      ),
                    ],
                  ),
                  _buildTextField(
                    controller: jobTitleController,
                    label: "Job Title",
                  ),
                  if (showDepartment)
                    _buildTextField(
                      controller: departmentController,
                      label: "Department",
                    ),
                  SizedBox(height: 15.0),

                  // Emails Section
                  buildDynamicFieldSection(
                    "Email",
                    emailControllers,
                    TextInputType.emailAddress,
                    "Please enter a valid email",
                    r'^[^@]+@[^@]+\.[^@]+',
                  ),
                  SizedBox(height: 15.0),

                  buildDynamicFieldSection(
                    "Phone",
                    phoneControllers,
                    TextInputType.phone,
                    "Please enter a valid phone number",
                    r'^\d+$',
                  ),
                  SizedBox(height: 15.0),
                  buildDynamicFieldSection(
                    "Address",
                    addressControllers,
                    TextInputType.streetAddress,
                    "Please enter an address",
                    null,
                  ),

                  // Date of Birth Section
                  _buildSectionTitle('Date of Birth'),
                  Row(children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Month',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedMonth,
                        items: months
                            .map((month) => DropdownMenuItem(
                                  value: month,
                                  child: Text(month),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        controller: dayController,
                        label: "Day",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                  SizedBox(width: 10),

                  _buildTextField(
                    controller: yearController,
                    label: "Year (Optional)",
                    prefixIcon: Icons.date_range,
                    keyboardType: TextInputType.number,
                  ),

                  // Note Section
                  _buildSectionTitle('Note'),
                  _buildTextField(
                    controller: noteController,
                    label: "Note",
                    prefixIcon: Icons.note,
                    maxLines: 3,
                  ),
                ],
              )

              // Save Button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  List<Widget> buildDynamicFields(List<TextEditingController> controllers,
      String label, IconData icon, VoidCallback onAdd) {
    return [
      ...controllers.map(
        (controller) => _buildTextField(
          controller: controller,
          label: label,
          prefixIcon: icon,
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: TextButton.icon(
          onPressed: onAdd,
          icon: Icon(Icons.add),
          label: Text('Add $label'),
        ),
      ),
    ];
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

void _showCreateLabelDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Create Label",
        ),
        content: TextField(
          decoration: InputDecoration(
            labelText: "New Label",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Logic to create label
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}
