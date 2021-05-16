import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';


Future<bool> createUser(String usr) async {
  String uid = await FlutterUdid.consistentUdid;
  DataSnapshot udid = await FirebaseDatabase.instance.reference().child("users").child(uid).once();
  DataSnapshot tag = await FirebaseDatabase.instance.reference()
      .child("tags")
      .child(usr)
      .once();
  if (tag.value != null) {
    if (tag.value < 9999) {
      await FirebaseDatabase.instance.reference().child("tags")
          .child(usr)
          .set(tag.value + 1);
      if(udid.value != null){
        await FirebaseDatabase.instance.reference().child("users").child(uid).child("username").set(usr);
        return true;
      } else {
        await FirebaseDatabase.instance.reference().child("users")
            .child(uid)
            .set(
            {
              "all_time_best": 0,
              "current_best": 0,
              "last_attempt": DateTime
                  .now()
                  .millisecondsSinceEpoch / 1000,
              "period_attempts": 0,
              "username": usr,
              "tag": 0
            });
        return true;
      }
    } else {
      return false;
    }
  } else {
    await FirebaseDatabase.instance.reference().child("tags").child(usr).set(
        1);
    if(udid.value != null){
      await FirebaseDatabase.instance.reference().child("users").child(uid).child("username").set(usr);
      return true;
    } else {
      await FirebaseDatabase.instance.reference().child("users").child(uid).set(
          {
            "all_time_best": 0,
            "current_best": 0,
            "last_attempt": DateTime
                .now()
                .millisecondsSinceEpoch / 1000,
            "period_attempts": 0,
            "username": usr,
            "tag": 0
          });
      return true;
    }
  }
}
Future<bool> createUser1(int num) async {
  String usr = "firebase tester";
  //String uid = await FlutterUdid.consistentUdid;
  String uid = "test_user" + num.toString();
  DataSnapshot tag = await FirebaseDatabase.instance.reference().child("tags").child(usr).once();
  if(tag.value != null){
    if(tag.value < 9999){
      await FirebaseDatabase.instance.reference().child("tags").child(usr).set(tag.value + 1);
      await FirebaseDatabase.instance.reference().child("users").child(uid).set({
        "all_time_best":0,
        "current_best":0,
        "last_attempt": DateTime.now().millisecondsSinceEpoch / 1000,
        "period_attempts":0,
        "username": usr,
        "tag":tag.value
      });
      return true;
    } else {
      return false;
    }
  } else {
    await FirebaseDatabase.instance.reference().child("tags").child(usr).set(1);
    await FirebaseDatabase.instance.reference().child("users").child(uid).set({
      "all_time_best":0,
      "current_best":0,
      "last_attempt": DateTime.now().millisecondsSinceEpoch / 1000,
      "period_attempts":0,
      "username": usr,
      "tag":0
    });
    return true;
  }
}

Future<bool> checkAttempts() async {
  String uid = await FlutterUdid.consistentUdid;
  /*
  DatabaseReference usr = FirebaseDatabase.instance.reference().child("users").child(uid);
  DataSnapshot lastAttempt = await usr.child("last_attempt").once();
  DataSnapshot attempts = await usr.child("period_attempts").once();
  if(DateTime.fromMillisecondsSinceEpoch(lastAttempt.value * 1000, isUtc: true).difference(DateTime.now()).inDays <= -1) {
    usr.child("last_attempt").set(DateTime.now().millisecondsSinceEpoch / 1000);
    return true;
  } else {
    return attempts.value < 10;
  }*/
  DatabaseReference usr = FirebaseDatabase.instance.reference().child("users").child(uid);
  DataSnapshot attempts = await usr.child("period_attempts").once();

  return attempts.value < 10;
}

Future<bool> usrExists() async {
  String uid = await FlutterUdid.consistentUdid;
  DataSnapshot d = await FirebaseDatabase.instance.reference().child("users").child(uid).once();

  return d.value != null;
}

