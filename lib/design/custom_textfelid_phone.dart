// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhone extends StatelessWidget {
  final FutureOr<String?> Function(PhoneNumber?)? valid;
  final String? text;
  final void Function(PhoneNumber)? onChange;
  final Widget? prefixIcon;
  const CustomPhone({
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
