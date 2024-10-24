import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  BuildContext? get parent => parentContext;
  BuildContext? get parentContext => parent != null ? parent!.parentContext : null;
  BuildContext? get parentParentContext => parent != null ? parent!.parentContext?.parentContext : null;

}
class XBC {
  static final XBC _instance = XBC._internal();
  factory XBC() => _instance;
  XBC._internal();

  BuildContext? get parent => parentContext;
  BuildContext? get parentContext => parent != null ? parent!.parentContext : null;
 static XBC co =  XBC();
}