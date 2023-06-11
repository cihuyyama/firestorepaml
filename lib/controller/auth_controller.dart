import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../model/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');

  bool get succes => false;

  Future<UserModel?> signInwithEmailandPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await usersCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
            Name: snapshot['name'], email: user.email ?? '', uId: user.uid);

        return currentUser;
      }
    } catch (e) {
      print('Error signing in: $e');
    }
    return null;
  }

  Future<UserModel?> registerwithEmailandPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user!=null) {
        final UserModel newUser = UserModel(Name: name, email: email ?? '', uId: user.uid);

        await usersCollection.doc(newUser.uId).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print('Error registering user : $e');
    }
  }

  
}
