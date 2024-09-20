import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';
import '../cubits/edit_profile/edit_profile_cubit.dart';
import '../cubits/pinput/pinput_cubit.dart';
import '../cubits/users/users_cubit.dart';
import '../data/services/users_service.dart';
import '../ui/screens/auth/user_auth.dart';
import '../ui/screens/profile/edit_profile_screen.dart';
import '../ui/screens/users/users_screen.dart';
import '../ui/screens/verification/verification.dart';

class Screens {
  Screens._();

  static Widget get users => BlocProvider(
        create: (context) => UsersCubit(UsersService())..getUsers(),
        child: const UsersScreen(),
      );

  static Widget verification(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<AuthCubit>()),
          BlocProvider(create: (_) => PinputCubit()),
        ],
        child: const Verification(),
      );

  static Widget get editProfile => BlocProvider(
        create: (_) => EditProfileCubit()..getCurrentUserData(),
        child: const EditProfileScreen(),
      );

  static Widget get userAuth => BlocProvider(
        create: (_) => AuthCubit(),
        child: const UsersAuth(),
      );

  static Widget get initial => StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Screens.userAuth;
          } else if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          final user = snapshot.data;
          return user != null ? Screens.users : Screens.userAuth;
        },
      );
}
