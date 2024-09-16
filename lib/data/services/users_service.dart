import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() =>
      FirebaseFirestore.instance.collection('users').snapshots();
}
