import 'package:flutter/material.dart';

extension PluginSizedBox on num {
  get gh => SizedBox(
        height: toDouble(),
      );
  get gW => SizedBox(
        width: toDouble(),
      );
}
