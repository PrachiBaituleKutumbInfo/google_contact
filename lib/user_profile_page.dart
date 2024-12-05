import 'package:flutter/material.dart';

class Contact {
  final String firstName;
  final String lastName;
  final String company;
  final String jobTitle;
  final List<String> emails;
  final List<String> phones;
  final List<String> addresses;
  final String? month;
  final String? day;
  final String? year;
  final String? note;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.jobTitle,
    required this.emails,
    required this.phones,
    required this.addresses,
    this.month,
    this.day,
    this.year,
    this.note,
  });
}

class ViewContactPage extends StatelessWidget {
  final Contact contact;

  ViewContactPage({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade400,
              child: Text(
                "I",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ("${contact.firstName} ${contact.lastName}"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.email, "Email"),
                _buildActionButton(Icons.event, "Schedule"),
                _buildActionButton(Icons.chat, "Chat"),
                _buildActionButton(Icons.videocam, "Video"),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Text(
                "+ Label",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactDetail(
                      Icons.email_outlined, "${contact.emails.join(', ')}"),
                  const Divider(),
                  _buildContactDetail(
                      Icons.phone, "${contact.phones.join(', ')}"),
                  const Divider(),
                  _buildContactDetail(Icons.cake,
                      _formatDate(contact.month, contact.day, contact.year)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade300,
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildContactDetail(IconData icon, String detail) {
    return Row(
      children: [
        Icon(icon, color: Colors.black),
        const SizedBox(width: 15),
        Text(
          detail,
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ],
    );
  }

  // Helper function to format the date
  String _formatDate(String? month, String? day, String? year) {
    if (month == null || day == null || year == null) {
      return ""; // or simply return an empty string ""
    }
    return "$month $day, $year";
  }
}
