import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/users_service.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._usersService) : super(UsersInitial());

  // ignore: unused_field
  final UsersService _usersService;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final photoController = TextEditingController();
  final aboutController = TextEditingController();

  // Stream<QuerySnapshot<Map<String, dynamic>>> get users =>
  //     _usersService.getUsers();

  // Future<QuerySnapshot<Map<String, dynamic>>> getUsers() {
  //   return FirebaseFirestore.instance.collection('users').get();
  // }

  QuerySnapshot<Map<String, dynamic>>? users;

  void getUsers() async {
    try {
      emit(UsersLoading());
      users = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      emit(UsersSuccess());
    } catch (e) {
      emit(UsersError());
    }
  }

  void addUsers(BuildContext context) async {
    await FirebaseFirestore.instance.collection('users').add({
      'id': 3,
      'name': nameController.text,
      'phone': phoneController.text,
      'photo': photoController.text,
      'about': aboutController.text,
    }).then((e) {
      Navigator.pop(context);
      getUsers();
    });
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    photoController.dispose();
    aboutController.dispose();
    return super.close();
  }
}
