class ZipCode {
  static bool isValid(String zipCode) {
    bool isValid = RegExp(r"^[0-9]{3}[\-]{0,1}[0-9]{4}$", caseSensitive: false)
        .hasMatch(zipCode);
    return isValid;
  }

  static String getWithoutHyphen(String zipCode) {
    String zipCodeWithoutHyphen = zipCode.replaceAll(RegExp(r'\-'), '');
    return zipCodeWithoutHyphen;
  }

  static String getWithHyphen(String zipCode) {
    if (zipCode.contains('-')) {
      return zipCode;
    }

    String hyphenInserted =
        '${zipCode.substring(0, 3)}-${zipCode.substring(3)}';
    return hyphenInserted;
  }
}
