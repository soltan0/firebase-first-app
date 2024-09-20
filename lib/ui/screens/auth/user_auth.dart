import 'package:firebase_first_app/utils/constants/sized_box_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/auth/auth_cubit.dart';

class UsersAuth extends StatelessWidget {
  const UsersAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter your phone number',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBoxConstants.h20,
              TextField(
                controller: cubit.phoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                ),
              ),
              SizedBoxConstants.h16,
              TextButton(
                onPressed: () => cubit.signIn(context),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
