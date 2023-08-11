// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhone extends StatelessWidget {
  FutureOr<String?> Function(PhoneNumber?)? valid;
  String? text;
  void Function(PhoneNumber)? onChange;
  Widget? prefixIcon;
  CustomPhone({
    Key? key,
    this.valid,
    required this.text,
    this.onChange,
     this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        // if want make image or svg [prefixIcon] ,
        prefixIcon: prefixIcon,
        // SvgPicture.asset(Assets.imageSelectSpecialitySvgTrue),
        labelText: text,
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      initialCountryCode: 'EG',
      onChanged: onChange,
      //(phone) {print(phone.completeNumber); },
      validator: valid,
    );
  }
}
