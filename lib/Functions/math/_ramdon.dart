import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

String randomString(int length) {
  var r = Random();
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  var stringWithoutNumber =
  List.generate(length, (index) => chars[r.nextInt(chars.length)]).join();
  return stringWithoutNumber;
}

String randomStringWithNumber(int length) {
  var r = Random();
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
  var stringWithNumber =
  List.generate(length, (index) => chars[r.nextInt(chars.length)]).join();
  return stringWithNumber;
}

int randomInt(int max) {
  var r = Random();
  return r.nextInt(max);
}

Key randomKey() {
  return Key(randomString(10));
}

String randomBase64(int len) {
  // random base64
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  var base64 = base64UrlEncode(values);
  return base64;
}