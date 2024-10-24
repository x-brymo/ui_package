String toSnakeCase(String str) {
  final StringBuffer snakeCase = StringBuffer();

  for (int i = 0; i < str.length; i++) {
    // 숫자인 경우 체크
    bool isDigit = RegExp(r'\d').hasMatch(str[i]);

    // 현재 문자가 대문자이고, 첫 번째 문자가 아니며, 숫자가 아닐 경우 밑줄 추가
    if (str[i].toUpperCase() == str[i] && i > 0 && !isDigit) {
      snakeCase.write('_');
    }
    // 현재 문자를 소문자로 변환하여 추가
    snakeCase.write(str[i].toLowerCase());
  }

  return snakeCase.toString();
}

String toCamelCase(String str) {
  // Split the string by underscores.
  List<String> parts = str.split('_');

  // Capitalize the first letter of each part except the first one,
  // and concatenate them back into a single string.
  String camelCase = parts[0].toLowerCase();
  for (int i = 1; i < parts.length; i++) {
    // Capitalize the first letter of the current part and add it to the result.
    camelCase += parts[i].substring(0, 1).toUpperCase() +
        parts[i].substring(1).toLowerCase();
  }

  return camelCase;
}