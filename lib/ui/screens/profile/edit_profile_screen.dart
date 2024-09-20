import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/edit_profile/edit_profile_cubit.dart';
import '../../widgets/global_profile_photo.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const GlobalProfilePhoto(radius: 80),
                  const SizedBox(height: 24),
                  TextField(
                    controller: cubit.nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter name',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: cubit.aboutController,
                    decoration: const InputDecoration(
                      hintText: 'Enter about',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => cubit.updateProfile(context),
                    child: const Text('Continue'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
