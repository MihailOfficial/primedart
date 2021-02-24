import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkAttempts() async {
  DocumentReference saveref = FirebaseFirestore.instance.collection('user_scores').doc(FirebaseAuth.instance.currentUser.uid);
  DocumentSnapshot save = await saveref.get();

  if(save.exists){
    Timestamp t = save.get('last_attempt');
   if(t.toDate().difference(Timestamp.now().toDate()).inDays >= 1){
     saveref.set({'last_attempt' : Timestamp.now(), 'period_attempts' : 0, 'current_best' : 0}, SetOptions(merge: true));
     return true;
   } else {
     int attempts = save.get('period_attempts');
     return attempts < 10;
   }
  } else {
    saveref.set({'all_time_best' : 0, 'current_best': 0, 'period_attempts' : 0, 'username': FirebaseAuth.instance.currentUser.displayName, 'last_attempt' : Timestamp.now()}, SetOptions(merge: true));
    return true;
  }
}

Future<int> submitScore(int score) async{
  DocumentReference saveref = FirebaseFirestore.instance.collection('user_scores').doc(FirebaseAuth.instance.currentUser.uid);
  DocumentSnapshot save = await saveref.get();
  bool check = await checkAttempts();
  if(check){
    int attempts = save.get('period_attempts');
    saveref.set({'current_best': score, 'period_attempts' : attempts + 1, 'username': FirebaseAuth.instance.currentUser.displayName, 'last_attempt' : Timestamp.now()}, SetOptions(merge: true));
  } else {
    return -1;
  }
  saveref.set({}, SetOptions(merge: true));
}