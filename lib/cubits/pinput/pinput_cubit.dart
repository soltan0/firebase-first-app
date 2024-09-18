import 'package:flutter_bloc/flutter_bloc.dart';

class PinputCubit extends Cubit<String> {
  PinputCubit() : super('');

  void otpChanged(String otp) {
    emit(otp);
  }
}
