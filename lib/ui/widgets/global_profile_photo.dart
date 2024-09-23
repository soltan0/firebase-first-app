import 'dart:io';

import 'package:flutter/material.dart';
import '../../constants/asset_constants.dart';

class GlobalProfilePhoto extends StatelessWidget {
  const GlobalProfilePhoto({
    super.key,
    this.url,
    this.file,
    this.radius = 24,
    this.onPressed,
    this.isEditable = false,
  });

  final String? url;
  final File? file;
  final double radius;
  final VoidCallback? onPressed;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: const AssetImage(AssetConstants.defaultAvatar),
          foregroundImage: url != null
              ? NetworkImage(url!)
              : file != null
                  ? FileImage(file!)
                  : const AssetImage(AssetConstants.defaultAvatar),
          child: const SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
        if (isEditable)
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(
                Icons.add_circle,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: onPressed,
            ),
          ),
      ],
    );
  }
}
