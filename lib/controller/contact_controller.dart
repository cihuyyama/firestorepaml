import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb1/model/contact_model.dart';

class ContactController{
  final contactCollection = FirebaseFirestore.instance.collection('contact');

  final StreamController<List<DocumentSnapshot>> streamController = StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async{
    final contact = ctmodel.toMap();
    final DocumentReference docref = await contactCollection.add(contact);
    
    final String docid = docref.id;

    final ContactModel contactModel = ContactModel(
      id: docid,
      name: ctmodel.name, 
      phone: ctmodel.phone, 
      email: ctmodel.email, 
      address: ctmodel.address);
    
    await docref.update(contactModel.toMap());
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.sink.add(contact.docs);
    return contact.docs;
  }

  Future deleteContact(String id) async {
    final contact = await contactCollection.doc(id).delete();
    return contact;
  }
}