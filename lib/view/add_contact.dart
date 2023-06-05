import 'dart:math';

import 'package:fb1/controller/contact_controller.dart';
import 'package:fb1/model/contact_model.dart';
import 'package:fb1/view/contact.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final formkey = GlobalKey<FormState>();
  var contactController = ContactController();

  String? name;
  String? email;
  String? phone;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Phone'),
                onChanged: (value) {
                  phone = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Address'),
                onChanged: (value) {
                  address = value;
                },
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    ContactModel cm = ContactModel(
                      name: name!,
                      phone: phone!,
                      email: email!,
                      address: address!,
                    );
                    contactController.addContact(cm);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Changed')));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Contact(),
                        ));
                  },
                  child: Text('add'))
            ],
          ),
        ),
      ),
    );
  }
}
