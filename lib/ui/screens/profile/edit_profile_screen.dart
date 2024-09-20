import 'package:firebase_first_app/utils/constants/padding_constants.dart';
import 'package:firebase_first_app/utils/constants/sized_box_constant.dart';
import 'package:flutter/material.dart';

import '../../widgets/global_profile_photo.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PaddingConstants.h24,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const GlobalProfilePhoto(radius: 80),
              SizedBoxConstants.h24,
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter namer',
                ),
              ),
              SizedBoxConstants.h16,
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter about',
                ),
              ),
              SizedBoxConstants.h16,
              TextButton(
                onPressed: () {},
                child: const Text('Continue'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
