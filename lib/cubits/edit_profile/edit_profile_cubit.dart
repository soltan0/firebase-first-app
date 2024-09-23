import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/subjects.dart';

import '../../helpers/screens.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  final ref = FirebaseStorage.instance.ref();

  final currentUser = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? userData;
  final BehaviorSubject imageSubject = BehaviorSubject<File?>();

  final nameController = TextEditingController();
  final aboutController = TextEditingController();

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageSubject.value = File(pickedFile.path);
    }
  }

  Future<String?> uploadProfilePhoto(
    File imageFile,
  ) async {
    try {
      log('Upload profile!');
      String filePath = 'profiles/${currentUser.uid}/${DateTime.now()}';
      log('filePath: $filePath');
      final storageRef = ref.child(filePath);
      log('storageRef: $storageRef');
      await storageRef.putFile(imageFile);
      final downloadURL = await storageRef.getDownloadURL();
      log('downloadURL: $downloadURL');
      return downloadURL;
    } catch (e) {
      print('UPLOAD error: $e');
      return null;
    }
  }

  void getCurrentUserData() async {
    try {
      emit(EditProfileLoading());
      final result = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
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
    String? photoURL;
    if (imageSubject.valueOrNull != null) {
      photoURL = await uploadProfilePhoto(imageSubject.value);
    }

    await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'name': nameController.text,
      'about': aboutController.text,
      'photo': photoURL,
    });

    await FirebaseAuth.instance.currentUser!.updateDisplayName(nameController.text);
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(photoURL);

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
