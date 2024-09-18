import 'package:flutter/material.dart';

import '../../constants/asset_constants.dart';

class GlobalProfilePhoto extends StatelessWidget {
  const GlobalProfilePhoto({
    super.key,
    this.url,
    this.radius = 24,
  });

  final String? url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: const AssetImage(AssetConstants.defaultAvatar),
      foregroundImage: url != null
          ? NetworkImage(url!)
          : const AssetImage(AssetConstants.defaultAvatar),
      child: const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
