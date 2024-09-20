import 'package:firebase_first_app/utils/constants/padding_constants.dart';
import 'package:firebase_first_app/utils/constants/sized_box_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/users/users_cubit.dart';
import '../../widgets/global_profile_photo.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usersCubit = context.read<UsersCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is UsersSuccess) {
            final users = usersCubit.users?.docs ?? [];
            return ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, i) => SizedBoxConstants.h10,
              itemBuilder: (_, i) {
                final user = users[i].data();
                return ListTile(
                  leading: GlobalProfilePhoto(url: user['photo']),
                  title: Text(user['name']),
                  subtitle: Text(user['about']),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return Padding(
                padding: PaddingConstants.a20 +
                    EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: usersCubit.nameController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                    SizedBoxConstants.h16,
                    TextField(
                      controller: usersCubit.phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Phone',
                      ),
                    ),
                    SizedBoxConstants.h16,
                    TextField(
                      controller: usersCubit.photoController,
                      decoration: const InputDecoration(
                        hintText: 'Photo URL',
                      ),
                    ),
                    SizedBoxConstants.h16,
                    TextField(
                      controller: usersCubit.aboutController,
                      decoration: const InputDecoration(
                        hintText: 'About',
                      ),
                    ),
                    SizedBoxConstants.h16,
                    TextButton(
                      onPressed: () => usersCubit.addUsers(context),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
