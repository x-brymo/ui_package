import 'package:flutter/material.dart';

extension PluginSizedBox on num {
  get gh => SizedBox(
        height: toDouble(),
      );
  get gW => SizedBox(
        width: toDouble(),
      );
}
extension QueryPlugin on BuildContext{
  get heightScreen => MediaQuery.of(this).size.height;
  get widthScreen => MediaQuery.of(this).size.width;
}
Widget boxSizeHeightOnQuary(BuildContext context , double query ){
  return SizedBox(height: context.heightScreen / query,);
}
Widget boxSizeWidthOnQuary(BuildContext context , double query ){
  return SizedBox(width: context.widthScreen / query,);
}
Widget boxSizeHeightInQuary(BuildContext context , double query ){
  return SizedBox(height: context.heightScreen * query,);
}
Widget boxSizeWidthInQuary(BuildContext context , double query ){
  return SizedBox(width: context.widthScreen * query,);
}
extension GetHeightAndWidthBox on num{
  get getHeight=>SizedBox(height: toDouble(),);
  get getWidth=>SizedBox(width: toDouble(),);
}