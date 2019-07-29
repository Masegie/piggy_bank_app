import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dram1y/models/user.dart';
import 'package:dram1y/service/firestore/firestore_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUserService {
  static Future<void> checkAndCreateUser() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    final userReference = Firestore.instance.collection(FirestoreConstants.userCollection).document(firebaseUser.uid);

    final userDocumentSnapshot = await userReference.get();

    if(userDocumentSnapshot.exists == false){
      try {
        User user = User.temp();
        await userReference.setData(user.toJson());
      } catch (e) {
        print(e);
        throw e;
      }
    }
  }

  static Future<Stream<DocumentSnapshot>> getUserStream() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    final userDocumentStream = Firestore.instance.collection(FirestoreConstants.userCollection).document(firebaseUser.uid).snapshots();
    return userDocumentStream;
  }

  static Future<void> updateLastLoggedIn() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    Map<String, dynamic> update = Map();
    update.putIfAbsent(User.lastLoggendInField,() => DateTime.now());

    try {
        Firestore.instance.collection(FirestoreConstants.userCollection).document(firebaseUser.uid).updateData(update);
      } catch (e) {
        print(e);
        throw e;
      }
  }
}