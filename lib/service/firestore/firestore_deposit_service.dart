import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/service/firestore/firestore_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDepositService {
   static Future<Stream<QuerySnapshot>> getDepositStream(DateTime date) async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    
    final firstDate = DateTime(date.year, date.month , date.day);
    final lastDate = DateTime(date.year, date.month , date.day, 23, 59, 59);
    
    final depositCollectiontStream = Firestore.instance
    .collection(FirestoreConstants.userCollection)
    .document(firebaseUser.uid)
    .collection(FirestoreConstants.depositCollection)
    .where('date', isGreaterThan: firstDate)
    .where('date', isLessThan: lastDate)
    .snapshots();
    return depositCollectiontStream;
  }
  static Future<void> depositMoney(Deposit deposit) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    final depositCollection = Firestore.instance
      .collection(FirestoreConstants.userCollection)
      .document(firebaseUser.uid)
      .collection(FirestoreConstants.depositCollection);

    depositCollection.add(deposit.toJson());
  }

  static void removeDeposit(Deposit deposit) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance
      .collection(FirestoreConstants.userCollection)
      .document(firebaseUser.uid)
      .collection(FirestoreConstants.depositCollection)
      .document(deposit.id)
      .delete();
  }

  static Future<void> updateTotalDeposit(int amount) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    Map<String, dynamic> update = Map();
    update.putIfAbsent(Deposit.amountField, () => amount);

    try {
      await Firestore.instance.collection(FirestoreConstants.userCollection).document(firebaseUser.uid).updateData(update);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}