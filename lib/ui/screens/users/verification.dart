import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../cubits/pinput/pinput_cubit.dart';
import '../../widgets/global_profile_photo.dart'; 
class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: BlocBuilder<PinputCubit, String>(
        builder: (context, otp) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
                    length: 4,
                    onChanged: (value) {
                      context.read<PinputCubit>().otpChanged(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: otp.length == 4
                        ? () {
                            print('OTP entered: $otp');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GlobalProfilePhoto(),
                              ),
                            );
                          }
                        : null, 
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
