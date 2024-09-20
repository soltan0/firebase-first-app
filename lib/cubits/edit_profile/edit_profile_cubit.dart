import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/screens.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  final currentUser = FirebaseAuth.instance.currentUser!;

  Map<String, dynamic>? userData;

  final nameController = TextEditingController();
  final aboutController = TextEditingController();

  void getCurrentUserData() async {
    try {
      emit(EditProfileLoading());
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      log('result: $result');

      if (result.exists) {
        userData = result.data();
        nameController.text = userData?['name'] ?? '';
        aboutController.text = userData?['about'] ?? '';
        log('userdata: $userData');
      }
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileError());
    }
  }

  void updateProfile(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update({
      'name': nameController.text,
      'about': aboutController.text,
    });

    await FirebaseAuth.instance.currentUser!
        .updateDisplayName(nameController.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Screens.users,
      ),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    aboutController.dispose();
    return super.close();
  }
}
