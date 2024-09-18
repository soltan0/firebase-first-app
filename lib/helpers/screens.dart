import 'package:firebase_first_app/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  static Widget get editProfile => const EditProfileScreen();

  static Widget get userAuth => BlocProvider(
        create: (_) => AuthCubit(),
        child: const UsersAuth(),
      );
}
