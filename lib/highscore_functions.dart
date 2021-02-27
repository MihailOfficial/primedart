import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

Future<bool> checkAttempts() async {
  DocumentReference saveref = FirebaseFirestore.instance.collection('user_scores').doc(FirebaseAuth.instance.currentUser.uid);
  DocumentSnapshot save = await saveref.get();

  if(save.exists){
    Timestamp t = save.get('last_attempt');
   if(t.toDate().difference(Timestamp.now().toDate()).inDays >= 1){
     await saveref.set({'last_attempt' : Timestamp.now(), 'period_attempts' : 0, 'current_best' : 0}, SetOptions(merge: true));
     return true;
   } else {
     int attempts = save.get('period_attempts');
     return attempts < 10;
   }
  } else {
    await saveref.set({'all_time_best' : 0, 'current_best': 0, 'period_attempts' : 0, 'username': FirebaseAuth.instance.currentUser.displayName, 'last_attempt' : Timestamp.now()}, SetOptions(merge: true));
    return true;
  }
}

Future<int> submitScore(int score) async {
  DocumentReference saveref = FirebaseFirestore.instance.collection('user_scores').doc(FirebaseAuth.instance.currentUser.uid);
  DocumentSnapshot save = await saveref.get();
  bool check = await checkAttempts();
  if(check){
    if(score <= await save.get('current_best')){
      return -2;
    } else {
      int attempts = save.get('period_attempts');
      await saveref.set({'all_time_best': max<int>(await save.get('all_time_best'), score), 'current_best': score, 'period_attempts' : attempts + 1, 'username': FirebaseAuth.instance.currentUser.displayName, 'last_attempt' : Timestamp.now()}, SetOptions(merge: true));
      return score;
    }

  } else {
    return -1;
  }
}