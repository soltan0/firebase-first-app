import 'package:firebase_first_app/utils/constants/padding_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../cubits/auth/auth_cubit.dart';
import '../../../cubits/pinput/pinput_cubit.dart';
import '../../../utils/constants/sized_box_constant.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: BlocBuilder<PinputCubit, String>(
        builder: (context, otp) {
          return Center(
            child: Padding(
              padding: PaddingConstants.a16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
                    length: 6,
                    controller: cubit.otpController,
                    onChanged: (value) {
                      context.read<PinputCubit>().otpChanged(value);
                    },
                  ),
                  SizedBoxConstants.h20,
                  ElevatedButton(
                    onPressed:
                        otp.length == 6 ? () => cubit.verify(context) : null,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
