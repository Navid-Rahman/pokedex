import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PokeDexLoader extends StatelessWidget {
  final Color? color;
  final double size;

  const PokeDexLoader({
    super.key,
    this.color,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).primaryColor;

    return SizedBox(
      width: size,
      height: size,
      child: Platform.isIOS
          ? CupertinoActivityIndicator(
              color: color ?? defaultColor,
            )
          : CircularProgressIndicator(
              strokeWidth: 2,
              color: color ?? defaultColor,
            ),
    );
  }
}
