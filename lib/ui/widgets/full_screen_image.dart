import 'package:flutter/material.dart';

import '../../constants/asset_constants.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({
    super.key,
    this.url,
  });

  final String? url;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Profile Photo')),
        ),
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Hero(
                tag: url ?? AssetConstants.defaultAvatar,
                child: Material(
                  color: Colors.transparent,
                  child: url != null
                      ? Image.network(
                          url!,
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          AssetConstants.defaultAvatar,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
          ),
        ));
  }
}