Future<int> submitScore(int score) async {
  String uid = await FlutterUdid.consistentUdid;
  bool check = await checkAttempts();
  DatabaseReference usr = FirebaseDatabase.instance.reference().child("users").child(uid);
  if(check){
    if(score <= (await usr.child("current_best").once()).value){
      return -2;
    } else {
      //await usr.child("period_attempts").set((await usr.child("period_attempts").once()).value + 1);
      await usr.child("all_time_best").set(max<int>((await usr.child("all_time_best").once()).value, score));
      await usr.child("current_best").set(score);
      //await usr.child("last_attempt").set(DateTime.now().millisecondsSinceEpoch / 1000);
      return score;
    }
  } else {
    return -1;
  }
}

Future<List<Map<dynamic,dynamic>>> getHighScores(int limit) async {
  DataSnapshot d = await FirebaseDatabase.instance.reference().child("users").orderByChild("current_best").limitToLast(limit).once();
  Map<dynamic,dynamic> high_users = d.value;
  //high_users.values.forEach((element) {Map<dynamic,dynamic> m = element; print(m["username"]);});

  List<Map<dynamic,dynamic>> high_lst = [];

  high_users.values.forEach((value) {Map<dynamic,dynamic> usr_map = value; high_lst.add(usr_map);});
  high_lst.sort((a,b) {
    int bscore = b["current_best"];
    //print(bscore);
    int ascore = a["current_best"];
    //print(ascore);
    return bscore - ascore;
  });
  //print("test");

  return high_lst;
}

Future<int> getMyScore() async {
  String uid = await FlutterUdid.consistentUdid;
  bool exists = await usrExists();
  DataSnapshot d = await FirebaseDatabase.instance.reference().child("users").child(uid).child('current_best').once();
  int result = d.value;
  return result;
}

Future<String> getUsername() async {
  String uid = await FlutterUdid.consistentUdid;
  bool exists = await usrExists();
  DataSnapshot d = await FirebaseDatabase.instance.reference().child("users").child(uid).child('username').once();
  String result = d.value;
  return result;
}

Future<int> getTag() async {
  String uid = await FlutterUdid.consistentUdid;
  bool exists = await usrExists();
  DataSnapshot d = await FirebaseDatabase.instance.reference().child("users").child(uid).child('tag').once();
  int result = d.value;
  return result;
}

Future<int> getRank() async {
  String uid = await FlutterUdid.consistentUdid;
  bool exists = await usrExists();

  DataSnapshot d = await FirebaseDatabase.instance.reference().child("users").orderByChild("current_best").startAt((await getMyScore())).once();
  Map<dynamic,dynamic> users = d.value;
  return users.length;
}


Future<bool> checkAttempts1() async {
  DocumentReference saveref = FirebaseFirestore.instance.collection('user_scores').doc(FirebaseAuth.instance.currentUser.uid);
  DocumentSnapshot save = await saveref.get();

  if(save.exists){
    Timestamp t = save.get('last_attempt');
   if(t.toDate().difference(Timestamp.now().toDate()).inDays <= -1){
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

Future<int> submitScore1(int score) async {
  bool check = await checkAttempts();
  DocumentReference saveref = FirebaseFirestore.instance.collection('user_scores').doc(FirebaseAuth.instance.currentUser.uid);
  DocumentSnapshot save = await saveref.get();
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

Future<List<DocumentSnapshot>> getHighScores1(int limit) async {
  QuerySnapshot result = await FirebaseFirestore.instance.collection('user_scores').orderBy('current_best', descending: true).limit(limit).get();
  return result.docs;
}

Future<int> getMyScore1() async {
  return FirebaseFirestore.instance.collection("user_scores").doc(FirebaseAuth.instance.currentUser.uid).get().then((snapshot) {
    Timestamp t = snapshot.get("last_attempt");
    //print(t.toDate().difference(Timestamp.now().toDate()).inDays);
    if(t.toDate().difference(Timestamp.now().toDate()).inDays <= -1){
      return 0;
    } else {
      return snapshot['current_best'];
    }
  });
}