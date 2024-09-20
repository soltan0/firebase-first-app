import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/screens.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? _verificationId;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  void signIn(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Screens.verification(context),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verify(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otpController.text,
    );

    final userCredential = await auth.signInWithCredential(credential);
    await _createUserCollectionForUser(userCredential).then((v) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screens.editProfile,
        ),
      );
    }).catchError((e) {
      log('$e');
    });
  }

  Future<void> _createUserCollectionForUser(
    UserCredential userCredential,
  ) async {
    final user = userCredential.user!;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
      {
        'id': user.uid,
        'name': user.displayName,
        'phone': user.phoneNumber,
        'photo': user.photoURL,
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    otpController.dispose();
    return super.close();
  }
}
