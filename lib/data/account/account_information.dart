import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AccountInformation{
  final DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  final _auth = FirebaseAuth.instance;

  late String userUid;
  late User loggedInUser;

  late var users;
  String name = '';
  String phone = '';
  getData() async{
    final user = await _auth.currentUser;
    if(user != null){
      userUid = user.uid;
      loggedInUser = user;
    }

    DatabaseEvent event = await ref.once();
    users = event.snapshot.value;
      name = users[userUid]['name'];
      phone = users[userUid]['phone'];
  }
}