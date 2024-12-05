import 'package:flutter/material.dart';
import 'package:google_contacts/create_contact_page.dart';

class ContactLandingPage extends StatefulWidget {
  const ContactLandingPage({super.key});

  @override
  State<ContactLandingPage> createState() => _ContactLandingPageState();
}

class _ContactLandingPageState extends State<ContactLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts (0)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon or Illustration
              Image.asset("assets/emptycontacts_animation_cell4.png"),
              SizedBox(height: 20),
              // No Contacts Text
              Text(
                "No contacts yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Action for Create Contact
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateContactPage()),
                      );
                    },
                    icon: Icon(Icons.person_add_alt, color: Colors.blue),
                    label: Text(
                      "Create contact",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton.icon(
                    onPressed: () {
                      // Action for Import Contacts
                    },
                    icon: Icon(Icons.download_outlined, color: Colors.blue),
                    label: Text(
                      "Import contacts",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
