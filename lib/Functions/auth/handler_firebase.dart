import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
class HandlerFirebase {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signIn({required String email, required String password}) async {
    try {
      final response = await auth.signInWithEmailAndPassword(email: email, password: password);
      return response.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}


class FirebaseHandler {
  // Singleton pattern to ensure one instance of FirebaseHandler
  static final FirebaseHandler _instance = FirebaseHandler._internal();

  factory FirebaseHandler() {
    return _instance;
  }

  FirebaseHandler._internal();

  // Initialize Firebase (must be called before using other Firebase services)
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Access Firebase Authentication instance
  FirebaseAuth get authInstance => FirebaseAuth.instance;

  // Access Firestore instance
  FirebaseFirestore get firestoreInstance => FirebaseFirestore.instance;

  // Access Realtime Database instance
  FirebaseDatabase get databaseInstance => FirebaseDatabase.instance;

  // Access Firebase Messaging instance for push notifications
  FirebaseMessaging get messagingInstance => FirebaseMessaging.instance;
}
