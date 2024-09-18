import 'package:flutter/material.dart';

class UsersAuth extends StatelessWidget {
  const UsersAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Telefon Nomrenizi Daxil Edin',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Daxil Edin',
            ),
          ),
          const SizedBox(height: 16),
          TextButton(onPressed: () {}, child: const Text('Əlavə Et'))
        ],
      ),
    );
  }
}
