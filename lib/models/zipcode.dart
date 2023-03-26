
class ZipCode {
  static bool isValid(String zipCode) {
    bool isValid = RegExp(
        r"^[0-9]{3}[\-]{0,1}[0-9]{4}$",
        caseSensitive: false).hasMatch(zipCode);
    return isValid;
  }
  static String getWithoutHyphen(String zipCode) {
    String zipCodeWithoutHyphen = zipCode.replaceAll(RegExp(r'\-'), '');
    return zipCodeWithoutHyphen;
  }
}
